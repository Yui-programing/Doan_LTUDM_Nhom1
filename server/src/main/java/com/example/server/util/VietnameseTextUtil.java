package com.example.server.util;

import java.text.Normalizer;
import java.util.regex.Pattern;

public class VietnameseTextUtil {

    private static final Pattern DIACRITICS_PATTERN = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");

    private VietnameseTextUtil() {
    }

    public static String removeAccents(String text) {
        if (text == null) {
            return "";
        }
        String normalized = Normalizer.normalize(text, Normalizer.Form.NFD);
        String withoutAccents = DIACRITICS_PATTERN.matcher(normalized).replaceAll("");
        return withoutAccents.replaceAll("[đĐ]", "d");
    }

    public static String normalizeForSearch(String text) {
        if (text == null) {
            return "";
        }
        return removeAccents(text).toLowerCase().trim().replaceAll("\\s+", " ");
    }
}
