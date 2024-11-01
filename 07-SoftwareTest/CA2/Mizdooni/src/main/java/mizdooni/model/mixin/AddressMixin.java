package mizdooni.model.mixin;

import com.fasterxml.jackson.annotation.JsonInclude;
import mizdooni.model.Address;
import org.springframework.boot.jackson.JsonMixin;

@JsonMixin(Address.class)
@JsonInclude(JsonInclude.Include.NON_NULL)
abstract class AddressMixin {

}
