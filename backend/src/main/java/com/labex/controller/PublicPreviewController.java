package com.labex.controller;

import com.labex.entity.Lecture;
import com.labex.service.LectureService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.hslf.usermodel.HSLFSlideShow;
import org.apache.poi.sl.draw.Drawable;
import org.apache.poi.sl.usermodel.Shape;
import org.apache.poi.sl.usermodel.Slide;
import org.apache.poi.sl.usermodel.SlideShow;
import org.apache.poi.sl.usermodel.TextParagraph;
import org.apache.poi.sl.usermodel.TextRun;
import org.apache.poi.sl.usermodel.TextShape;
import org.apache.poi.xslf.usermodel.XMLSlideShow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.FontFormatException;
import java.awt.Graphics2D;
import java.awt.GraphicsEnvironment;
import java.awt.RenderingHints;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

@RestController
@RequestMapping("/preview")
@Slf4j
public class PublicPreviewController {

    @Autowired
    private LectureService lectureService;

    @Value("${upload-path:uploads}")
    private String uploadDir;

    @Value("${preview-ppt-dir:.preview/ppt}")
    private String previewPptDir;

    @Value("${preview-ppt-font-dir:fonts}")
    private String previewPptFontDir;

    private static final String PREVIEW_RENDER_VERSION = "v5";
    private static final String CHINESE_GLYPH_SAMPLE = "\u5B9E\u9A8C\u6559\u5B66\u9898\u5E93\u4F5C\u4E1A\u8003\u8BD5";
    private static final int MAX_DEBUG_TEXT_PREVIEW = 180;
    private static final int MAX_DEBUG_RUNS_PER_SLIDE = 24;

    @GetMapping("/lecture/{id}")
    public void previewLecture(@PathVariable Integer id, HttpServletResponse response) {
        Lecture lecture = lectureService.getById(id);
        if (lecture == null) {
            writeError(response, "\u8BB2\u4E49\u4E0D\u5B58\u5728");
            return;
        }

        String filePath = lecture.getFilePath();
        if (filePath == null || filePath.isEmpty()) {
            writeError(response, "\u6587\u4EF6\u8DEF\u5F84\u4E0D\u5B58\u5728");
            return;
        }

        File file = new File(getUploadPath() + filePath);
        if (!file.exists()) {
            writeError(response, "\u6587\u4EF6\u4E0D\u5B58\u5728: " + file.getAbsolutePath());
            return;
        }

        String fileType = resolveFileType(lecture);
        String fileName = lecture.getLectureName() + "." + fileType;

        if (isPreviewableInline(fileType)) {
            serveFileInline(response, file, fileName, fileType);
        } else {
            serveFileAsAttachment(response, file, fileName, fileType);
        }
    }

    @GetMapping("/homework/{id}")
    public void previewHomework(@PathVariable Integer id, HttpServletResponse response) {
        writeError(response, "\u4F5C\u4E1A\u9884\u89C8\u529F\u80FD\u5F00\u53D1\u4E2D");
    }

    @GetMapping("/lecture/{id}/slides")
    public ResponseEntity<Map<String, Object>> lectureSlides(
            @PathVariable Integer id,
            @RequestParam(value = "debug", required = false, defaultValue = "false") boolean debug) {
        Lecture lecture = lectureService.getById(id);
        if (lecture == null) {
            return ResponseEntity.badRequest().body(Map.of("code", 500, "msg", "\u8BB2\u4E49\u4E0D\u5B58\u5728"));
        }

        String fileType = resolveFileType(lecture);
        if (!"ppt".equals(fileType) && !"pptx".equals(fileType)) {
            return ResponseEntity.badRequest().body(Map.of("code", 500, "msg", "\u8BE5\u8BB2\u4E49\u4E0D\u662FPPT\u6587\u4EF6"));
        }

        File sourceFile = resolveLectureFile(lecture);
        if (!sourceFile.exists()) {
            return ResponseEntity.badRequest().body(Map.of("code", 500, "msg", "\u8BB2\u4E49\u6587\u4EF6\u4E0D\u5B58\u5728"));
        }

        try {
            Path cacheDir = buildSlideCache(sourceFile, fileType, id);
            List<Map<String, Object>> slides = new ArrayList<>();
            int idx = 1;
            while (true) {
                Path img = cacheDir.resolve("slide-" + idx + ".png");
                if (!Files.exists(img)) {
                    break;
                }
                slides.add(Map.of(
                        "index", idx,
                        "url", "/api/preview/lecture/" + id + "/slides/" + idx,
                        "name", "\u7B2C" + idx + "\u9875"
                ));
                idx++;
            }

            Map<String, Object> data = new HashMap<>();
            data.put("lectureId", id);
            data.put("total", slides.size());
            data.put("slides", slides);
            data.put("renderVersion", PREVIEW_RENDER_VERSION);

            if (debug) {
                try {
                    Map<String, Object> debugInfo = buildPptDebugInfo(id, sourceFile, fileType, cacheDir);
                    data.put("debug", debugInfo);
                    log.info(
                            "PPT debug requested: lectureId={}, slides={}, fallbackFont={}, missingFontsOnFirstSlide={}",
                            id,
                            slides.size(),
                            debugInfo.getOrDefault("fallbackFont", ""),
                            extractFirstSlideMissingFonts(debugInfo)
                    );
                } catch (Exception debugEx) {
                    data.put("debugError", "build_debug_failed");
                    log.warn("Build ppt debug info failed but preview continues, lectureId={}", id, debugEx);
                }
            }

            return ResponseEntity.ok(Map.of("code", 200, "msg", "ok", "data", data));
        } catch (Exception e) {
            log.error("Build ppt preview failed, lectureId={}", id, e);
            return ResponseEntity.internalServerError().body(Map.of("code", 500, "msg", "PPT\u9884\u89C8\u751F\u6210\u5931\u8D25"));
        }
    }

    @GetMapping("/lecture/{id}/slides/debug")
    public ResponseEntity<Map<String, Object>> lectureSlidesDebug(@PathVariable Integer id) {
        Lecture lecture = lectureService.getById(id);
        if (lecture == null) {
            return ResponseEntity.badRequest().body(Map.of("code", 500, "msg", "\u8BB2\u4E49\u4E0D\u5B58\u5728"));
        }

        String fileType = resolveFileType(lecture);
        if (!"ppt".equals(fileType) && !"pptx".equals(fileType)) {
            return ResponseEntity.badRequest().body(Map.of("code", 500, "msg", "\u8BE5\u8BB2\u4E49\u4E0D\u662FPPT\u6587\u4EF6"));
        }

        File sourceFile = resolveLectureFile(lecture);
        if (!sourceFile.exists()) {
            return ResponseEntity.badRequest().body(Map.of("code", 500, "msg", "\u8BB2\u4E49\u6587\u4EF6\u4E0D\u5B58\u5728"));
        }

        try {
            Path cacheDir = buildSlideCache(sourceFile, fileType, id);
            Map<String, Object> debugInfo = buildPptDebugInfo(id, sourceFile, fileType, cacheDir);
            return ResponseEntity.ok(Map.of("code", 200, "msg", "ok", "data", debugInfo));
        } catch (Exception e) {
            log.error("Build ppt debug info failed, lectureId={}", id, e);
            return ResponseEntity.internalServerError().body(Map.of("code", 500, "msg", "PPT\u8C03\u8BD5\u4FE1\u606F\u751F\u6210\u5931\u8D25"));
        }
    }

    @GetMapping("/lecture/{id}/slides/{slideIndex}")
    public void lectureSlideImage(@PathVariable Integer id, @PathVariable Integer slideIndex, HttpServletResponse response) {
        if (slideIndex == null || slideIndex <= 0) {
            writeError(response, "\u9875\u7801\u4E0D\u5408\u6CD5");
            return;
        }

        Lecture lecture = lectureService.getById(id);
        if (lecture == null) {
            writeError(response, "\u8BB2\u4E49\u4E0D\u5B58\u5728");
            return;
        }

        String fileType = resolveFileType(lecture);
        if (!"ppt".equals(fileType) && !"pptx".equals(fileType)) {
            writeError(response, "\u8BE5\u8BB2\u4E49\u4E0D\u662FPPT\u6587\u4EF6");
            return;
        }

        File sourceFile = resolveLectureFile(lecture);
        if (!sourceFile.exists()) {
            writeError(response, "\u8BB2\u4E49\u6587\u4EF6\u4E0D\u5B58\u5728");
            return;
        }

        try {
            Path cacheDir = buildSlideCache(sourceFile, fileType, id);
            Path slideFile = cacheDir.resolve("slide-" + slideIndex + ".png");
            if (!Files.exists(slideFile)) {
                writeError(response, "\u5E7B\u706F\u7247\u4E0D\u5B58\u5728");
                return;
            }

            response.setContentType(MediaType.IMAGE_PNG_VALUE);
            response.setHeader("Cache-Control", "private, max-age=3600");
            response.setHeader("Content-Length", String.valueOf(Files.size(slideFile)));
            Files.copy(slideFile, response.getOutputStream());
            response.flushBuffer();
        } catch (Exception e) {
            log.error("Read ppt slide image failed, lectureId={}, slideIndex={}", id, slideIndex, e);
            writeError(response, "\u8BFB\u53D6\u5E7B\u706F\u7247\u5931\u8D25");
        }
    }

    private String getUploadPath() {
        if ((uploadDir != null && uploadDir.startsWith("/")) || (uploadDir != null && uploadDir.matches("^[a-zA-Z]:.*"))) {
            return uploadDir.endsWith(File.separator) ? uploadDir : uploadDir + File.separator;
        }
        return System.getProperty("user.dir") + File.separator + uploadDir + File.separator;
    }

    private String resolveFileType(Lecture lecture) {
        String byField = normalizeFileType(lecture != null ? lecture.getLectureFiletype() : null);
        if (!byField.isEmpty()) {
            return byField;
        }

        String filePath = lecture != null ? lecture.getFilePath() : null;
        if (filePath == null || filePath.isEmpty()) {
            return "";
        }

        String normalized = filePath;
        int queryIndex = normalized.indexOf('?');
        if (queryIndex >= 0) {
            normalized = normalized.substring(0, queryIndex);
        }
        int hashIndex = normalized.indexOf('#');
        if (hashIndex >= 0) {
            normalized = normalized.substring(0, hashIndex);
        }

        int dotIndex = normalized.lastIndexOf('.');
        if (dotIndex < 0 || dotIndex == normalized.length() - 1) {
            return "";
        }
        return normalizeFileType(normalized.substring(dotIndex + 1));
    }

    private String normalizeFileType(String fileType) {
        if (fileType == null) {
            return "";
        }

        String normalized = fileType.trim().toLowerCase(Locale.ROOT);
        if (normalized.isEmpty()) {
            return "";
        }

        if (normalized.startsWith(".")) {
            normalized = normalized.substring(1);
        }

        int semicolonIndex = normalized.indexOf(';');
        if (semicolonIndex >= 0) {
            normalized = normalized.substring(0, semicolonIndex);
        }

        return switch (normalized) {
            case "text/markdown" -> "md";
            case "text/html" -> "html";
            case "text/csv", "application/csv" -> "csv";
            case "application/vnd.ms-excel" -> "xls";
            case "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" -> "xlsx";
            default -> normalized;
        };
    }

    private boolean isPreviewableInline(String fileType) {
        return "pdf".equals(fileType)
                || "ppt".equals(fileType)
                || "pptx".equals(fileType)
                || "md".equals(fileType)
                || "markdown".equals(fileType)
                || "html".equals(fileType)
                || "htm".equals(fileType)
                || "csv".equals(fileType)
                || "tsv".equals(fileType)
                || "jpg".equals(fileType)
                || "jpeg".equals(fileType)
                || "png".equals(fileType)
                || "gif".equals(fileType)
                || "webp".equals(fileType)
                || "svg".equals(fileType);
    }

    private void serveFileInline(HttpServletResponse response, File file, String fileName, String fileType) {
        try {
            String contentType = getContentType(fileType);
            String encodedFileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8);

            response.setContentType(contentType);
            response.setHeader("Content-Disposition", "inline; filename=\"" + encodedFileName + "\"");
            response.setHeader("Content-Length", String.valueOf(file.length()));
            response.setHeader("X-Content-Type-Options", "nosniff");
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Expires", "0");
            response.setCharacterEncoding("UTF-8");

            try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
                 OutputStream os = response.getOutputStream()) {
                byte[] buffer = new byte[8192];
                int bytesRead;
                while ((bytesRead = bis.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
                os.flush();
            }
        } catch (IOException e) {
            log.error("Preview file failed, file={}", file.getAbsolutePath(), e);
        }
    }

    private void serveFileAsAttachment(HttpServletResponse response, File file, String fileName, String fileType) {
        try {
            String encodedFileName = URLEncoder.encode(fileName, StandardCharsets.UTF_8);

            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");
            response.setHeader("Content-Length", String.valueOf(file.length()));

            try (BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
                 OutputStream os = response.getOutputStream()) {
                byte[] buffer = new byte[8192];
                int bytesRead;
                while ((bytesRead = bis.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }
                os.flush();
            }
        } catch (IOException e) {
            log.error("Download file failed, fileType={}, file={}", fileType, file.getAbsolutePath(), e);
        }
    }

    private File resolveLectureFile(Lecture lecture) {
        return new File(getUploadPath() + lecture.getFilePath());
    }

    private Path buildSlideCache(File sourceFile, String fileType, Integer lectureId) throws IOException {
        Path root = Paths.get(
                getUploadPath(),
                previewPptDir,
                PREVIEW_RENDER_VERSION,
                String.valueOf(lectureId),
                String.valueOf(sourceFile.lastModified())
        );
        Files.createDirectories(root);

        Path marker = root.resolve(".done");
        if (Files.exists(marker)) {
            return root;
        }

        FontContext fontContext = resolveChineseFontContext();

        if ("ppt".equals(fileType)) {
            renderPptSlides(sourceFile, root, fontContext);
        } else {
            renderPptxSlides(sourceFile, root, fontContext);
        }

        Files.writeString(marker, "ok", StandardCharsets.UTF_8);
        return root;
    }

    private void renderPptxSlides(File sourceFile, Path outputDir, FontContext fontContext) throws IOException {
        try (FileInputStream fis = new FileInputStream(sourceFile);
             XMLSlideShow ppt = new XMLSlideShow(fis)) {
            renderSlidesToImages(ppt, ppt.getSlides(), outputDir, fontContext);
        }
    }

    private void renderPptSlides(File sourceFile, Path outputDir, FontContext fontContext) throws IOException {
        try (FileInputStream fis = new FileInputStream(sourceFile);
             HSLFSlideShow ppt = new HSLFSlideShow(fis)) {
            renderSlidesToImages(ppt, ppt.getSlides(), outputDir, fontContext);
        }
    }

    private void renderSlidesToImages(
            SlideShow<?, ?> slideShow,
            List<? extends Slide<?, ?>> slides,
            Path outputDir,
            FontContext fontContext) throws IOException {
        Dimension pageSize = slideShow.getPageSize();
        int width = Math.max(pageSize.width, 960);
        int height = Math.max(pageSize.height, 540);

        log.info(
                "PPT render start: slides={}, pageSize={}x{}, fallbackFont={}, externalFontsLoaded={}",
                slides.size(),
                pageSize.width,
                pageSize.height,
                fontContext.fallbackFont,
                fontContext.loadedExternalFonts.size()
        );

        int index = 1;
        for (Slide<?, ?> slide : slides) {
            BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            Graphics2D graphics = image.createGraphics();
            try {
                graphics.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
                graphics.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
                graphics.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
                graphics.setRenderingHint(Drawable.FONT_MAP, fontContext.fontMap);
                graphics.setFont(new Font(fontContext.fallbackFont, Font.PLAIN, 18));
                graphics.setPaint(Color.WHITE);
                graphics.fill(new Rectangle2D.Float(0, 0, width, height));

                double sx = (double) width / pageSize.width;
                double sy = (double) height / pageSize.height;
                graphics.scale(sx, sy);

                slide.draw(graphics);
            } finally {
                graphics.dispose();
            }

            Path target = outputDir.resolve("slide-" + index + ".png");
            Path temp = outputDir.resolve("slide-" + index + ".tmp");
            try (ByteArrayOutputStream bos = new ByteArrayOutputStream()) {
                ImageIO.write(image, "png", bos);
                try (ByteArrayInputStream bis = new ByteArrayInputStream(bos.toByteArray())) {
                    Files.copy(bis, temp, StandardCopyOption.REPLACE_EXISTING);
                }
            }
            try {
                Files.move(temp, target, StandardCopyOption.REPLACE_EXISTING, StandardCopyOption.ATOMIC_MOVE);
            } catch (Exception ex) {
                Files.move(temp, target, StandardCopyOption.REPLACE_EXISTING);
            }
            index++;
        }
    }

    private FontContext resolveChineseFontContext() {
        List<String> loadedExternalFonts = loadExternalFonts();
        String[] installedFamiliesRaw = GraphicsEnvironment.getLocalGraphicsEnvironment().getAvailableFontFamilyNames();
        List<String> installedFamilies = new ArrayList<>(Arrays.asList(installedFamiliesRaw));
        Collections.sort(installedFamilies, String.CASE_INSENSITIVE_ORDER);

        Set<String> installedFamilyLower = new HashSet<>();
        for (String family : installedFamilies) {
            installedFamilyLower.add(family.toLowerCase(Locale.ROOT));
        }

        String fallback = pickFallbackFont(installedFamilies, installedFamilyLower);
        Font fallbackProbe = new Font(fallback, Font.PLAIN, 18);
        boolean fallbackCanDisplayChinese = fallbackProbe.canDisplayUpTo(CHINESE_GLYPH_SAMPLE) == -1;
        if (!fallbackCanDisplayChinese) {
            log.warn(
                    "Fallback font cannot fully display Chinese sample. fallbackFont={}, sample={}",
                    fallback,
                    CHINESE_GLYPH_SAMPLE
            );
        }

        Map<String, String> fontMap = buildFontAliasMap(fallback);
        log.info(
                "PPT font context ready: fallbackFont={}, installedFonts={}, loadedExternalFonts={}, fontAliasSize={}",
                fallback,
                installedFamilies.size(),
                loadedExternalFonts.size(),
                fontMap.size()
        );

        return new FontContext(fontMap, fallback, installedFamilies, installedFamilyLower, loadedExternalFonts);
    }

    private List<String> loadExternalFonts() {
        List<String> loaded = new ArrayList<>();
        for (Path fontDir : resolveFontDirectories()) {
            if (!Files.isDirectory(fontDir)) {
                continue;
            }
            log.info("Scan external font dir: {}", fontDir.toAbsolutePath());
            try (DirectoryStream<Path> stream = Files.newDirectoryStream(fontDir)) {
                for (Path file : stream) {
                    if (!Files.isRegularFile(file)) {
                        continue;
                    }
                    String lowerName = file.getFileName().toString().toLowerCase(Locale.ROOT);
                    if (!lowerName.endsWith(".ttf") && !lowerName.endsWith(".otf") && !lowerName.endsWith(".ttc")) {
                        continue;
                    }
                    String fontName = registerFontFile(file);
                    if (fontName != null && !fontName.isBlank()) {
                        loaded.add(fontName + " <- " + file.toAbsolutePath());
                    }
                }
            } catch (Exception e) {
                log.warn("Read external font directory failed: {}", fontDir.toAbsolutePath(), e);
            }
        }
        return loaded;
    }

    private List<Path> resolveFontDirectories() {
        Set<Path> candidates = new LinkedHashSet<>();
        Path configured = Paths.get(previewPptFontDir);
        if (configured.isAbsolute()) {
            candidates.add(configured.normalize());
        } else {
            Path cwd = Paths.get(System.getProperty("user.dir")).toAbsolutePath().normalize();
            candidates.add(cwd.resolve(previewPptFontDir).normalize());
            if (cwd.getParent() != null) {
                candidates.add(cwd.getParent().resolve(previewPptFontDir).normalize());
            }
            try {
                Path uploadPath = Paths.get(getUploadPath()).toAbsolutePath().normalize();
                if (uploadPath.getParent() != null) {
                    candidates.add(uploadPath.getParent().resolve(previewPptFontDir).normalize());
                }
            } catch (Exception ignored) {
                // ignore path resolution failure
            }
        }
        return new ArrayList<>(candidates);
    }

    private String registerFontFile(Path fontFile) {
        try (InputStream is = Files.newInputStream(fontFile)) {
            Font font = Font.createFont(Font.TRUETYPE_FONT, is);
            GraphicsEnvironment.getLocalGraphicsEnvironment().registerFont(font);
            return font.getFontName(Locale.ROOT);
        } catch (FontFormatException trTypeError) {
            try (InputStream is = Files.newInputStream(fontFile)) {
                Font font = Font.createFont(Font.TYPE1_FONT, is);
                GraphicsEnvironment.getLocalGraphicsEnvironment().registerFont(font);
                return font.getFontName(Locale.ROOT);
            } catch (Exception type1Error) {
                log.warn("Register font failed: {}", fontFile.toAbsolutePath());
                return null;
            }
        } catch (Exception ex) {
            log.warn("Register font failed: {}", fontFile.toAbsolutePath());
            return null;
        }
    }

    private String pickFallbackFont(List<String> installedFamilies, Set<String> installedFamilyLower) {
        String[] preferredFonts = new String[]{
                "Noto Sans CJK SC",
                "Noto Serif CJK SC",
                "Source Han Sans CN",
                "Source Han Serif CN",
                "Microsoft YaHei",
                "Microsoft YaHei UI",
                "Microsoft JhengHei",
                "SimHei",
                "SimSun",
                "KaiTi",
                "FangSong",
                "DengXian",
                "PingFang SC",
                "WenQuanYi Zen Hei"
        };
        for (String candidate : preferredFonts) {
            if (installedFamilyLower.contains(candidate.toLowerCase(Locale.ROOT))) {
                return candidate;
            }
        }
        for (String family : installedFamilies) {
            Font probe = new Font(family, Font.PLAIN, 18);
            if (probe.canDisplayUpTo(CHINESE_GLYPH_SAMPLE) == -1) {
                return family;
            }
        }
        return "SansSerif";
    }

    private Map<String, String> buildFontAliasMap(String fallbackFont) {
        Map<String, String> map = new LinkedHashMap<>();
        List<String> aliases = List.of(
                "Microsoft YaHei",
                "Microsoft YaHei UI",
                "Microsoft JhengHei",
                "SimHei",
                "SimSun",
                "KaiTi",
                "FangSong",
                "DengXian",
                "PingFang SC",
                "PingFang TC",
                "Noto Sans CJK SC",
                "Noto Serif CJK SC",
                "Source Han Sans CN",
                "Source Han Serif CN",
                "WenQuanYi Zen Hei",
                "Arial",
                "Calibri",
                "Times New Roman",
                "\u5FAE\u8F6F\u96C5\u9ED1",
                "\u5FAE\u8F6F\u96C5\u9ED1 Light",
                "\u5B8B\u4F53",
                "\u9ED1\u4F53",
                "\u6977\u4F53",
                "\u4EFF\u5B8B",
                "\u7B49\u7EBF",
                "\u7B49\u7EBF Light",
                "\u534E\u6587\u7EC6\u9ED1",
                "\u534E\u6587\u5B8B\u4F53",
                "\u534E\u6587\u4E2D\u5B8B",
                "\u534E\u6587\u6977\u4F53",
                "\u65B9\u6B63\u9ED1\u4F53",
                "\u65B9\u6B63\u4E66\u5B8B",
                "\u82F9\u65B9-\u7B80",
                "\u82F9\u65B9-\u7E41"
        );
        for (String alias : aliases) {
            map.put(alias, fallbackFont);
        }
        return map;
    }

    private Map<String, Object> buildPptDebugInfo(Integer lectureId, File sourceFile, String fileType, Path cacheDir) throws IOException {
        FontContext fontContext = resolveChineseFontContext();
        Map<String, Object> debug = new LinkedHashMap<>();
        debug.put("lectureId", lectureId);
        debug.put("sourceFile", sourceFile.getAbsolutePath());
        debug.put("sourceSize", Files.size(sourceFile.toPath()));
        debug.put("fileType", fileType);
        debug.put("cacheDir", cacheDir.toAbsolutePath().toString());
        debug.put("renderVersion", PREVIEW_RENDER_VERSION);
        debug.put("fallbackFont", fontContext.fallbackFont);
        debug.put("fallbackCanDisplayChinese", new Font(fontContext.fallbackFont, Font.PLAIN, 18).canDisplayUpTo(CHINESE_GLYPH_SAMPLE) == -1);
        debug.put("installedFontCount", fontContext.installedFontFamilies.size());
        debug.put("installedFontSample", fontContext.installedFontFamilies.stream().limit(24).toList());
        debug.put("loadedExternalFonts", fontContext.loadedExternalFonts);
        debug.put("fontAliasCount", fontContext.fontMap.size());

        if ("ppt".equals(fileType)) {
            debug.put("slides", collectSlidesDebugPpt(sourceFile, fontContext));
        } else {
            debug.put("slides", collectSlidesDebugPptx(sourceFile, fontContext));
        }
        return debug;
    }

    private Object extractFirstSlideMissingFonts(Map<String, Object> debugInfo) {
        Object slidesObj = debugInfo.get("slides");
        if (!(slidesObj instanceof List<?> slides) || slides.isEmpty()) {
            return Collections.emptyList();
        }
        Object first = slides.get(0);
        if (!(first instanceof Map<?, ?> firstMap)) {
            return Collections.emptyList();
        }
        Object missing = firstMap.get("missingFontsOnServer");
        return missing != null ? missing : Collections.emptyList();
    }

    private List<Map<String, Object>> collectSlidesDebugPptx(File sourceFile, FontContext fontContext) throws IOException {
        try (FileInputStream fis = new FileInputStream(sourceFile);
             XMLSlideShow ppt = new XMLSlideShow(fis)) {
            List<Map<String, Object>> slidesDebug = new ArrayList<>();
            int index = 1;
            for (Slide<?, ?> slide : ppt.getSlides()) {
                slidesDebug.add(collectSlideTextDebug(slide, index, fontContext));
                index++;
            }
            return slidesDebug;
        }
    }

    private List<Map<String, Object>> collectSlidesDebugPpt(File sourceFile, FontContext fontContext) throws IOException {
        try (FileInputStream fis = new FileInputStream(sourceFile);
             HSLFSlideShow ppt = new HSLFSlideShow(fis)) {
            List<Map<String, Object>> slidesDebug = new ArrayList<>();
            int index = 1;
            for (Slide<?, ?> slide : ppt.getSlides()) {
                slidesDebug.add(collectSlideTextDebug(slide, index, fontContext));
                index++;
            }
            return slidesDebug;
        }
    }

    private Map<String, Object> collectSlideTextDebug(Slide<?, ?> slide, int index, FontContext fontContext) {
        Set<String> fontFamilies = new LinkedHashSet<>();
        Set<String> missingFonts = new LinkedHashSet<>();
        List<Map<String, Object>> runSamples = new ArrayList<>();

        int textShapeCount = 0;
        int runCount = 0;
        StringBuilder fullText = new StringBuilder();

        Font fallbackProbe = new Font(fontContext.fallbackFont, Font.PLAIN, 18);

        for (Shape<?, ?> shape : slide.getShapes()) {
            if (!(shape instanceof TextShape<?, ?> textShape)) {
                continue;
            }
            textShapeCount++;

            String shapeText = normalizeText(textShape.getText());
            if (!shapeText.isBlank()) {
                if (!fullText.isEmpty()) {
                    fullText.append("\n");
                }
                fullText.append(shapeText);
            }

            for (Object paragraphObj : textShape.getTextParagraphs()) {
                TextParagraph<?, ?, ?> paragraph = (TextParagraph<?, ?, ?>) paragraphObj;
                for (Object runObj : paragraph.getTextRuns()) {
                    TextRun run = (TextRun) runObj;
                    runCount++;
                    String rawText = normalizeText(run.getRawText());
                    String fontFamily = normalizeText(run.getFontFamily());
                    if (fontFamily.isBlank()) {
                        fontFamily = "(default)";
                    } else {
                        fontFamilies.add(fontFamily);
                        if (!fontContext.installedFamilyLower.contains(fontFamily.toLowerCase(Locale.ROOT))) {
                            missingFonts.add(fontFamily);
                        }
                    }

                    if (runSamples.size() < MAX_DEBUG_RUNS_PER_SLIDE) {
                        runSamples.add(Map.of(
                                "font", fontFamily,
                                "text", abbreviate(rawText, MAX_DEBUG_TEXT_PREVIEW),
                                "length", rawText.length(),
                                "fallbackCanDisplay", fallbackProbe.canDisplayUpTo(rawText) == -1
                        ));
                    }
                }
            }
        }

        String text = fullText.toString().trim();
        Map<String, Object> slideDebug = new LinkedHashMap<>();
        slideDebug.put("index", index);
        slideDebug.put("shapeCount", slide.getShapes().size());
        slideDebug.put("textShapeCount", textShapeCount);
        slideDebug.put("runCount", runCount);
        slideDebug.put("textLength", text.length());
        slideDebug.put("textPreview", abbreviate(text, MAX_DEBUG_TEXT_PREVIEW));
        slideDebug.put("fontFamilies", new ArrayList<>(fontFamilies));
        slideDebug.put("missingFontsOnServer", new ArrayList<>(missingFonts));
        slideDebug.put("runSamples", runSamples);
        return slideDebug;
    }

    private String normalizeText(String value) {
        if (value == null) {
            return "";
        }
        return value.replace('\u0000', ' ').replace('\r', '\n').trim();
    }

    private String abbreviate(String input, int limit) {
        if (input == null || input.isBlank()) {
            return "";
        }
        String normalized = input.replaceAll("\\s+", " ").trim();
        if (normalized.length() <= limit) {
            return normalized;
        }
        return normalized.substring(0, limit) + "...";
    }

    private void writeError(HttpServletResponse response, String message) {
        try {
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"code\":500,\"msg\":\"" + escapeJson(message) + "\"}");
        } catch (IOException e) {
            log.error("Write error response failed", e);
        }
    }

    private String escapeJson(String value) {
        if (value == null) {
            return "";
        }
        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"");
    }

    private String getContentType(String fileType) {
        return switch (fileType) {
            case "pdf" -> "application/pdf";
            case "doc" -> "application/msword";
            case "docx" -> "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
            case "xls" -> "application/vnd.ms-excel";
            case "xlsx" -> "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            case "ppt" -> "application/vnd.ms-powerpoint";
            case "pptx" -> "application/vnd.openxmlformats-officedocument.presentationml.presentation";
            case "jpg", "jpeg" -> "image/jpeg";
            case "png" -> "image/png";
            case "gif" -> "image/gif";
            case "webp" -> "image/webp";
            case "svg" -> "image/svg+xml";
            case "txt" -> "text/plain;charset=UTF-8";
            case "md", "markdown" -> "text/markdown;charset=UTF-8";
            case "html", "htm" -> "text/html;charset=UTF-8";
            case "csv" -> "text/csv;charset=UTF-8";
            case "tsv" -> "text/tab-separated-values;charset=UTF-8";
            case "css" -> "text/css;charset=UTF-8";
            case "js" -> "application/javascript;charset=UTF-8";
            case "json" -> "application/json;charset=UTF-8";
            case "xml" -> "application/xml;charset=UTF-8";
            default -> "application/octet-stream";
        };
    }

    private static class FontContext {
        private final Map<String, String> fontMap;
        private final String fallbackFont;
        private final List<String> installedFontFamilies;
        private final Set<String> installedFamilyLower;
        private final List<String> loadedExternalFonts;

        private FontContext(
                Map<String, String> fontMap,
                String fallbackFont,
                List<String> installedFontFamilies,
                Set<String> installedFamilyLower,
                List<String> loadedExternalFonts) {
            this.fontMap = fontMap;
            this.fallbackFont = fallbackFont;
            this.installedFontFamilies = installedFontFamilies;
            this.installedFamilyLower = installedFamilyLower;
            this.loadedExternalFonts = loadedExternalFonts;
        }
    }
}
