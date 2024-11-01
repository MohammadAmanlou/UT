package mizdooni.database;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Objects;

public class JsonReader {
    private static final String DATA_DIR_PATH = "src/main/java/mizdooni/database/data/";

    public enum File {
        USERS("users.json"),
        RESTAURANTS("restaurants.json"),
        TABLES("tables.json"),
        REVIEWS("reviews.json");

        private final String path;

        File(String path) {
            this.path = path;
        }

        @Override
        public String toString() {
            return path;
        }
    }

    public static JsonNode readData(File file) {
        return readFromJson(DATA_DIR_PATH + file);
    }

    private static JsonNode readFromJson(String path) {
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(path)));
            return new ObjectMapper().readTree(reader);
        } catch (Exception e) {
            return null;
        }
    }
}
