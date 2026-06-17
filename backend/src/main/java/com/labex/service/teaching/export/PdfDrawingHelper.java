package com.labex.service.teaching.export;

import lombok.extern.slf4j.Slf4j;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDFont;
import org.apache.pdfbox.pdmodel.font.PDType0Font;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;

import java.awt.Color;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * PDF 绘制公共工具（CTL-Export）
 * 提供中文字体加载、文本绘制、自动换行、表格绘制、自动分页能力。
 */
@Component
@Slf4j
public class PdfDrawingHelper {

    public static final float PAGE_LEFT = 50f;
    public static final float PAGE_RIGHT = 545f;
    public static final float PAGE_TOP = 800f;
    public static final float PAGE_BOTTOM = 50f;
    public static final float CONTENT_WIDTH = PAGE_RIGHT - PAGE_LEFT;

    private PDFont cachedChineseFont;
    private PDFont cachedFallback;

    /**
     * 加载中文字体（多路径回退）。同一进程内会自动复用。
     */
    public PDFont loadChineseFont(PDDocument doc) {
        // classpath 候选
        String[] classpathFonts = {
                "fonts/NotoSansCJKsc-Regular.otf",
                "fonts/SourceHanSansCN-Normal.ttf",
                "fonts/simsun.ttf"
        };
        // 系统字体回退 (按平台顺序：Windows / Linux / macOS)
        String[] systemFonts = {
                "C:/Windows/Fonts/msyh.ttc",
                "C:/Windows/Fonts/msyhbd.ttc",
                "C:/Windows/Fonts/simhei.ttf",
                "C:/Windows/Fonts/simsun.ttc",
                // Linux — Debian/Ubuntu
                "/usr/share/fonts/truetype/wqy/wqy-microhei.ttc",
                "/usr/share/fonts/truetype/wqy/wqy-zenhei.ttc",
                // Linux — CentOS/RHEL
                "/usr/share/fonts/wqy-zenhei/wqy-zenhei.ttc",
                // Linux — Noto CJK (多种安装位置)
                "/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc",
                "/usr/share/fonts/truetype/noto/NotoSansCJK-Regular.ttc",
                "/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
                "/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc",
                // macOS
                "/System/Library/Fonts/PingFang.ttc",
                "/Library/Fonts/Songti.ttc",
                "/System/Library/Fonts/STHeiti Medium.ttc",
                // Linux — 通用兜底
                "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"
        };
        for (String path : classpathFonts) {
            try {
                Resource r = new ClassPathResource(path);
                if (r.exists() && r.contentLength() > 1000) {
                    return PDType0Font.load(doc, r.getInputStream(), true);
                }
            } catch (Exception ignored) {
            }
        }
        for (String path : systemFonts) {
            File f = new File(path);
            if (f.exists()) {
                try (FileInputStream fis = new FileInputStream(f)) {
                    return PDType0Font.load(doc, fis, true);
                } catch (Exception e) {
                    log.debug("Failed loading system font {}: {}", path, e.getMessage());
                }
            }
        }
        log.warn("No Chinese font found, PDF will use Helvetica (Chinese chars become boxes)");
        return PDType1Font.HELVETICA;
    }

    /**
     * 简单单行文本绘制（不换行，超长截断）。返回下一行的 y 坐标。
     */
    public float drawText(PDPageContentStream cs, String text, float x, float y,
                           float fontSize, PDFont font) throws IOException {
        if (text == null) text = "";
        cs.beginText();
        cs.setFont(font, fontSize);
        cs.newLineAtOffset(x, y);
        cs.showText(sanitize(text, font));
        cs.endText();
        return y - fontSize - 4;
    }

    /**
     * 自动换行的文本绘制（按最大宽度切分，按字符宽度估算）
     * 返回下一行 y 坐标
     */
    public float drawWrappedText(PDPageContentStream cs, String text, float x, float y,
                                  float maxWidth, float fontSize, float lineHeight, PDFont font) throws IOException {
        if (text == null || text.isEmpty()) return y - lineHeight;
        List<String> lines = wrapLines(text, maxWidth, fontSize, font);
        for (String line : lines) {
            cs.beginText();
            cs.setFont(font, fontSize);
            cs.newLineAtOffset(x, y);
            cs.showText(sanitize(line, font));
            cs.endText();
            y -= lineHeight;
        }
        return y;
    }

    /**
     * 章节标题（粗，带下划线效果）
     */
    public float drawSectionTitle(PDPageContentStream cs, String title, float x, float y,
                                   PDFont font) throws IOException {
        cs.setNonStrokingColor(new Color(33, 90, 160));
        cs.beginText();
        cs.setFont(font, 13);
        cs.newLineAtOffset(x, y);
        cs.showText(sanitize(title, font));
        cs.endText();
        cs.setNonStrokingColor(Color.BLACK);
        // 下划线
        cs.setStrokingColor(new Color(33, 90, 160));
        cs.moveTo(x, y - 4);
        cs.lineTo(PAGE_RIGHT, y - 4);
        cs.stroke();
        cs.setStrokingColor(Color.BLACK);
        return y - 24;
    }

    /**
     * 简单表格绘制（二维 String 数组 + 列宽数组）
     * 返回最后一行下方的 y 坐标
     */
    public float drawTable(PDPageContentStream cs, String[][] data, float[] colWidths,
                            float x, float y, float minRowHeight, float fontSize, PDFont font) throws IOException {
        if (data == null || data.length == 0) return y;
        float totalWidth = 0;
        for (float w : colWidths) totalWidth += w;

        for (int r = 0; r < data.length; r++) {
            String[] row = data[r];
            // 估算行高：取该行所有单元格中需要的最大行数
            int maxLines = 1;
            for (int c = 0; c < row.length && c < colWidths.length; c++) {
                int lines = wrapLines(row[c] == null ? "" : row[c],
                        colWidths[c] - 6, fontSize, font).size();
                if (lines > maxLines) maxLines = lines;
            }
            float rowHeight = Math.max(minRowHeight, maxLines * (fontSize + 2) + 6);

            // 描边
            cs.setStrokingColor(new Color(180, 180, 180));
            cs.addRect(x, y - rowHeight, totalWidth, rowHeight);
            cs.stroke();

            // 单元格分隔线
            float xOffset = x;
            for (int c = 0; c < colWidths.length; c++) {
                if (c > 0) {
                    cs.moveTo(xOffset, y);
                    cs.lineTo(xOffset, y - rowHeight);
                    cs.stroke();
                }
                // 写入文字
                if (c < row.length) {
                    drawWrappedText(cs, row[c] == null ? "" : row[c],
                            xOffset + 3, y - fontSize - 2,
                            colWidths[c] - 6, fontSize, fontSize + 2, font);
                }
                xOffset += colWidths[c];
            }
            cs.setStrokingColor(Color.BLACK);
            y -= rowHeight;
        }
        return y - 8;
    }

    /**
     * 按需翻页：如果 currentY 已低于 minY，则关闭当前流，创建新页并返回 [newPage, newStream, newY]
     */
    public PageStream ensureSpace(PDDocument doc, PDPageContentStream cs, PDPage currentPage,
                                   float currentY, float requiredHeight, PDFont font) throws IOException {
        if (currentY - requiredHeight >= PAGE_BOTTOM) {
            return new PageStream(currentPage, cs, currentY);
        }
        cs.close();
        PDPage newPage = new PDPage(PDRectangle.A4);
        doc.addPage(newPage);
        PDPageContentStream newCs = new PDPageContentStream(doc, newPage);
        return new PageStream(newPage, newCs, PAGE_TOP);
    }

    /**
     * 把字符串按字体宽度切分为多行
     */
    public List<String> wrapLines(String text, float maxWidth, float fontSize, PDFont font) {
        List<String> lines = new ArrayList<>();
        if (text == null || text.isEmpty()) {
            lines.add("");
            return lines;
        }
        StringBuilder current = new StringBuilder();
        for (char ch : text.toCharArray()) {
            if (ch == '\n') {
                lines.add(current.toString());
                current = new StringBuilder();
                continue;
            }
            current.append(ch);
            try {
                float w = font.getStringWidth(sanitize(current.toString(), font)) / 1000f * fontSize;
                if (w > maxWidth) {
                    current.deleteCharAt(current.length() - 1);
                    if (current.length() > 0) lines.add(current.toString());
                    current = new StringBuilder().append(ch);
                }
            } catch (Exception ignored) {
            }
        }
        if (current.length() > 0) lines.add(current.toString());
        return lines;
    }

    /**
     * 移除/替换字体不支持的字符（避免 PDFBox 报错）
     */
    public String sanitize(String text, PDFont font) {
        if (text == null) return "";
        if (!(font instanceof PDType0Font)) {
            // Helvetica 等内置字体不支持中文，替换为占位
            return text.replaceAll("[^\\x00-\\x7F]", "?");
        }
        // PDType0Font 支持 unicode，但仍可能有少量字符不在字体表中
        StringBuilder sb = new StringBuilder();
        for (char ch : text.toCharArray()) {
            try {
                font.getStringWidth(String.valueOf(ch));
                sb.append(ch);
            } catch (Exception e) {
                sb.append(' ');
            }
        }
        return sb.toString();
    }

    /** 标题居中 */
    public float drawCenteredTitle(PDPageContentStream cs, String title, float y,
                                    float fontSize, PDFont font) throws IOException {
        String safe = sanitize(title, font);
        float textWidth = font.getStringWidth(safe) / 1000f * fontSize;
        float x = PAGE_LEFT + (CONTENT_WIDTH - textWidth) / 2;
        cs.beginText();
        cs.setFont(font, fontSize);
        cs.newLineAtOffset(x, y);
        cs.showText(safe);
        cs.endText();
        return y - fontSize - 8;
    }

    public record PageStream(PDPage page, PDPageContentStream stream, float y) {}
}
