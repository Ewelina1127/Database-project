


server <- function(input, output,session) {
  current_time <- Sys.time()
  formatted_time <- format(current_time, "%H:%M:%S")
  
  arrivals<-load.past.arrivals()
  departures<-load.past.departures()
  all_flights<-load.all.flights()
  destinations<-load.available.connections()
  connections_wizzair<-load.available.connections.wizzair()
  connections_lot<-load.available.connections.lot()
  connections_ryanair<-load.available.connections.ryanair()
  aircrafts_wizzair<-load.owned.aircrafts.wizzair()
  aircrafts_lot<-load.owned.aircrafts.lot()
  aircrafts_ryanair<-load.owned.aircrafts.ryanair()
  cancelled_flights <- load.cancelled.flights.table()
  eployee<-load.employee.list()
  flights_ryanair <- load.ryanair.flights.without.aircraft()
  flights_lot <- load.lot.flights.without.aircraft()
  flights_wizzair <- load.wizzair.flights.without.aircraft()
  passengers<-load.all.passengers()
  
  
  colnames(arrivals)<-c("Flight ID", "Departure Airport", "Arrival Time", "Airline","Flight Number","Status")
  colnames(departures)<-c("Flight ID", "Arrival Airport", "Departure Time", "Airline", "Flight Number", "Status","Terminal","Gate","Gate Openning Time")
  colnames(all_flights)<-c("Flight ID", "Destination ID", "Departure Time", "Arrival Time","Aircraft ID", "Status")
  colnames(destinations)<-c("Destination ID", "Departure Airport", "Arrival Airport","Airline","Flight Number" )
  colnames(connections_wizzair)<-c('Destination ID',"Departure Airport","Arrival Airport", "Flight Number")
  colnames(connections_lot)<-c('Destination ID',"Departure Airport","Arrival Airport", "Flight Number")
  colnames(connections_ryanair)<-c('Destination ID',"Departure Airport","Arrival Airport", "Flight Number")
  colnames(aircrafts_wizzair)<-c("Aircraft ID"," Model","Seats", "Range", "Fuel Consumption", "Fuel Type")
  colnames(aircrafts_lot)<-c("Aircraft ID"," Model","Seats", "Range", "Fuel Consumption", "Fuel Type")
  colnames(aircrafts_ryanair)<-c("Aircraft ID"," Model","Seats", "Range", "Fuel Consumption", "Fuel Type")
  colnames(cancelled_flights)<-c("Flight ID","Destination ID", "Departure Time", "Arrival Time", "Aircraft ID", "Status")
  colnames(eployee)<-c("Employee ID", "First name", "Last name","Position","Hire date","Department name")
  colnames(flights_ryanair)<-c("Flight ID"," Origin","Destination","Departure Time")
  colnames(flights_lot)<-c("Flight ID"," Origin","Destination","Departure Time")
  colnames(flights_wizzair)<-c("Flight ID"," Origin","Destination","Departure Time")
  colnames(passengers)<-c("Passenger ID","First name","Last name","Document number","Date od birth","Gender","Email","Phone number")
  #ALL ARRIVALS-----------------------------------------------------------------
  output$all_arrivals <- renderDataTable(
    arrivals, 
    options = list( 
      pageLength = 9,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1))
      )
    )
  )
  #ALL DEPARTURES------------------------------------------------------------------
  output$all_departures <- renderDataTable(
    departures, 
    options = list( 
      pageLength = 9,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1))
      )
    )
  )
  #MANAGE FLIGHTS-ALL FLIGHTS-------------------------------------------------
  output$all_flights_manage <- renderDataTable(
    all_flights, 
    options = list( 
      pageLength = 9,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1, 2, 5))
      )
    )
  )
  #AVAILABLE CONNECTIONS-------------------------------------------------------
  output$destinations_table <- renderDataTable(
    destinations, 
    options = list( 
      pageLength = 6,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1))
      )
    )
  )
  #AVAILABLE CONNECTIONS-WIZZAIR------------------------------------------------
  output$connections_table_wizzair <- renderDataTable(
    connections_wizzair, 
    options = list( 
      pageLength = 6,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1))
      )
    )
  )
  #AVAILABLE CONNECTIONS-LOT---------------------------------------------------
  output$connections_table_lot <- renderDataTable(
    connections_lot, 
    options = list( 
      pageLength = 6,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1))
      )
    )
  )
  #AVAILABLE CONNECTIONS-RYANAIR------------------------------------------------
  output$connections_table_ryanair <- renderDataTable(
    connections_ryanair, 
    options = list( 
      pageLength = 6,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1))
      )
    )
  )
  #OWNED AIRCRAFTS-WIZZAIR-----------------------------------------------------
  output$owned_aircraft_table_wizzair <- renderDataTable(
    aircrafts_wizzair, 
    options = list( 
      pageLength = 6,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1,2,3,4,5,6))
      )
    )
  )
  #OWNED AIRCRAFTS-LOT---------------------------------------------------------
  output$owned_aircraft_table_lot <- renderDataTable(
    aircrafts_lot, 
    options = list( 
      pageLength = 6,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1,2,3,4,5,6))
      )
    )
  )
  #OWNED AIRCRAFTS-RYANAIR------------------------------------------------------
  output$owned_aircraft_table_ryanair <- renderDataTable(
    aircrafts_ryanair, 
    options = list( 
      pageLength = 6,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1,2,3,4,5,6))
      )
    )
  )
  
  #SEARCH ARRIVAL---------------------------------------------------------------
  filtered_data <- eventReactive(input$search_arrival, {
    departure_airport <- input$select_startairport
    airlines <- input$checkGroup_airline
    date <- input$date_arrival
    
    if (is.null(departure_airport) || departure_airport == "All") {
      departure_airport <- NULL
    }
    if (length(airlines) == 0) {
      airlines <- NULL
    }
    if (date == as.character.Date('2025-02-04')) {
      date <- NULL
    }
    
    flights_data <- as.data.frame(load.filtered.flights(departure_airport = departure_airport, airlines = airlines, date = date))
    
    colnames(flights_data) <- c("Flight ID", "Departure Airport", "Arrival Time", "Airline", "Flight Number", "Status")
    
    return(flights_data)
  })
  
  output$search_results <- renderDataTable({
    filtered_data()}, options = list( 
      pageLength = 6,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1, 2, 3, 4, 5))
      )
  )
  )
  #SEARCH DEPARTURE-------------------------------------------------------------
  filtered_departures <- eventReactive(input$search_departures, {
    destination <- input$select_destination
    airlines <- input$checkGroup_airline_departures
    date <- input$date_departures
    
    if (is.null(destination) || destination == "All") {
      destination <- NULL
    }
    if (length(airlines) == 0) {
      airlines <- NULL
    }
    if (date == as.character.Date('2025-02-04')) {
      date <- NULL
    }
    
    departures_data <- as.data.frame(load.filtered.departures(destination = destination, airlines = airlines, date = date))
    
    colnames(departures_data) <- c(
      "Flight ID", "Destination", "Departure Time", "Airline", 
      "Flight Number", "Status", "Terminal", "Gate", "Gate Opening Time"
    )
    
    return(departures_data)
  })
  
  output$search_results_departures <- renderDataTable({
    filtered_departures() }, options = list( 
      pageLength = 6,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1, 2, 3, 4, 5))
      )
    )
  )
  
  #GATE ASSIGMENT---------------------------------------------------------------
  observeEvent(input$add_gate_assigment, {
    req(input$flight_id_gate, input$gate_id)
    
    assign_status <- assign.gate(as.integer(input$flight_id_gate), as.integer(input$gate_id))
    
    if (assign_status == "Gate assigned successfully!") {
      showModal(modalDialog(
        title = "Success",
        assign_status,
        "Refresh!",
        easyClose = TRUE,
        footer = NULL
      ))
    } else {
      showModal(modalDialog(
        title = "Error",
        "This flight already has a gate assigned.",
        easyClose = TRUE,
        footer = NULL
      ))
    }
  })
  
  #UPDATE FLIGHT----------------------------------------------------------------
  observeEvent(input$flight_id_update, {
    flight_id <- input$flight_id_update
    flight_details <- load_flight_details(flight_id)
    
    colnames(flight_details) <- c("Flight ID", "Destination ID", "Departure Time", "Arrival Time", "Aircraft ID", "Status")
    
    output$flight_to_update <- renderTable({
      flight_details
    })
  })
  
  observeEvent(input$update_button, {
    flight_id <- as.integer(input$flight_id_update)
    
    departure_time <- if (!is.null(input$date_update_departure) && !is.null(input$departure_time)) {
      paste(input$date_update_departure, format(input$departure_time, "%H:%M:%S"))
    } else {
      NULL
    }
    
    arrival_time <- if (!is.null(input$date_update_arrival) && !is.null(input$arrival_time)) {
      paste(input$date_update_arrival, format(input$arrival_time, "%H:%M:%S"))
    } else {
      NULL
    }
    
    departure_time <- if (!is.null(departure_time)) as.POSIXct(departure_time, format="%Y-%m-%d %H:%M:%S") else NULL
    arrival_time <- if (!is.null(arrival_time)) as.POSIXct(arrival_time, format="%Y-%m-%d %H:%M:%S") else NULL
    
    aircraft_id <- if (!is.null(input$select_aircraft_update) && length(input$select_aircraft_update) == 1) {
      as.integer(input$select_aircraft_update)
    } else {
      NULL
    }
    
    status <- if (!is.null(input$radio_update_status) && length(input$radio_update_status) == 1) {
      as.character(input$radio_update_status)
    } else {
      NULL
    }
    
    success <- update_flight_details(
      flight_id = flight_id,
      departure_time = departure_time,
      arrival_time = arrival_time,
      aircraft_id = aircraft_id,
      status = status
    )
    
    if (success) {
      showModal(modalDialog(
        title = "Success",
        "Flight details have been updated successfully!",
        "Refresh!",
        easyClose = TRUE,
        footer = NULL
      ))
    } else {
      showModal(modalDialog(
        title = "Error",
        "Failed to update flight details. Please check your inputs and try again.",
        easyClose = TRUE,
        footer = NULL
      ))
    }
  })
  #ADD FLIGHT-------------------------------------------------------------------
  observeEvent(input$add_flight, {
    req(
      input$select_id_destination_add,
      input$date_add_departure,
      input$add_departure_time,
      input$date_add_arrival,
      input$add_arrival_time,
    )
    
 
    departure_time <- paste(input$date_add_departure, format(input$add_departure_time, "%H:%M:%S"))
    arrival_time <- paste(input$date_add_arrival, format(input$add_arrival_time, "%H:%M:%S"))
    
    departure_time <- as.POSIXct(departure_time, format="%Y-%m-%d %H:%M:%S")
    arrival_time <- as.POSIXct(arrival_time, format="%Y-%m-%d %H:%M:%S")
    
    success <- add_new_flight(
      destination_id = as.integer(input$select_id_destination_add),
      departure_time = departure_time,
      arrival_time = arrival_time
    )
    
    if (success) {
      showModal(modalDialog(
        title = "Success",
        "Flight has been added successfully!",
        easyClose = TRUE,
        footer = NULL
      ))
    } else {
      showModal(modalDialog(
        title = "Error",
        "Failed to add flight. Please check your inputs and try again.",
        easyClose = TRUE,
        footer = NULL
      ))
    }
  })
  
  #CANCELLED FLIGHTS TABLE------------------------------------------------------
  output$cancelled_flights_table <- renderDataTable(
    cancelled_flights, 
    options = list( 
      pageLength = 6,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1,2,3,4,5))
      )
    )
  )
  
  #REMOVE FLIGHTS---------------------------------------------------------------
  observeEvent(input$remove_flight_button, {
    flight_id <- input$flight_id_remove
    if (!is.null(flight_id)) {
      remove.flight(flight_id)
      showModal(modalDialog(
        title = "Success",
        "Flight has been removed successfully.",
        easyClose = TRUE,
        footer = NULL
      ))
    } else {
      showModal(modalDialog(
        title = "Error",
        "Please select a flight ID to remove.",
        easyClose = TRUE,
        footer = NULL
      ))
    }
  })
  
  #LIST OF PASSENGERS- TABLE----------------------------------------------------
  observeEvent(input$show_list_passengers, {
    flight_id <- input$select_flight_reservation
    
    passengers_data <-load.list.of.passengers(flight_id)
    colnames(passengers_data) <- c("Passenger ID", "First Name", "Last Name", 
                                   "Document Number", "Date of Birth", "Gender", "Email", "Phone Number")
    
    output$passengers_table <- renderDataTable({
      passengers_data
    }, options = list( 
      pageLength = 6,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1, 2, 3, 4, 5))
      ),
      searchCols = list(
        list(search = "") 
      )
    ))
    
    passenger_count <- nrow(passengers_data)
    
    output$occupancy_info <- renderText({
      paste("Total passengers:", passenger_count)
    })
  })
  #ALL PASSENGERS TABLE---------------------------------------------------------
  output$all_passengers_table <- renderDataTable({
    passengers},
    options = list( 
      pageLength = 6,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1,2,3,4,5))
      )
    )
  )
  
  #ADD RESERVATION--------------------------------------------------------------
  observeEvent(input$add_reservation, {
    req(
      input$flight_add_reservation,
      input$select_passenger
    )
    
    flight_id <- input$flight_add_reservation
    passenger_id <- input$select_passenger
      result<-add_reservation_to_db(flight_id, passenger_id)
      
      if (result == "Success") {
        showModal(modalDialog(
          title = "Success",
          "Reservation has been added successfully.",
          easyClose = TRUE,
          footer = NULL
        ))
      } else {
        showModal(modalDialog(
          title = "Error",
          "Reservation already exists.",
          easyClose = TRUE,
          footer = NULL
        ))
      }
      
    })
  
  
  #ADD PASSENGER----------------------------------------------------------------
  observeEvent(input$add_passenger, {
    req(input$passenger_first_name)  
    req(input$passenger_last_name)   
    req(input$document)              
    req(input$date_of_birth)         
    req(input$gender)               
    
    first_name <- input$passenger_first_name
    last_name <- input$passenger_last_name
    document <- input$document
    date_of_birth <- input$date_of_birth
    gender <- input$gender
    email <- input$email
    phone <- input$phone
    
    if (nzchar(email) | nzchar(phone)) {
      result <- add_passenger_to_db(first_name, last_name, document, date_of_birth, gender, email, phone)
      
      if (result == "Success") {
        showModal(modalDialog(
          title = "Success",
          "Passenger added successfully!",
          easyClose = TRUE,
          footer = NULL
        ))
      } else if (result == "Duplicate document") {
        showModal(modalDialog(
          title = "Error",
          "The document number already exists.",
          easyClose = TRUE,
          footer = NULL
        ))
      } else {
        showModal(modalDialog(
          title = "Error",
          "An error occurred while adding the passenger. Please try again.",
          easyClose = TRUE,
          footer = NULL
        ))
      }
    } else {
      showModal(modalDialog(
        title = "Error",
        "Please provide either an email or phone number.",
        easyClose = TRUE,
        footer = NULL
      ))
    }
  })
  
  #SEARCH LUGGAGE---------------------------------------------------------------
  observeEvent(input$search_luggage_btn, {
    luggage_id <- input$search_luggage_id
    
    luggage_details <- search.luggage.details(luggage_id)
    colnames(luggage_details)<-c("Luggage ID","Reservation ID","First name","Last name", "Weight","Status")

    output$search_luggage <- renderDataTable({
      luggage_details
    }, options = list( 
      pageLength = 1,
      lengthChange = FALSE,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(visible = FALSE, targets = c(0)),
        list(className = "dt-center", targets = c(1, 2, 3,4,5))
      )
    
    )
  )
  
  
})
  
    #ADD LUGGAGE----------------------------------------------------------------
    observeEvent(input$add_luggage, {

      reservation_id <- input$reservation_luggage_id
      weight <- as.numeric(input$weight_luggage)
      
      result <- add_luggage_to_db(reservation_id, weight)
      
      if (result == "Luggage added successfully") {
        showModal(modalDialog(
          title = "Success",
          "Luggage added successfully!",
          easyClose = TRUE,
          footer = modalButton("OK")
        ))
      } else {
        showModal(modalDialog(
          title = "Error",
          result,
          easyClose = TRUE,
          footer = NULL
        ))
      }
    })
    #REMOVE LUGGAGE-------------------------------------------------------------
    observeEvent(input$remove_luggage_button, {
      luggage_id <- input$luggage_remove
      
      result <- remove_luggage_from_db(luggage_id)
      
      if (result == "Luggage removed successfully") {
        showModal(modalDialog(
          title = "Success",
          "Luggage removed successfully!",
          easyClose = TRUE,
          footer = modalButton("OK")
        ))
        updateSelectInput(session, "luggage_remove", choices = as.list(load.remove.luggage()))#to działa
      } else {
        showModal(modalDialog(
          title = "Error",
          result,
          easyClose = TRUE,
          footer = NULL
        ))
      }
    })
    
    #UPDATE LUGGAGE-------------------------------------------------------------
    observeEvent(input$update_luggage, {
      luggage_id <- input$status_luggage_id
      new_status <- input$radio_update_luggage_status
      
      
      result <- update_luggage_status_in_db(luggage_id, new_status)
      
      if (result == "Status updated successfully") {
        showModal(modalDialog(
          title = "Success",
          "Luggage status updated successfully!",
          easyClose = TRUE,
          footer = modalButton("OK")
        ))
        
      } else {
        showModal(modalDialog(
          title = "Error",
          result,
          easyClose = TRUE,
          footer = NULL
        ))
      }
    })
    
  #ADD AIRCRAFTS----------------------------------------------------------------
    #WIZZAIR--------------------------------------------------------------------
    observeEvent(input$add_aircraft_wizzair, {
      model <- input$model_wizzair
      seats <- input$seats_wizzair
      range <- input$range_wizzair
      fuel_consumption <- input$fuel_consumption_wizzair
      fuel_type <- input$fuel_type_wizzair
      
      model_check <- check_model_exists(model)
      
      if (model_check != "Success") {
        showModal(modalDialog(
          title = "Error",
          "This airport does not support the selected aircraft model.",
          easyClose = TRUE,
          footer = NULL
        ))
        return(NULL)
      }
      
    
      result <- add_aircraft_to_wizzair(model, seats, range, fuel_consumption, fuel_type)
      
      if (result == "Success") {
        showModal(modalDialog(
          title = "Success",
          "Aircraft successfully added to Wizz Air.",
          easyClose = TRUE,
          footer = NULL
        ))
      } else {
        showModal(modalDialog(
          title = "Error",
          result,
          easyClose = TRUE,
          footer = NULL
        ))
      }
    })
    #LOT------------------------------------------------------------------------
    observeEvent(input$add_aircraft_lot, {
      model <- input$model_lot
      seats <- input$seats_lot
      range <- input$range_lot
      fuel_consumption <- input$fuel_consumption_lot
      fuel_type <- input$fuel_type_lot
      
      model_check <- check_model_exists(model)
      
      if (model_check != "Success") {
        showModal(modalDialog(
          title = "Error",
          "This airport does not support the selected aircraft model.",
          easyClose = TRUE,
          footer = NULL
        ))
        return(NULL)
      }
      
      result <- add_aircraft_to_lot(model, seats, range, fuel_consumption, fuel_type)
      
      if (result == "Success") {
        showModal(modalDialog(
          title = "Success",
          "Aircraft successfully added to LOT.",
          easyClose = TRUE,
          footer = NULL
        ))
      } else {
        showModal(modalDialog(
          title = "Error",
          result,
          easyClose = TRUE,
          footer = NULL
        ))
      }
    })
    #RYANAIR--------------------------------------------------------------------
    observeEvent(input$add_aircraft_ryanair, {
      model <- input$model_ryanair
      seats <- input$seats_ryanair
      range <- input$range_ryanair
      fuel_consumption <- input$fuel_consumption_ryanair
      fuel_type <- input$fuel_type_ryanair
      
      model_check <- check_model_exists(model)
      
      if (model_check != "Success") {
        showModal(modalDialog(
          title = "Error",
          "This airport does not support the selected aircraft model.",
          easyClose = TRUE,
          footer = NULL
        ))
        return(NULL)
      }
      
      result <- add_aircraft_to_ryanair(model, seats, range, fuel_consumption, fuel_type)
      
      if (result == "Success") {
        showModal(modalDialog(
          title = "Success",
          "Aircraft successfully added to Ryanair.",
          easyClose = TRUE,
          footer = NULL
        ))
      } else {
        showModal(modalDialog(
          title = "Error",
          result,
          easyClose = TRUE,
          footer = NULL
        ))
      }
    })
#REMOVE AIRCRAFTS---------------------------------------------------------------
  #WIZZAIR----------------------------------------------------------------------
    observeEvent(input$remove_aircraft_wizzair, {
      selected_aircraft_id <- input$aircraft_id_select_wizzair
      
      result <- remove_aircraft(selected_aircraft_id, "Wizz Air")
      
      if (result == "Success") {
        showModal(modalDialog(
          title = "Success",
          "Aircraft successfully removed from Wizz Air.",
          easyClose = TRUE,
          footer = NULL
        ))
        updateSelectInput(session, "aircraft_id_select_wizzair", 
                          choices = as.list(aircrafts_wizzair))
      } else {
        showModal(modalDialog(
          title = "Error",
          result,
          easyClose = TRUE,
          footer = NULL
        ))
      }
    })
    #LOT------------------------------------------------------------------------
    observeEvent(input$remove_aircraft_lot, {
      selected_aircraft_id <- input$aircraft_id_select_lot
      
      result <- remove_aircraft(selected_aircraft_id, "LOT")
      
      if (result == "Success") {
        showModal(modalDialog(
          title = "Success",
          "Aircraft successfully removed from LOT.",
          easyClose = TRUE,
          footer = NULL
        ))
        updateSelectInput(session, "aircraft_id_select_lot", 
                          choices = as.list(aircrafts_lot))
      } else {
        showModal(modalDialog(
          title = "Error",
          result,
          easyClose = TRUE,
          footer = NULL
        ))
      }
    })
    #RYANAIR--------------------------------------------------------------------
    observeEvent(input$remove_aircraft_ryanair, {
      selected_aircraft_id <- input$aircraft_id_select_ryanair
      
      result <- remove_aircraft(selected_aircraft_id, "Ryanair")
      
      if (result == "Success") {
        showModal(modalDialog(
          title = "Success",
          "Aircraft successfully removed from Ryanair.",
          easyClose = TRUE,
          footer = NULL
        ))
        updateSelectInput(session, "aircraft_id_select_ryanair", 
                          choices = as.list(aircrafts_ryanair))
      } else {
        showModal(modalDialog(
          title = "Error",
          result,
          easyClose = TRUE,
          footer = NULL
        ))
      }
    })
#EMPLOYEES---------------------------------------------------------------------
    #INFORMATION--------------------------------------------------------------
    output$employee_list <- renderDataTable({
      eployee}, options = list( 
        pageLength = 10,
        lengthChange = FALSE,
        searching = FALSE,
        info = FALSE,
        columnDefs = list(
          list(visible = FALSE, targets = c(0)),
          list(className = "dt-center", targets = c(1, 2, 3))
        )
        
      )
    )
    employess_count<-nrow(eployee)
    output$total_employees <- renderText({
      paste("Total employees:", employess_count)
    })
    
    output$longest_serving_employee_name <- renderText({
      get.longest.serving.employee.name()
    })
    output$longest_serving_years <- renderText({
      paste("Number of years worked:",get.longest.serving.employee.years())
    })
    
    #MANAGE--------------------------------------------------------------------
      #FIRE--------------------------------------------------------------------
    observeEvent(input$fire_employee_btn, {
      selected_employee_id <- input$employee_to_fire
      result <- fire.employee(selected_employee_id)
      
      if (result == "Success") {
        showModal(modalDialog(
          title = "Success",
          "Employee successfully fired.",
          easyClose = TRUE,
          footer = NULL
        ))
        updateSelectInput(session, "employee_to_fire", 
                          choices = as.list(load.employees()))
      } else {
        showModal(modalDialog(
          title = "Error",
          result,
          easyClose = TRUE,
          footer = NULL
        ))
      }
    })
      #HIRE--------------------------------------------------------------------
    observeEvent(input$hire_employee_btn, {
      first_name <- input$new_employee_first_name
      last_name <- input$new_employee_last_name
      position <- input$new_employee_position
      hire_date <- Sys.Date()
      department_id <- input$new_employee_department_id
      
      result <- hire.employee(first_name, last_name, position, hire_date, department_id)
      
      if (result == "Success") {
        showModal(modalDialog(
          title = "Success",
          "Employee successfully hired.",
          easyClose = TRUE,
          footer = NULL
        ))
        updateSelectInput(session, "employee_to_fire", 
                          choices = as.list(load.employees()))
      } else {
        showModal(modalDialog(
          title = "Error",
          result,
          easyClose = TRUE,
          footer = NULL
        ))
      }
    })
    
  #SHARE AIRCRAFTS--------------------------------------------------------------
    #WIZZAIR--------------------------------------------------------------------
    output$flights_without_aircraft_table_wizzair <- renderDataTable({
      flights_wizzair}, options = list( 
        pageLength = 10,
        lengthChange = FALSE,
        searching = FALSE,
        info = FALSE,
        columnDefs = list(
          list(visible = FALSE, targets = c(0)),
          list(className = "dt-center", targets = c(1, 2, 3))
        )
      )
    )
    #LOT------------------------------------------------------------------------
    output$flights_without_aircraft_table_lot <- renderDataTable({
      flights_lot}, options = list( 
        pageLength = 10,
        lengthChange = FALSE,
        searching = FALSE,
        info = FALSE,
        columnDefs = list(
          list(visible = FALSE, targets = c(0)),
          list(className = "dt-center", targets = c(1, 2, 3))
        )
      )
    )
    #RYANAIR--------------------------------------------------------------------
    output$flights_without_aircraft_table_ryanair <- renderDataTable({
      flights_ryanair}, options = list( 
        pageLength = 10,
        lengthChange = FALSE,
        searching = FALSE,
        info = FALSE,
        columnDefs = list(
          list(visible = FALSE, targets = c(0)),
          list(className = "dt-center", targets = c(1, 2, 3))
        )
      )
    )
#ASSIGN AIRCRAFTS---------------------------------------------------------------
    #WIZZAIR--------------------------------------------------------------------
    observeEvent(input$assign_aircraft_button_wizzair, {
      flight_id <- input$select_flight_without_aircraft_wizzair
      aircraft_id <- input$select_new_aircraft_wizzair
      
      result <- assign.aircraft.to.flight(flight_id, aircraft_id)
      
      if (result == "Success") {
        showModal(modalDialog(
          title = "Success",
          "The aircraft has been successfully assigned to the selected flight.",
          easyClose = TRUE,
          footer = NULL
        ))
        updateSelectInput(session, "select_flight_without_aircraft_wizzair",
                          choices = load.wizzair.flight.ids.without.aircraft())
      } else {
        showModal(modalDialog(
          title = "Error",
          paste("Failed to assign aircraft to the flight. Error:", result),
          easyClose = TRUE,
          footer = NULL
        ))
      }
    })
    #LOT------------------------------------------------------------------------
    observeEvent(input$assign_aircraft_button_lot, {
      flight_id <- input$select_flight_without_aircraft_lot
      aircraft_id <- input$select_new_aircraft_lot
      
      result <- assign.aircraft.to.flight(flight_id, aircraft_id)
      
      if (result == "Success") {
        showModal(modalDialog(
          title = "Success",
          "The aircraft has been successfully assigned to the selected flight.",
          easyClose = TRUE,
          footer = NULL
        ))
        updateSelectInput(session, "select_flight_without_aircraft_lot",
                          choices = load.lot.flight.ids.without.aircraft())
      } else {
        showModal(modalDialog(
          title = "Error",
          paste("Failed to assign aircraft to the flight. Error:", result),
          easyClose = TRUE,
          footer = NULL
        ))
      }
    })
    #RYANAIR--------------------------------------------------------------------
    observeEvent(input$assign_aircraft_button_ryanair, {
      flight_id <- input$select_flight_without_aircraft_ryanair
      aircraft_id <- input$select_new_aircraft_ryanair
      
      result <- assign.aircraft.to.flight(flight_id, aircraft_id)
      
      if (result == "Success") {
        showModal(modalDialog(
          title = "Success",
          "The aircraft has been successfully assigned to the selected flight.",
          easyClose = TRUE,
          footer = NULL
        ))
        updateSelectInput(session, "select_flight_without_aircraft_ryanair",
                          choices = load.ryanair.flight.ids.without.aircraft())
      } else {
        showModal(modalDialog(
          title = "Error",
          paste("Failed to assign aircraft to the flight. Error:", result),
          easyClose = TRUE,
          footer = NULL
        ))
      }
    })
    
}

shinyApp(ui = ui, server = server)

