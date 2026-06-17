package com.labex.util;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * 一次性工具：解析 Class-docs 3 个模板的完整结构，输出到 /tmp/classdocs-parse.txt
 * 解析完成后可删除
 */
public class ParseClassDocs {
    public static void main(String[] args) throws Exception {
        Path base = Paths.get("D:/workfordasan/Class-docs");
        Path out = Paths.get("D:/Users/35475/AppData/Local/Temp/opencode/classdocs-parse.txt");
        Files.deleteIfExists(out);
        StringBuilder sb = new StringBuilder();

        // 找文件
        File[] files = base.toFile().listFiles();
        if (files == null) return;
        for (File f : files) {
            sb.append("\n\n========== FILE: ").append(f.getName()).append(" ==========\n");
            String n = f.getName();
            if (n.toLowerCase().endsWith(".pdf")) {
                parsePdf(f, sb);
            } else if (n.toLowerCase().endsWith(".xlsx")) {
                parseXlsx(f, sb);
            }
        }
        Files.writeString(out, sb.toString());
        System.out.println("DONE: " + out + " (" + sb.length() + " chars)");
    }

    static void parsePdf(File f, StringBuilder sb) throws Exception {
        try (PDDocument doc = PDDocument.load(f)) {
            PDFTextStripper stripper = new PDFTextStripper();
            stripper.setSortByPosition(true);
            int pages = doc.getNumberOfPages();
            sb.append("PDF pages: ").append(pages).append("\n");
            for (int i = 1; i <= pages; i++) {
                stripper.setStartPage(i);
                stripper.setEndPage(i);
                sb.append("\n--- PAGE ").append(i).append(" ---\n");
                sb.append(stripper.getText(doc));
            }
        }
    }

    static void parseXlsx(File f, StringBuilder sb) throws Exception {
        try (XSSFWorkbook wb = new XSSFWorkbook(Files.newInputStream(f.toPath()))) {
            int sheets = wb.getNumberOfSheets();
            sb.append("XLSX sheets: ").append(sheets).append("\n");
            for (int s = 0; s < sheets; s++) {
                var sheet = wb.getSheetAt(s);
                sb.append("\n--- SHEET[").append(s).append("]: ").append(sheet.getSheetName()).append(" ---\n");
                int lastRow = sheet.getLastRowNum();
                sb.append("lastRow: ").append(lastRow).append("\n");
                for (int r = 0; r <= lastRow; r++) {
                    var row = sheet.getRow(r);
                    if (row == null) { sb.append("Row ").append(r).append(": <null>\n"); continue; }
                    sb.append("Row ").append(r).append(" (h=").append(row.getHeight()).append("): ");
                    int last = row.getLastCellNum();
                    for (int c = 0; c < last; c++) {
                        var cell = row.getCell(c);
                        if (cell == null) { sb.append("[null]"); }
                        else {
                            String v;
                            switch (cell.getCellType()) {
                                case STRING -> v = "\"" + cell.getStringCellValue() + "\"";
                                case NUMERIC -> v = String.valueOf(cell.getNumericCellValue());
                                case BOOLEAN -> v = String.valueOf(cell.getBooleanCellValue());
                                case FORMULA -> v = "FORMULA=" + cell.getCellFormula();
                                case BLANK -> v = "[blank]";
                                default -> v = "?";
                            }
                            // 合并单元格信息
                            if (cell.getCellStyle() != null) {
                                sb.append("[").append(excelCol(c)).append("=").append(v).append("]");
                            } else {
                                sb.append("[").append(excelCol(c)).append("=").append(v).append("]");
                            }
                        }
                        if (c < last - 1) sb.append(" | ");
                    }
                    sb.append("\n");
                }
                // 合并单元格
                int merged = sheet.getNumMergedRegions();
                sb.append("Merged regions: ").append(merged).append("\n");
                for (int m = 0; m < merged; m++) {
                    var reg = sheet.getMergedRegion(m);
                    sb.append("  merged: R").append(reg.getFirstRow()).append("C").append(excelCol(reg.getFirstColumn()))
                            .append(" - R").append(reg.getLastRow()).append("C").append(excelCol(reg.getLastColumn()))
                            .append("\n");
                }
            }
        }
    }

    static String excelCol(int c) {
        StringBuilder s = new StringBuilder();
        c++;
        while (c > 0) {
            c--;
            s.insert(0, (char) ('A' + c % 26));
            c /= 26;
        }
        return s.toString();
    }
}
