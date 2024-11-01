# Sample API Requests

- [Sample API Requests](#sample-api-requests)
  - [Authentication](#authentication)
    - [Sign Up](#sign-up)
    - [Login](#login)
    - [Logout](#logout)
    - [User](#user)
    - [Validate Email](#validate-email)
    - [Validate Username](#validate-username)
  - [Restaurant](#restaurant)
    - [Restaurant](#restaurant-1)
    - [All Restaurants](#all-restaurants)
    - [Manager Restaurants](#manager-restaurants)
    - [Validate Restaurant Name](#validate-restaurant-name)
    - [Types](#types)
    - [Locations](#locations)
    - [Add Restaurant](#add-restaurant)
  - [Review](#review)
    - [Reviews](#reviews)
    - [Add Review](#add-review)
  - [Table](#table)
    - [Tables](#tables)
    - [Add Table](#add-table)
  - [Reservation](#reservation)
    - [Restaurant Reservations](#restaurant-reservations)
    - [Customer Reservations](#customer-reservations)
    - [Available Times](#available-times)
    - [Reserve](#reserve)
    - [Cancel](#cancel)

Here are some example cURL requests to demonstrate how to interact with the API.
You can also use Postman to make these requests.

## Authentication

### Sign Up

```bash
curl --location 'http://localhost:8080/api/signup' \
--header 'Content-Type: application/json' \
--data-raw '{
    "username": "swt",
    "password": "fall03",
    "email": "swt@gmail.com",
    "address": {
        "country": "Iran",
        "city": "Tehran"
    },
    "role": "client"
}
'
```

### Login

```bash
curl --location 'http://localhost:8080/api/login' \
--header 'Content-Type: application/json' \
--data '{
    "username": "Peyman",
    "password": "asdf"
}
'
```

### Logout

```bash
curl --location --request POST 'http://localhost:8080/api/logout'
```

### User

```bash
curl --location 'http://localhost:8080/api/user'
```

### Validate Email

```bash
curl --location 'http://localhost:8080/api/validate/email?data=ali%40gmail.com'
```

### Validate Username

```bash
curl --location 'http://localhost:8080/api/validate/username?data=ali'
```

## Restaurant

### Restaurant

```bash
curl --location 'http://localhost:8080/api/restaurants/0'
```

### All Restaurants

```bash
curl --location 'http://localhost:8080/api/restaurants?page=1'
```

### Manager Restaurants

Find all restaurants managed by a manager.

```bash
curl --location 'http://localhost:8080/api/restaurants/manager/2'
```

### Validate Restaurant Name

```bash
curl --location 'http://localhost:8080/api/validate/restaurant-name?data=sdf'
```

### Types

```bash
curl --location 'http://localhost:8080/api/restaurants/types'
```

### Locations

```bash
curl --location 'http://localhost:8080/api/restaurants/locations'
```

### Add Restaurant

Only managers can add restaurants.

```bash
curl --location 'http://localhost:8080/api/restaurants' \
--header 'Content-Type: application/json' \
--data '{
    "name": "The Best Foods",
    "type": "Sea Food",
    "description": "Lorem ipsum dolor",
    "startTime": "09:00",
    "endTime": "22:00",
    "image": null,
    "address": {
        "country": "Iran",
        "city": "Tehran",
        "street": "Bahar"
    }
}
'
```

## Review

### Reviews

```bash
curl --location 'http://localhost:8080/api/reviews/1?page=1'
```

### Add Review

Clients can add reviews only after they have made a reservation and the time of the reservation has passed. 

```bash
curl --location 'http://localhost:8080/api/reviews/0' \
--header 'Content-Type: application/json' \
--data '{
    "comment": "Yet another test comment.",
    "rating": {
        "food": 4.4,
        "service": 3.2,
        "ambiance": 3.8,
        "overall": 4.2
    }
}
'
```

## Table

### Tables

```bash
curl --location 'http://localhost:8080/api/tables/0'
```

### Add Table

Only a restaurant's manager can add tables to the restaurant.

```bash
curl --location 'http://localhost:8080/api/tables/1' \
--header 'Content-Type: application/json' \
--data '{
    "seatsNumber": 2
}
'
```

## Reservation

### Restaurant Reservations

Only managers can see the reservations of their restaurant.

```bash
curl --location 'http://localhost:8080/api/reserves/1?table=1'
```

### Customer Reservations

A user can only see their own reservations.

```bash
curl --location 'http://localhost:8080/api/reserves/customer/3'
```

### Available Times

```bash
curl --location 'http://localhost:8080/api/reserves/0/available?people=2&date=2024-10-26'
```

### Reserve

```bash
curl --location 'http://localhost:8080/api/reserves/1' \
--header 'Content-Type: application/json' \
--data '{
    "people": 4,
    "datetime": "2024-11-04 13:00"
}
'
```

### Cancel

```bash
curl --location --request POST 'http://localhost:8080/api/reserves/cancel/0'
```
