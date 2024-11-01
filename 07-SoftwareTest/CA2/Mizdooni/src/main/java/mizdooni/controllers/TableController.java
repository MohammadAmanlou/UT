package mizdooni.controllers;

import mizdooni.model.Table;
import mizdooni.response.Response;
import mizdooni.response.ResponseException;
import mizdooni.service.RestaurantService;
import mizdooni.service.TableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

import static mizdooni.controllers.ControllerUtils.PARAMS_BAD_TYPE;
import static mizdooni.controllers.ControllerUtils.PARAMS_MISSING;

@RestController
class TableController {
    @Autowired
    private RestaurantService restaurantService;
    @Autowired
    private TableService tableService;

    @GetMapping("/tables/{restaurantId}")
    public Response getTables(@PathVariable int restaurantId) {
        ControllerUtils.checkRestaurant(restaurantId, restaurantService);
        try {
            List<Table> tables = tableService.getTables(restaurantId);
            return Response.ok("tables listed", tables);
        } catch (Exception ex) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, ex);
        }
    }

    @PostMapping("/tables/{restaurantId}")
    public Response addTable(@PathVariable int restaurantId, @RequestBody Map<String, String> params) {
        ControllerUtils.checkRestaurant(restaurantId, restaurantService);
        if (!ControllerUtils.containsKeys(params, "seatsNumber")) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, PARAMS_MISSING);
        }

        int seatsNumber;
        try {
            seatsNumber = Integer.parseInt(params.get("seatNumber"));
        } catch (Exception ex) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, PARAMS_BAD_TYPE);
        }

        try {
            tableService.addTable(restaurantId, seatsNumber);
            return Response.ok("table added");
        } catch (Exception ex) {
            throw new ResponseException(HttpStatus.BAD_REQUEST, ex);
        }
    }
}
