package com.example.server.util;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class SearchUtil {

    private SearchUtil() {
    }

    /**
     * Calculates the Levenshtein distance between two strings.
     */
    public static int levenshteinDistance(String s1, String s2) {
        if (s1 == null || s2 == null) {
            return Integer.MAX_VALUE;
        }

        int[][] dp = new int[s1.length() + 1][s2.length() + 1];

        for (int i = 0; i <= s1.length(); i++) {
            dp[i][0] = i;
        }
        for (int j = 0; j <= s2.length(); j++) {
            dp[0][j] = j;
        }

        for (int i = 1; i <= s1.length(); i++) {
            for (int j = 1; j <= s2.length(); j++) {
                int cost = (s1.charAt(i - 1) == s2.charAt(j - 1)) ? 0 : 1;
                dp[i][j] = Math.min(
                        Math.min(dp[i - 1][j] + 1, dp[i][j - 1] + 1),
                        dp[i - 1][j - 1] + cost
                );
            }
        }
        return dp[s1.length()][s2.length()];
    }

    /**
     * Calculates similarity score between 0.0 (completely different) and 1.0 (identical).
     */
    public static double similarityScore(String s1, String s2) {
        String norm1 = VietnameseTextUtil.normalizeForSearch(s1);
        String norm2 = VietnameseTextUtil.normalizeForSearch(s2);

        if (norm1.isEmpty() && norm2.isEmpty()) {
            return 1.0;
        }
        if (norm1.isEmpty() || norm2.isEmpty()) {
            return 0.0;
        }
        if (norm1.equals(norm2)) {
            return 1.0;
        }
        if (norm1.contains(norm2) || norm2.contains(norm1)) {
            return 0.9;
        }

        // Token intersection check
        Set<String> tokens1 = new HashSet<>(Arrays.asList(norm1.split(" ")));
        Set<String> tokens2 = new HashSet<>(Arrays.asList(norm2.split(" ")));
        long commonCount = tokens1.stream().filter(tokens2::contains).count();
        if (commonCount > 0) {
            double tokenOverlap = (double) commonCount / Math.max(tokens1.size(), tokens2.size());
            if (tokenOverlap > 0.5) {
                return 0.7 + (tokenOverlap * 0.2);
            }
        }

        int maxLength = Math.max(norm1.length(), norm2.length());
        int distance = levenshteinDistance(norm1, norm2);
        return 1.0 - ((double) distance / maxLength);
    }

    /**
     * Checks whether the target text matches the search keyword (accent-insensitive, substring, or fuzzy).
     */
    public static boolean matches(String target, String query, double threshold) {
        if (target == null || query == null || query.isBlank()) {
            return false;
        }
        String normTarget = VietnameseTextUtil.normalizeForSearch(target);
        String normQuery = VietnameseTextUtil.normalizeForSearch(query);

        if (normTarget.contains(normQuery)) {
            return true;
        }

        return similarityScore(normTarget, normQuery) >= threshold;
    }
}
