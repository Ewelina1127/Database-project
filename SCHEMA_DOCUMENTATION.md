# Airport Database Schema Documentation

This document summarizes the structure and purpose of each table, view, trigger, and function in the Airport database.

---

## Tables

### 1. **airlines**

Stores airlines served by our airport.

* **Columns:**

  * `airline_id` (PK, auto‑increment) — unique identifier.
  * `name` (VARCHAR(50), UNIQUE, NOT NULL) — airline name.
  * `country` (VARCHAR(50), NOT NULL) — country of origin.

### 2. **aircraft\_model**

Maintains the list of valid aircraft models.

* **Columns:**

  * `model` (VARCHAR(50), PK) — unique model name.

### 3. **aircrafts**

Information about individual aircraft owned by airlines.

* **Columns:**

  * `aircraft_id` (PK, auto‑increment)
  * `airline_id` (FK → `airlines.airline_id`, NOT NULL)
  * `model` (FK → `aircraft_model.model`, NOT NULL)
  * `seats` (INTEGER, NOT NULL, CHECK > 0 AND ≤ 450)
  * `range` (DECIMAL(7,2), NOT NULL)
  * `fuel_consumption` (DECIMAL(7,2), NOT NULL)
  * `fuel_type` (VARCHAR(50), NOT NULL, CHECK IN ('Jet A1','SAF'))
* **Constraints:**

  * Foreign key to `airlines`: restrict deletion of an airline until its aircraft are removed.

### 4. **destinations**

Routes served by each airline, with flight numbers.

* **Columns:**

  * `destination_id` (PK, auto‑increment)
  * `startairport` (VARCHAR(50), NOT NULL)
  * `destination` (VARCHAR(50), NOT NULL)
  * `airline_id` (FK → `airlines.airline_id`, NOT NULL)
  * `flight_number` (VARCHAR(50), UNIQUE, NOT NULL)
* **Constraints:**

  * Unique combination `(startairport, destination, airline_id)`, preventing duplicate flight numbers on the same route.
  * `ON DELETE CASCADE` on `airline_id`: removing an airline deletes its routes.

### 5. **flights**

All scheduled flights at the airport.

* **Columns:**

  * `flight_id` (PK, auto‑increment)
  * `destination_id` (FK → `destinations.destination_id`, NOT NULL)
  * `departure_time` (TIMESTAMP, NOT NULL, CHECK < `arrival_time`)
  * `arrival_time` (TIMESTAMP, NOT NULL)
  * `aircraft_id` (FK → `aircrafts.aircraft_id`, ON DELETE SET NULL)
  * `status` (VARCHAR(10), NOT NULL, DEFAULT 'planned', CHECK IN ('delayed','planned','cancelled'))

### 6. **passengers**

Registered passengers.

* **Columns:**

  * `passenger_id` (PK, auto‑increment)
  * `first_name`, `last_name` (VARCHAR(50), NOT NULL)
  * `document_number` (VARCHAR(15), UNIQUE, NOT NULL)
  * `date_of_birth` (DATE, NOT NULL)
  * `gender` (CHAR(1), CHECK IN ('M','F'))
  * `email` (VARCHAR(100), UNIQUE, valid email format)
  * `phone_number` (VARCHAR(15), UNIQUE)
* **Constraint:**

  * Must have at least one contact method: `CHECK(email IS NOT NULL OR phone_number IS NOT NULL)`.

### 7. **reservations**

Paid reservations for flights.

* **Columns:**

  * `reservation_id` (PK, auto‑increment)
  * `flight_id` (FK → `flights.flight_id`, ON DELETE CASCADE)
  * `passenger_id` (FK → `passengers.passenger_id`, ON DELETE RESTRICT)
* **Constraints:**

  * Unique `(flight_id, passenger_id)`: prevents duplicate bookings.

### 8. **luggage**

Checked baggage linked to reservations.

* **Columns:**

  * `luggage_id` (PK, auto‑increment)
  * `reservation_id` (FK → `reservations.reservation_id`, ON DELETE CASCADE)
  * `weight` (DECIMAL(5,2), NOT NULL, CHECK > 0 AND ≤ 40)
  * `status` (VARCHAR(30), CHECK IN ('Checked-in','Loaded','Awaiting Pick-up','Lost','Found','Claimed'))

### 9. **gates**

Airport gates.

* **Columns:**

  * `gate_id` (PK, auto‑increment)
  * `terminal` (VARCHAR(50), NOT NULL, CHECK IN ('A','B'))
  * `gate_number` (VARCHAR(10), NOT NULL)
* **Constraints:**

  * Unique `(terminal, gate_number)`.

### 10. **gateassignments**

Dynamic assignments of gates to flights.

* **Columns:**

  * `assignment_id` (PK, auto‑increment)
  * `flight_id` (FK → `flights.flight_id`, UNIQUE, ON DELETE CASCADE)
  * `gate_id` (FK → `gates.gate_id`, ON DELETE CASCADE)
  * `opening_time` (TIMESTAMP)
* **Constraints:**

  * Unique `(flight_id, gate_id)` and `(gate_id, opening_time)`.

### 11. **departments**

Departments within airport staff.

* **Columns:**

  * `department_id` (PK, auto‑increment)
  * `department_name`, `location`, `contact_phone`

### 12. **employees**

Airport employees.

* **Columns:**

  * `employee_id` (PK, auto‑increment)
  * `first_name`, `last_name`, `position` (VARCHAR, NOT NULL)
  * `hire_date` (DATE, NOT NULL)
  * `department_id` (FK → `departments.department_id`, ON DELETE RESTRICT)

---

## Views

### **Arrivals**

Shows incoming flights to Wrocław:

* `flight_id`, `departure_airport`, `arrival_time`, `airline`, `flight_number`, `status`.

### **Departures**

Shows outgoing flights from Wrocław with gate info:

* `flight_id`, `destination`, `departure_time`, `airline`, `flight_number`, `status`, `terminal`, `gate`, `gate_opening_time`.

---

## Triggers & Functions

### Flight Time Validation

* **Function:** `validate_flight_times()` — prevents two flights departing or arriving at the same time at the same airport.
* **Trigger:** `check_flight_times` (BEFORE INSERT OR UPDATE on `flights`).

### Automatic Aircraft Assignment

* **Function:** `assign_aircraft_to_flight()` — picks a random available aircraft for the flight’s airline on the same day.
* **Trigger:** `assign_aircraft_before_insert` (BEFORE INSERT on `flights`).

### Seat Count Enforcement

* **Function:** `check_seat_number()` — ensures reservations do not exceed aircraft capacity.
* **Trigger:** fired BEFORE INSERT on `reservations`.

### Gate Opening Time

* **Function:** `set_opening_time()` — sets `opening_time` to 30 minutes before departure.
* **Trigger:** `set_opening_time_trigger` (BEFORE INSERT on `gateassignments`).
* **Function:** `update_opening_time()` — updates `opening_time` if departure is delayed.
* **Trigger:** `update_opening_time_trigger` (AFTER UPDATE of `departure_time` on `flights`).

### CRUD Helper Functions (PL/pgSQL)

* `add_flight()`, `add_reservation()`, `add_passenger()`, `add_luggage()`, `add_aircraft_to_<airline>()`,
  `remove_aircraft_from_<airline>()`, `assign_gate()`, `update_flight_details()`

