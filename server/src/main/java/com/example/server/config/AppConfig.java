package com.example.server.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class AppConfig {
    private static final Logger logger = LoggerFactory.getLogger(AppConfig.class);
    private static final Properties properties = new Properties();

    static {
        loadProperties();
    }

    private static void loadProperties() {
        try (InputStream input = AppConfig.class.getClassLoader().getResourceAsStream("application.properties")) {
            if (input == null) {
                logger.warn("application.properties not found on classpath, using defaults.");
                return;
            }
            properties.load(input);
            logger.info("Configuration properties loaded successfully.");
        } catch (IOException ex) {
            logger.error("Failed to load application.properties", ex);
        }
    }

    public static String getProperty(String key, String defaultValue) {
        return properties.getProperty(key, defaultValue);
    }

    public static int getIntProperty(String key, int defaultValue) {
        String val = properties.getProperty(key);
        if (val != null) {
            try {
                return Integer.parseInt(val.trim());
            } catch (NumberFormatException e) {
                logger.warn("Invalid integer value for key '{}': '{}', falling back to {}", key, val, defaultValue);
            }
        }
        return defaultValue;
    }

    public static int getServerPort() {
        return getIntProperty("server.port", 8080);
    }

    public static int getThreadPoolSize() {
        return getIntProperty("server.thread-pool.size", 10);
    }

    public static String getDbUrl() {
        return getProperty("db.url", "jdbc:mysql://localhost:3306/song_search_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true");
    }

    public static String getDbUsername() {
        return getProperty("db.username", "root");
    }

    public static String getDbPassword() {
        return getProperty("db.password", "password");
    }
}
