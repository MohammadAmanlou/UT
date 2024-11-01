package mizdooni.model.mixin;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import mizdooni.model.Rating;
import mizdooni.response.serializer.DoublePrecisionSerializer;
import mizdooni.response.serializer.JsonDoublePrecision;
import org.springframework.boot.jackson.JsonMixin;

@JsonMixin(Rating.class)
abstract class RatingMixin {
    @JsonSerialize(using = DoublePrecisionSerializer.class)
    @JsonDoublePrecision(1)
    private double food;

    @JsonSerialize(using = DoublePrecisionSerializer.class)
    @JsonDoublePrecision(1)
    private double service;

    @JsonSerialize(using = DoublePrecisionSerializer.class)
    @JsonDoublePrecision(1)
    private double ambiance;

    @JsonSerialize(using = DoublePrecisionSerializer.class)
    @JsonDoublePrecision(1)
    private double overall;

    @JsonIgnore
    abstract int getStarCount();
}
