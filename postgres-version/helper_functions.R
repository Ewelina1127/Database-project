library("RPostgres")


open.my.connection <- function() {
  con <- dbConnect(RPostgres::Postgres(),dbname = 'airport',
                   host = 'localhost',
                   port = 5432, 
                   user = '',
                   password = "")
  return (con)
}

close.my.connection <- function(con) {
  dbDisconnect(con)
}

# TOTAL FLIGHTS-----------------------------------------------------------------

load.number.flights <- function() {
  query <- "SELECT COUNT(*) AS total_flights FROM flights"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  number <- dbFetch(res)$total_flights[1]
  dbClearResult(res)            
  close.my.connection(con)
  return(number)                  
}


# TOTAL PASSENGERS TODAY----------------------------------------------------------

load.number.passenger <- function() {
  query <- "SELECT COUNT(DISTINCT r.passenger_id) AS liczba_pasazerow_dzisiaj
FROM reservations r
JOIN flights f ON r.flight_id = f.flight_id
WHERE EXTRACT(YEAR FROM departure_time) = EXTRACT(YEAR FROM CURRENT_DATE) 
AND EXTRACT(MONTH FROM departure_time) = EXTRACT(MONTH FROM CURRENT_DATE)"
  con = open.my.connection()
  res = dbSendQuery(con,query)
  number <- dbFetch(res)$liczba_pasazerow_dzisiaj[1]
  dbClearResult(res)              
  close.my.connection(con)        
  return(number)                  
}

# TOTAL PASENGERS WIZZAIR--------------------------------------------------------

load.total.unique.passengers.wizzair <- function() {
  query <- "
    SELECT COUNT(DISTINCT r.passenger_id) AS total_unique_passengers
    FROM reservations r
    JOIN flights f ON r.flight_id = f.flight_id
    JOIN destinations d ON f.destination_id = d.destination_id
    WHERE d.airline_id = 1
  "
  
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  total_unique_passengers <- dbFetch(res)$total_unique_passengers[1]
  dbClearResult(res)
  close.my.connection(con)
  return(total_unique_passengers)
}
# TOTAL PASENGERS LOT------------------------------------------------------------

load.total.unique.passengers.lot <- function() {
  query <- "
    SELECT COUNT(DISTINCT r.passenger_id) AS total_unique_passengers
    FROM reservations r
    JOIN flights f ON r.flight_id = f.flight_id
    JOIN destinations d ON f.destination_id = d.destination_id
    WHERE d.airline_id = 2
  "
  
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  total_unique_passengers <- dbFetch(res)$total_unique_passengers[1]
  dbClearResult(res)
  close.my.connection(con)
  return(total_unique_passengers)
}

# TOTAL PASENGERS RYANAIR--------------------------------------------------------

load.total.unique.passengers.ryanair <- function() {
  query <- "
    SELECT COUNT(DISTINCT r.passenger_id) AS total_unique_passengers
    FROM reservations r
    JOIN flights f ON r.flight_id = f.flight_id
    JOIN destinations d ON f.destination_id = d.destination_id
    WHERE d.airline_id = 3
  "
  
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  total_unique_passengers <- dbFetch(res)$total_unique_passengers[1]
  dbClearResult(res)
  close.my.connection(con)
  return(total_unique_passengers)
}

# MOST COMMON DEPARTURE DESTINATION----------------------------------------------

load.most.common.departure.destination <- function() {
  query <- "
    SELECT d.destination AS most_common_destination, COUNT(*) AS flight_count 
    FROM flights f
    JOIN destinations d ON f.destination_id = d.destination_id
    WHERE d.startairport = 'Wroclaw'
    GROUP BY d.destination
    ORDER BY flight_count DESC
    LIMIT 1
  "
  
  con <- open.my.connection()      
  res <- dbSendQuery(con, query)   
  destination <- dbFetch(res)$most_common_destination[1] 
  dbClearResult(res)              
  close.my.connection(con)        
  return(destination)                  
}


# MOST COMMON DEPARTURE DESTINATION-WIZZAIR--------------------------------------

load.most.common.departure.destination.wizzair <- function() {
  query <- "
    SELECT d.destination AS most_common_destination, COUNT(*) AS flight_count 
    FROM flights f
    JOIN destinations d ON f.destination_id = d.destination_id
    WHERE d.startairport = 'Wroclaw' AND d.airline_id = 1
    GROUP BY d.destination
    ORDER BY flight_count DESC
    LIMIT 1
  "
  con <- open.my.connection()      
  res <- dbSendQuery(con, query)   
  destination <- dbFetch(res)$most_common_destination[1] 
  dbClearResult(res)              
  close.my.connection(con)        
  return(destination)                  
}

# MOST COMMON DEPARTURE DESTINATION-LOT-----------------------------------------

load.most.common.departure.destination.lot <- function() {
  query <- "
    SELECT d.destination AS most_common_destination, COUNT(*) AS flight_count 
    FROM flights f
    JOIN destinations d ON f.destination_id = d.destination_id
    WHERE d.startairport = 'Wroclaw' AND d.airline_id = 2
    GROUP BY d.destination
    ORDER BY flight_count DESC
    LIMIT 1
  "
  con <- open.my.connection()      
  res <- dbSendQuery(con, query)   
  destination <- dbFetch(res)$most_common_destination[1] 
  dbClearResult(res)              
  close.my.connection(con)        
  return(destination)                  
}

# MOST COMMON DEPARTURE DESTINATION-RYANAIR--------------------------------------

load.most.common.departure.destination.ryanair <- function() {
  query <- "
    SELECT d.destination AS most_common_destination, COUNT(*) AS flight_count 
    FROM flights f
    JOIN destinations d ON f.destination_id = d.destination_id
    WHERE d.startairport = 'Wroclaw' AND d.airline_id = 3
    GROUP BY d.destination
    ORDER BY flight_count DESC
    LIMIT 1
  "
  con <- open.my.connection()      
  res <- dbSendQuery(con, query)   
  destination <- dbFetch(res)$most_common_destination[1] 
  dbClearResult(res)              
  close.my.connection(con)        
  return(destination)                  
}


# ALL STARTAIRPORT---------------------------------------------------------------

load.startairport <- function() {
  query <- "
    SELECT DISTINCT startairport 
    FROM destinations 
    WHERE startairport <> 'Wroclaw'
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  start_airports <- dbFetch(res)$startairport
  dbClearResult(res)
  close.my.connection(con)
  return(start_airports)
}
# ALL DESTINATIONS---------------------------------------------------------------

load.destination<- function() {
  query <- "
    SELECT DISTINCT destination 
    FROM destinations 
    WHERE destination <> 'Wroclaw'
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  destinations <- dbFetch(res)$destination
  dbClearResult(res)
  close.my.connection(con)
  return(destinations)
}

# AIRLINES NAMES-----------------------------------------------------------------

load.airlines<- function() {
  query <- "
    SELECT name 
    FROM airlines 
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  names <- dbFetch(res)$name
  dbClearResult(res)
  close.my.connection(con)
  return(names)
}


# GATES ID----------------------------------------------------------------------

load.gates<- function() {
  query <- "
    SELECT gate_id
    FROM  gates
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  names <- dbFetch(res)$gate_id
  dbClearResult(res)
  close.my.connection(con)
  return(names)
}

# FUTURE FLIGHTS-----------------------------------------------------------------

load.future.flights<- function() {
  query <- "
    SELECT flight_id
    FROM  flights
    WHERE DATE(departure_time) > CURRENT_DATE
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  id <- dbFetch(res)$flight_id
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}

# FLIGHTS WITHOUT GATE-----------------------------------------------------------

load.no_gate.departure <- function() {
  query <- "
    SELECT f.flight_id
    FROM flights f
    JOIN destinations d ON f.destination_id = d.destination_id
    WHERE DATE(f.departure_time) > CURRENT_DATE

    AND d.startairport = 'Wroclaw'
    AND f.flight_id NOT IN (
        SELECT flight_id
        FROM gateassignments
    )
    ORDER BY f.flight_id
  "
  
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  id <- dbFetch(res)$flight_id
  dbClearResult(res)
  close.my.connection(con)
  
  return(id)
}

# FLIGHTS ID---------------------------------------------------------------------

load.flights<- function() {
  query <- "
    SELECT flight_id
    FROM  flights
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  id <- dbFetch(res)$flight_id
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}

# DESTINATIONS ID----------------------------------------------------------------

load.destinations<- function() {
  query <- "
    SELECT destination_id
    FROM  destinations
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  id <- dbFetch(res)$destination_id
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}

# CANCELLED FLIGHTS--------------------------------------------------------------

load.cancelled.flights<- function() {
  query <- "
    SELECT flight_id
    FROM  flights
    WHERE status='cancelled'
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  id <- dbFetch(res)$flight_id
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}

# LUGGAGE ID---------------------------------------------------------------------

load.luggage<- function() {
  query <- "
    SELECT luggage_id
    FROM  luggage
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  id <- dbFetch(res)$luggage
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}

# FUTURE RESERVATIONS ID---------------------------------------------------------

load.future.reservations<- function() {
  query <- "
SELECT r.reservation_id
FROM reservations r
JOIN flights f ON r.flight_id = f.flight_id
LEFT JOIN luggage l ON r.reservation_id = l.reservation_id
WHERE f.departure_time > CURRENT_TIMESTAMP
  AND l.status IS NULL
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  id <- dbFetch(res)$reservation_id
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}

# NULL STATUS LUGGAGE------------------------------------------------------------

load.remove.luggage<- function() {
  query <- "
SELECT l.luggage_id
FROM luggage l
JOIN reservations r ON l.reservation_id = r.reservation_id
JOIN flights f ON r.flight_id = f.flight_id
WHERE f.departure_time > CURRENT_TIMESTAMP
  AND l.status IS NULL
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  id <- dbFetch(res)$luggage_id
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}

# PASSENGERS ID------------------------------------------------------------------

load.passengers<- function() {
  query <- "
    SELECT passenger_id
    FROM  passengers
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  id <- dbFetch(res)$passenger_id
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}

# AIRCRAFTS ID-------------------------------------------------------------------

load.aircrafts<- function() {
  query <- "
    SELECT aircraft_id
    FROM  aircrafts
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  id <- dbFetch(res)$aircraft_id
  dbClearResult(res)
  close.my.connection(con)
  return(id)
}

# ARRIVALS---------------------------------------------------------------

load.arrivals <- function() {
  query <- "SELECT * FROM arrivals ORDER BY arrival_time ASC"
  con = open.my.connection()  
  res = dbSendQuery(con,query)
  arrivals_data = dbFetch(res)           
  dbClearResult(res)  
  close.my.connection(con) 
  arrivals_data <- as.data.frame(arrivals_data)
  arrivals_data$arrival_time <- format(as.POSIXct(arrivals_data$arrival_time, tz = "UTC"), "%Y-%m-%d %H:%M:%S")
  return(arrivals_data) 
}

# DEPARTURES--------------------------------------------------------------

load.departures <- function() {
  query <- "SELECT * FROM departures ORDER BY departure_time ASC"
  con = open.my.connection()  
  res = dbSendQuery(con,query)
  departures_data = dbFetch(res)           
  dbClearResult(res)  
  close.my.connection(con) 
  departures_data <- as.data.frame(departures_data)
  departures_data$departure_time <- format(as.POSIXct(departures_data$departure_time, tz = "UTC"), "%Y-%m-%d %H:%M:%S")
  departures_data$gate_opening_time <- format(as.POSIXct(departures_data$gate_opening_time, tz = "UTC"), "%Y-%m-%d %H:%M:%S")
  return(departures_data) 
}

# ALL FLIGHTS-TABLE--------------------------------------------------------------

load.all.flights <- function() {
  query <- "SELECT * FROM flights ORDER BY departure_time ASC"
  con = open.my.connection()  
  res = dbSendQuery(con,query)
  flights_data = dbFetch(res)           
  dbClearResult(res)  
  close.my.connection(con) 
  flights_data <- as.data.frame(flights_data)
  flights_data$departure_time <- format(as.POSIXct(flights_data$departure_time, tz = "UTC"), "%Y-%m-%d %H:%M:%S")
  flights_data$arrival_time <- format(as.POSIXct(flights_data$arrival_time, tz = "UTC"), "%Y-%m-%d %H:%M:%S")
  return(flights_data) 
}

# AVAILABLE CONNECTIONS-TABLE----------------------------------------------------

load.available.connections <- function() {
  query <- "SELECT 
    d.destination_id,
    d.startairport,
    d.destination,
    al.name AS airline_name,
    d.flight_number
FROM 
    destinations d
JOIN 
    airlines al
ON 
    d.airline_id = al.airline_id"
  
  con = open.my.connection()  
  res = dbSendQuery(con,query)
  connections_data = dbFetch(res)           
  dbClearResult(res)  
  close.my.connection(con) 
  connections_data<- as.data.frame(connections_data)
  return(connections_data) 
}

# AVAILABLE CONNECTIONS WIZZAIR-TABLE--------------------------------------------

load.available.connections.wizzair <- function() {
  query <- "SELECT 
    d.destination_id,
    d.startairport,
    d.destination,
    d.flight_number
FROM 
    destinations d
JOIN 
    airlines al
ON 
    d.airline_id = al.airline_id
WHERE 
    al.name = 'Wizz Air'
"
  con = open.my.connection()  
  res = dbSendQuery(con,query)
  connections_data = dbFetch(res)           
  dbClearResult(res)  
  close.my.connection(con) 
  connections_data<- as.data.frame(connections_data)
  return(connections_data) 
}

# AVAILABLE CONNECTIONS LOT-TABLE------------------------------------------------

load.available.connections.lot <- function() {
  query <- "SELECT 
    d.destination_id,
    d.startairport,
    d.destination,
    d.flight_number
FROM 
    destinations d
JOIN 
    airlines al
ON 
    d.airline_id = al.airline_id
WHERE 
    al.name = 'LOT'
"
  con = open.my.connection()  
  res = dbSendQuery(con,query)
  connections_data = dbFetch(res)           
  dbClearResult(res)  
  close.my.connection(con) 
  connections_data<- as.data.frame(connections_data)
  return(connections_data) 
}

# AVAILABLE CONNECTIONS RYANAIR-TABLE--------------------------------------------

load.available.connections.ryanair <- function() {
  query <- "SELECT 
    d.destination_id,
    d.startairport,
    d.destination,
    d.flight_number
FROM 
    destinations d
JOIN 
    airlines al
ON 
    d.airline_id = al.airline_id
WHERE 
    al.name = 'Ryanair'
"
  con = open.my.connection()  
  res = dbSendQuery(con,query)
  connections_data = dbFetch(res)           
  dbClearResult(res)  
  close.my.connection(con) 
  connections_data<- as.data.frame(connections_data)
  return(connections_data) 
}

# OWNED AIRCRAFTS WIZZAIR-TABLE--------------------------------------------------

load.owned.aircrafts.wizzair <- function() {
  query <- "SELECT 
    a.aircraft_id,
    a.model AS aircraft_model,
    a.seats,
    a.range,
    a.fuel_consumption,
    a.fuel_type
FROM 
    aircrafts a
JOIN 
    airlines al
ON 
    a.airline_id = al.airline_id
WHERE 
    al.name = 'Wizz Air'
"
  con = open.my.connection()  
  res = dbSendQuery(con,query)
  connections_data = dbFetch(res)           
  dbClearResult(res)  
  close.my.connection(con) 
  connections_data<- as.data.frame(connections_data)
  return(connections_data) 
}

# OWNED AIRCRAFTS LOT-TABLE--------------------------------------------------

load.owned.aircrafts.lot <- function() {
  query <- "SELECT 
    a.aircraft_id,
    a.model AS aircraft_model,
    a.seats,
    a.range,
    a.fuel_consumption,
    a.fuel_type
FROM 
    aircrafts a
JOIN 
    airlines al
ON 
    a.airline_id = al.airline_id
WHERE 
    al.name = 'LOT'
"
  con = open.my.connection()  
  res = dbSendQuery(con,query)
  connections_data = dbFetch(res)           
  dbClearResult(res)  
  close.my.connection(con) 
  connections_data<- as.data.frame(connections_data)
  return(connections_data) 
}

# OWNED AIRCRAFTS RYANAIR-TABLE--------------------------------------------------

load.owned.aircrafts.ryanair <- function() {
  query <- "SELECT 
    a.aircraft_id,
    a.model AS aircraft_model,
    a.seats,
    a.range,
    a.fuel_consumption,
    a.fuel_type
FROM 
    aircrafts a
JOIN 
    airlines al
ON 
    a.airline_id = al.airline_id
WHERE 
    al.name = 'Ryanair'
"
  con = open.my.connection()  
  res = dbSendQuery(con,query)
  connections_data = dbFetch(res)           
  dbClearResult(res)  
  close.my.connection(con) 
  connections_data<- as.data.frame(connections_data)
  return(connections_data) 
}


# SEARCHING ARRIVALS-------------------------------------------------------------

load.filtered.flights <- function(departure_airport = NULL, airlines = NULL, date = NULL) {
  query <- "SELECT * FROM arrivals WHERE 1=1"
  
  if (!is.null(departure_airport) && departure_airport != "") {
    query <- paste0(query, " AND departure_airport = '", departure_airport, "'")
  }
  
  if (!is.null(airlines) && length(airlines) > 0) {
    airline_filter <- paste0("'", paste(airlines, collapse = "','"), "'")
    query <- paste0(query, " AND airline IN (", airline_filter, ")")
  }
  
  if (!is.null(date)) {
    query <- paste0(query, " AND DATE(arrival_time) = '", date, "'")
  }
  
  query <- paste0(query, " ORDER BY arrival_time ASC")
  
  con <- open.my.connection()
  
  res <- dbSendQuery(con, query)
  flights_data <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  
  flights_data <- as.data.frame(flights_data)
  flights_data$arrival_time <- format(as.POSIXct(flights_data$arrival_time, tz = "UTC"), "%Y-%m-%d %H:%M:%S")
  
  return(flights_data)
}

# SEARCHING DEPARTURES-----------------------------------------------------------

load.filtered.departures <- function(destination = NULL, airlines = NULL, date = NULL) {
  query <- "SELECT * FROM departures WHERE 1=1"
  
  if (!is.null(destination) && destination != "") {
    query <- paste0(query, " AND destination = '", destination, "'")
  }
  
  if (!is.null(airlines) && length(airlines) > 0) {
    airline_filter <- paste0("'", paste(airlines, collapse = "','"), "'")
    query <- paste0(query, " AND airline IN (", airline_filter, ")")
  }
  
  if (!is.null(date)) {
    query <- paste0(query, " AND DATE(departure_time) = '", date, "'")
  }
  
  query <- paste0(query, " ORDER BY departure_time ASC")
  
  con <- open.my.connection()
  
  res <- dbSendQuery(con, query)
  flights_data <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  
  flights_data <- as.data.frame(flights_data)
  flights_data$departure_time <- format(as.POSIXct(flights_data$departure_time, tz = "UTC"), "%Y-%m-%d %H:%M:%S")
  flights_data$gate_opening_time <- format(as.POSIXct(flights_data$gate_opening_time, tz = "UTC"), "%Y-%m-%d %H:%M:%S")
  
  return(flights_data)
}

# GATE ASSIGN--------------------------------------------------------------------

assign.gate <- function(flight_id, gate_id) {
  query <- paste0("SELECT assign_gate(", flight_id, ", ", gate_id, ")")
  
  con <- open.my.connection()
  on.exit(close.my.connection(con))
  
  result <- tryCatch({
    res <- dbSendQuery(con, query)
    dbClearResult(res)
    "Gate assigned successfully!"
  }, error = function(e) {
    e$message 
  })
  
  return(result)
}

# UPDATE FLIGHT-DETAILS----------------------------------------------------------

load_flight_details<- function(flight_id) {
  query <-paste("SELECT * FROM flights WHERE flight_id =", flight_id)
  con = open.my.connection()  
  res = dbSendQuery(con,query)
  flights_data = dbFetch(res)           
  dbClearResult(res)  
  close.my.connection(con) 
  flights_details_data<- as.data.frame(flights_data)
  flights_details_data$arrival_time <- format(as.POSIXct(flights_details_data$arrival_time, tz = "UTC"), "%Y-%m-%d %H:%M:%S")
  flights_details_data$departure_time <- format(as.POSIXct(flights_details_data$departure_time, tz = "UTC"), "%Y-%m-%d %H:%M:%S")
  return(flights_details_data) 
}



update_flight_details <- function(flight_id, departure_time = NULL, arrival_time = NULL, 
                                  aircraft_id = NULL, status = NULL) {
  
  departure_time_str <- if (is.null(departure_time)) "NULL" else sprintf("'%s'", as.character(departure_time))
  arrival_time_str <- if (is.null(arrival_time)) "NULL" else sprintf("'%s'", as.character(arrival_time))
  aircraft_id_str <- if (is.null(aircraft_id)) "NULL" else sprintf("'%s'", aircraft_id)
  status_str <- if (is.null(status)) "NULL" else sprintf("'%s'", status)
  
  query <- sprintf(
    "SELECT update_flight_details(%d, %s, %s, %s, %s);",
    as.integer(flight_id),
    departure_time_str,
    arrival_time_str,
    aircraft_id_str,
    status_str
  )
  
  message("Generated SQL Query: ", query) 
  
  con <- open.my.connection()
  on.exit(close.my.connection(con))
  
  tryCatch({
    res <- dbSendQuery(con, query)
    dbClearResult(res)
    return(TRUE)
  }, error = function(e) {
    message("Error: ", e$message)
    return(FALSE)
  })
}



# ADD NEW FLIGHT-----------------------------------------------------------------

add_new_flight <- function(destination_id, departure_time, arrival_time) {
  query <- sprintf(
    "SELECT add_flight(%d, '%s', '%s');",
    as.integer(destination_id),
    as.character(departure_time),
    as.character(arrival_time)
  )
  con <- open.my.connection()
  on.exit(close.my.connection(con))
  
  tryCatch({
    res <- dbSendQuery(con, query)
    dbClearResult(res)
    return(TRUE) 
  }, error = function(e) {
    message("Error: ", e$message)
    return(FALSE)
  })
}

# REMOVE A FLIGHT------------------------------------------------------------------

remove.flight <- function(flight_id) {
  query <- paste0("
    DELETE FROM flights
    WHERE flight_id = ", flight_id
  )
  con <- open.my.connection()
  dbExecute(con, query)
  close.my.connection(con)
}

load.cancelled.flights.table <- function() {
  query <- "
    SELECT *
    FROM flights
    WHERE status = 'cancelled'
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  cancelled_flights <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  
  cancelled_flights$arrival_time <- format(as.POSIXct(cancelled_flights$arrival_time, tz = "UTC"), "%Y-%m-%d %H:%M:%S")
  cancelled_flights$departure_time <- format(as.POSIXct(cancelled_flights$departure_time, tz = "UTC"), "%Y-%m-%d %H:%M:%S")
  return(cancelled_flights)
}

# LIST OF PASSENGERS-FOR A FLIGHT------------------------------------------------

load.list.of.passengers <- function(flight_id) {

  query <- paste("SELECT p.passenger_id, p.first_name, p.last_name,p.document_number, p.date_of_birth, p.gender, p.email,p.phone_number
                  FROM passengers p
                  JOIN reservations r ON p.passenger_id = r.passenger_id
                  WHERE r.flight_id = ", flight_id, " AND r.reservation_id IS NOT NULL", sep = "")
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  passengers <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(passengers)
}

# ALL PASSENGERS-TABLE-----------------------------------------------------------

load.all.passengers <- function() {
  query <- "SELECT 
              passenger_id, 
              first_name, 
              last_name, 
              document_number, 
              date_of_birth, 
              gender, 
              email, 
              phone_number 
            FROM passengers"
  
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  passengers_data <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  
  passengers_data <- as.data.frame(passengers_data)
  return(passengers_data)
}

# ADD RESERVATION----------------------------------------------------------------

add_reservation_to_db <- function(flight_id, passenger_id) {
  query <- paste("SELECT add_reservation(", flight_id, ", ", passenger_id, ")")
  
  con <- open.my.connection()
  
  tryCatch({
    res <- dbSendQuery(con, query)
    dbClearResult(res)
    close.my.connection(con)
    return("Success")
    
  }, error = function(e) {
    close.my.connection(con)
    return("Error occurred.")
  })
}

# ADD PASSENGER------------------------------------------------------------------

add_passenger_to_db <- function(first_name, last_name, document, date_of_birth, gender, email, phone) {
 
   query <- paste(
    "SELECT add_passenger('", first_name, "', '", last_name, "', '", document, "', '", 
    date_of_birth, "', '", gender, "', '", email, "', '", phone, "');", sep = ""
  )
  
  con <- open.my.connection()
  
  tryCatch({
    res <- dbSendQuery(con, query)
    dbClearResult(res)
    
    return("Success")
  }, error = function(e) {
    message("Error: ", e$message)
    
    if (grepl("duplicate", e$message, ignore.case = TRUE)) {
      return("Duplicate document")
    } else {
      return("Database error")
    }
  })
  
  close.my.connection(con)
}

# SEARCH LUGGAGE-TABLE-----------------------------------------------------------

search.luggage.details <- function(luggage_id) {
  query <- paste0(
    "SELECT 
       l.luggage_id,
       l.reservation_id,
       p.first_name,
       p.last_name,
       l.weight,
       l.status
     FROM 
       luggage l
     JOIN 
       reservations r ON l.reservation_id = r.reservation_id
     JOIN 
       passengers p ON r.passenger_id = p.passenger_id
     WHERE 
       l.luggage_id = '", luggage_id, "'"
  )
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  luggage_details <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(luggage_details)
}

# ADD LUGGAGE--------------------------------------------------------------------

add_luggage_to_db <- function(reservation_id, weight) {

  query <- paste(
    "SELECT add_luggage(", reservation_id, ", ", weight, ");", sep = ""
  )
  
  con <- open.my.connection()
  

  tryCatch({
    res <- dbSendQuery(con, query)
    dbClearResult(res)             
    
    return("Luggage added successfully")
  }, error = function(e) {
    message("Error: ", e$message)
    
    if (grepl("foreign key", e$message, ignore.case = TRUE)) {
      return("Invalid reservation ID")
    } else if (grepl("weight", e$message, ignore.case = TRUE)) {
      return("Invalid luggage weight")
    } else {
      return("Database error")
    }
  }, finally = {
    close.my.connection(con)
  })
}

# REMOVE LUGGAGE-----------------------------------------------------------------

remove_luggage_from_db <- function(luggage_id) {
  query <- paste("DELETE FROM luggage WHERE luggage_id = ", luggage_id, ";", sep = "")
  
  con <- open.my.connection()
  
  tryCatch({
    res <- dbSendQuery(con, query)
    dbClearResult(res)
    return("Luggage removed successfully")
  }, error = function(e) {
    message("Error: ", e$message)
    if (grepl("foreign key", e$message, ignore.case = TRUE)) {
      return("This luggage cannot be removed due to database constraints.")
    } else {
      return("Database error while removing luggage")
    }
  }, finally = {
    close.my.connection(con)
  })
}

# UPDATE STATUS LUGGAGE----------------------------------------------------------

pdate_luggage_status_in_db <- function(luggage_id, new_status) {
  query <- paste(
    "UPDATE luggage SET status = '", new_status, "' WHERE luggage_id = ", luggage_id, ";",
    sep = ""
  )
  
  con <- open.my.connection()
  
  tryCatch({
    res <- dbSendQuery(con, query)
    dbClearResult(res)
    return("Status updated successfully")
  }, error = function(e) {
    message("Error: ", e$message)
    return("Database error while updating status")
  }, finally = {
    close.my.connection(con)
  })
}

# CHECK AIRCRAFT MODEL EXISTS----------------------------------------------------

check_model_exists <- function(model) {
  query <- paste0("SELECT COUNT(*) AS count FROM aircraft_model WHERE model = '", model, "';")
  con <- open.my.connection()
  result <- dbGetQuery(con, query)
  
  close.my.connection(con)
  
 
  if (result$count == 1) {
    return("Success")
  } else {
    return(FALSE)
  }
}


# ADD AIRCRAFTS------------------------------------------------------------------

execute_query <- function(query) {
  con <- open.my.connection()
  tryCatch({
    dbGetQuery(con, query)
    return("Success")
  }, error = function(e) {
    return(paste("Error: ", e$message))
  }, finally = {
    close.my.connection(con)
  })
}

add_aircraft_to_wizzair <- function(model, seats, range, fuel_consumption, fuel_type) {
  query <- paste0("SELECT add_aircraft_to_wizzair('", model, "', ", seats, ", ", range, ", ", fuel_consumption, ", '", fuel_type, "');")
  execute_query(query)
}

add_aircraft_to_lot <- function(model, seats, range, fuel_consumption, fuel_type) {
  query <- paste0("SELECT add_aircraft_to_lot('", model, "', ", seats, ", ", range, ", ", fuel_consumption, ", '", fuel_type, "');")
  execute_query(query)
}

add_aircraft_to_ryanair <- function(model, seats, range, fuel_consumption, fuel_type) {
  query <- paste0("SELECT add_aircraft_to_ryanair('", model, "', ", seats, ", ", range, ", ", fuel_consumption, ", '", fuel_type, "');")
  execute_query(query)
}

# REMOVE AIRCRAFTS---------------------------------------------------------------

remove_aircraft <- function(aircraft_id, airline) {
  query <- switch(
    airline,
    "Wizz Air" = paste0("SELECT remove_aircraft_from_wizzair(", aircraft_id, ");"),
    "LOT" = paste0("SELECT remove_aircraft_from_lot(", aircraft_id, ");"),
    "Ryanair" = paste0("SELECT remove_aircraft_from_ryanair(", aircraft_id, ");"),
    stop("Unsupported airline")
  )
  
  con <- open.my.connection()
  
  tryCatch({
    result <- dbSendQuery(con, query)
    dbClearResult(result)
    return("Success")
  }, error = function(e) {
    return(paste("Error: ", e$message))
  }, finally = {
    close.my.connection(con)
  })
}

# EMPLOYEES ID-------------------------------------------------------------------

load.employees <- function() {
  query <- "SELECT employee_id FROM employees"
  con = open.my.connection()
  res = dbSendQuery(con, query)
  employee_ids <- dbFetch(res)$employee_id
  dbClearResult(res)
  close.my.connection(con)
  return(employee_ids)
}

# DEPARTMENT ID------------------------------------------------------------------

load.departments <- function() {
  query <- "SELECT department_id FROM departments"
  con = open.my.connection()
  res = dbSendQuery(con, query)
  departments_ids <- dbFetch(res)$department_id
  dbClearResult(res)
  close.my.connection(con)
  return(departments_ids)
}

# LONGEST SERVING NAME----------------------------------------------------------------

get.longest.serving.employee.name <- function() {
  query <- "SELECT first_name || ' ' || last_name AS full_name FROM employees ORDER BY hire_date ASC LIMIT 1"
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  employee_data <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  
  if (nrow(employee_data) > 0) {
    return(employee_data$full_name[1])
  } else {
    return("No employees found")
  }
}
# LONGEST SERVING-YEARS----------------------------------------------------------

get.longest.serving.employee.years <- function() {
  query <- "SELECT EXTRACT(YEAR FROM AGE(hire_date)) AS years_of_service FROM employees ORDER BY hire_date ASC LIMIT 1"
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  employee_data <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  
  if (nrow(employee_data) > 0) {
    return(employee_data$years_of_service[1])
  } else {
    return(NA)
  }
}

# LIST OF EMPLOYEES-TABLE--------------------------------------------------------

load.employee.list <- function() {
  query <- "SELECT e.employee_id, e.first_name, e.last_name, e.position, e.hire_date, d.department_name FROM employees e JOIN departments d ON e.department_id = d.department_id"
  con = open.my.connection()
  res = dbSendQuery(con, query)
  employee_list <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  return(employee_list)
}

# FIRE EMPLOYEE------------------------------------------------------------------

fire.employee <- function(employee_id) {
  query <- paste0("DELETE FROM employees WHERE employee_id = ", employee_id)
  con = open.my.connection()
  res = tryCatch({
    dbSendStatement(con, query)
    dbClearResult(dbSendStatement(con, query))
    "Success"
  }, error = function(e) {
    e$message
  })
  close.my.connection(con)
  return(res)
}

# HIRE EMPLOYEE------------------------------------------------------------------

hire.employee <- function(first_name, last_name, position, hire_date, department_id) {
  query <- paste0(
    "INSERT INTO employees (first_name, last_name, position, hire_date, department_id) VALUES (",
    "'", first_name, "', ",
    "'", last_name, "', ",
    "'", position, "', ",
    "'", hire_date, "', ",
    department_id, ")"
  )
  con <- open.my.connection()
  res <- tryCatch({
    stmt <- dbSendStatement(con, query) 
    dbClearResult(stmt)
    "Success"
  }, error = function(e) {
    e$message
  })
  close.my.connection(con)
  return(res)
}

# FLIGHTS-WITHOUT AIRCRAFTS TABLES-----------------------------------------------

load.ryanair.flights.without.aircraft <- function() {
  query <- "
    SELECT 
      f.flight_id, 
      d.startairport AS origin, 
      d.destination, 
      f.departure_time
    FROM 
      flights f
    JOIN 
      destinations d ON f.destination_id = d.destination_id
    JOIN 
      airlines a ON d.airline_id = a.airline_id
    WHERE 
      a.name = 'Ryanair' 
      AND f.aircraft_id IS NULL
      AND f.departure_time >= CURRENT_DATE
  "
  con <- open.my.connection()
  
  res <- dbSendQuery(con, query)
  flights_data <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  flights_data$departure_time <- format(
    as.POSIXct(flights_data$departure_time, tz = "UTC"), 
    "%Y-%m-%d %H:%M:%S"
  )
  
  return(flights_data)
}


load.lot.flights.without.aircraft <- function() {
  query <- "
    SELECT 
      f.flight_id, 
      d.startairport AS origin, 
      d.destination, 
      f.departure_time
    FROM 
      flights f
    JOIN 
      destinations d ON f.destination_id = d.destination_id
    JOIN 
      airlines a ON d.airline_id = a.airline_id
    WHERE 
      a.name = 'LOT' 
      AND f.aircraft_id IS NULL
      AND f.departure_time >= CURRENT_DATE
  "
  con <- open.my.connection()
  
  res <- dbSendQuery(con, query)
  flights_data <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  flights_data$departure_time <- format(
    as.POSIXct(flights_data$departure_time, tz = "UTC"), 
    "%Y-%m-%d %H:%M:%S"
  )
  
  return(flights_data)
}

load.wizzair.flights.without.aircraft <- function() {
  query <- "
    SELECT 
      f.flight_id, 
      d.startairport AS origin, 
      d.destination, 
      f.departure_time
    FROM 
      flights f
    JOIN 
      destinations d ON f.destination_id = d.destination_id
    JOIN 
      airlines a ON d.airline_id = a.airline_id
    WHERE 
      a.name = 'Wizz Air' 
      AND f.aircraft_id IS NULL
      AND f.departure_time >= CURRENT_DATE
  "
  con <- open.my.connection()
  
  res <- dbSendQuery(con, query)
  flights_data <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  flights_data$departure_time <- format(
    as.POSIXct(flights_data$departure_time, tz = "UTC"), 
    "%Y-%m-%d %H:%M:%S"
  )
  
  return(flights_data)
}

# FLIGHTS WITHOUT AIRCRAFTS ID---------------------------------------------------

load.ryanair.flight.ids.without.aircraft <- function() {
  query <- "
    SELECT 
      f.flight_id
    FROM 
      flights f
    JOIN 
      destinations d ON f.destination_id = d.destination_id
    JOIN 
      airlines a ON d.airline_id = a.airline_id
    WHERE 
      a.name = 'Ryanair' 
      AND f.aircraft_id IS NULL
      AND f.departure_time >= CURRENT_DATE
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  flight_ids <- dbFetch(res)
  
  dbClearResult(res)
  close.my.connection(con)
  return(flight_ids$flight_id)
}

load.lot.flight.ids.without.aircraft <- function() {
  query <- "
    SELECT 
      f.flight_id
    FROM 
      flights f
    JOIN 
      destinations d ON f.destination_id = d.destination_id
    JOIN 
      airlines a ON d.airline_id = a.airline_id
    WHERE 
      a.name = 'LOT' 
      AND f.aircraft_id IS NULL
      AND f.departure_time >= CURRENT_DATE
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  flight_ids <- dbFetch(res)
  
  dbClearResult(res)
  close.my.connection(con)
  return(flight_ids$flight_id)
}

load.wizzair.flight.ids.without.aircraft <- function() {
  query <- "
    SELECT 
      f.flight_id
    FROM 
      flights f
    JOIN 
      destinations d ON f.destination_id = d.destination_id
    JOIN 
      airlines a ON d.airline_id = a.airline_id
    WHERE 
      a.name = 'Wizz Air' 
      AND f.aircraft_id IS NULL
      AND f.departure_time >= CURRENT_DATE
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  flight_ids <- dbFetch(res)
  
  dbClearResult(res)
  close.my.connection(con)
  return(flight_ids$flight_id)
}

# AIRCRAFTS IDS------------------------------------------------------------------

load.owned.aircraft.ids.wizzair <- function() {
  query <- "
    SELECT 
      a.aircraft_id
    FROM 
      aircrafts a
    JOIN 
      airlines al ON a.airline_id = al.airline_id
    WHERE 
      al.name = 'Wizz Air'
  "
  
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  aircraft_ids <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  
  return(aircraft_ids$aircraft_id)
}

load.owned.aircraft.ids.lot <- function() {
  query <- "
    SELECT 
      a.aircraft_id
    FROM 
      aircrafts a
    JOIN 
      airlines al ON a.airline_id = al.airline_id
    WHERE 
      al.name = 'LOT'
  "
  
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  aircraft_ids <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  
  return(aircraft_ids$aircraft_id)
}

load.owned.aircraft.ids.ryanair <- function() {
  query <- "
    SELECT 
      a.aircraft_id
    FROM 
      aircrafts a
    JOIN 
      airlines al ON a.airline_id = al.airline_id
    WHERE 
      al.name = 'Ryanair'
  "
  con <- open.my.connection()
  res <- dbSendQuery(con, query)
  aircraft_ids <- dbFetch(res)
  dbClearResult(res)
  close.my.connection(con)
  
  return(aircraft_ids$aircraft_id)
}

# ASSIGN AIRCRAFT TO FLIGHT------------------------------------------------------

assign.aircraft.to.flight <- function(flight_id, aircraft_id) {
  query <- paste0(
    "UPDATE flights SET aircraft_id = ", aircraft_id, 
    " WHERE flight_id = ", flight_id
  )
  con <- open.my.connection()
  res <- tryCatch({
    dbSendStatement(con, query)
    dbClearResult(dbSendStatement(con, query))
    "Success"
  }, error = function(e) {
    e$message
  })
  close.my.connection(con)
  return(res)
}

