package mizdooni.response.serializer;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.BeanProperty;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.ser.ContextualSerializer;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;

public class DoublePrecisionSerializer extends JsonSerializer<Double> implements ContextualSerializer {
    private final int precision;

    public DoublePrecisionSerializer() {
        this.precision = -1;
    }

    public DoublePrecisionSerializer(int precision) {
        this.precision = precision;
    }

    @Override
    public void serialize(Double value, JsonGenerator gen, SerializerProvider serializers) throws IOException {
        if (precision == -1) {
            gen.writeNumber(value);
        } else {
            gen.writeNumber(BigDecimal.valueOf(value).setScale(precision, RoundingMode.HALF_UP));
        }
    }

    @Override
    public JsonSerializer<?> createContextual(SerializerProvider serializers, BeanProperty property) {
        JsonDoublePrecision precision = property.getAnnotation(JsonDoublePrecision.class);
        if (precision != null) {
            return new DoublePrecisionSerializer(precision.value());
        }
        return this;
    }
}
