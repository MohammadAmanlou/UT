package mizdooni.response.serializer;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import org.springframework.http.HttpStatus;

import java.io.IOException;

public class HttpStatusSerializer extends JsonSerializer<HttpStatus> {
    @Override
    public void serialize(HttpStatus status, JsonGenerator gen, SerializerProvider serializers) throws IOException {
        gen.writeNumber(status.value());
    }
}
