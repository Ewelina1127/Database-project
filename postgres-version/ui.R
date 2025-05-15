
library(shiny)
library(shinyjs)
library(bslib)
library(shinydashboard)
library(ggplot2)
library(shinyTime)


source(file='helper_functions.r')


ui <- dashboardPage(
  skin = "black",
  title = "AirPort",
  
  # HEADER ------------------------------------------------------------------
  dashboardHeader(
    title = span(icon("plane", lib = "font-awesome"), "AirPort"),
    titleWidth = 300,
    
    dropdownMenu(
      type = "notifications", 
      headerText = strong("Contact"),  
      icon = icon("envelope"),
      badgeStatus = NULL,
      
      
      notificationItem(
        text = "339830@uwr.edu.pl",
        icon = icon("envelope")
      ),
      notificationItem(
        text = "339389@uwr.edu.pl", 
        icon = icon("envelope")
      )
    )
  ),
  
  # SIDEBAR -----------------------------------------------------------------
  dashboardSidebar(
    sidebarMenu(
      
  # MENU ----------------------------------------------------------------------
      
      menuItem("Home", tabName = "home", icon = icon("home")), 
      menuItem("Flights", tabName = "flights", icon = icon("plane-departure"),
               menuSubItem("Arrivals", tabName = "arrivals"),
               menuSubItem("Departures", tabName = "departures"),
               menuSubItem("Manage flights", tabName = "all_flights")
      ),
      menuItem("Reservations", tabName = "reservations", icon = icon("calendar-check")),
      menuItem("Luggage", tabName = "luggage", icon = icon("suitcase")),
      menuItem("Airlines", tabName = "airlines", icon = icon("globe-americas"),
               menuSubItem("Wizz Air", tabName = "wizzar"),
               menuSubItem("LOT", tabName = "lot"),
               menuSubItem("Ryanair", tabName = "ryanair")),
      menuItem("Employees", tabName = "employees", icon = icon("user-tie"))
    )
  ),
  
  # BODY -------------------------------------------------------------------
  dashboardBody(
    useShinyjs(),
    
    tabItems(
      
  #HOME ------------------------------------------------------------------------
      tabItem(
        tabName = "home", 
        h2("Welcome to AirPort app!"),
        
        fluidRow(
          box(
            title = "About app",
            solidHeader = TRUE, 
            background = "navy",
            width = 8,
            collapsible = TRUE,     
            style = "background-color: #f0f0f0; color: black;", 
            "This application is designed to support the smooth and efficient operation of our airport.",
            br(),
            "If you are accessing this platform, you are an essential part of our team ensuring everything runs seamlessly.",
            br(),
            
            "On the left side, you’ll find a user-friendly menu with key sections related to airport operations.",
            br(),
            "Each section provides valuable information and tools to help you perform your duties efficiently.",
            br(),
            
            "Thank you for your contribution to keeping our airport running smoothly!"
          )
        ),
        
        fluidRow(
          infoBox(
            title = "Total Flights",
            value = load.number.flights(),
            subtitle = "This month",
            icon = icon("plane"),
            color = "blue", 
            width = 6 
          ),
          valueBox(
            value = load.number.passenger(),
            subtitle = "Passengers Today",
            icon = icon("users"),
            color = "green", 
            width = 6 
          ),
          infoBox(
            title = "Most Chosen Destination",
            value = load.most.common.departure.destination(),
            subtitle = "Destination",
            icon = icon("map"),
            color = "orange", 
            width = 12
          )
        )
      ),
      
# FLIGHTS --------------------------------------------------------------------
  # SUBMENU- ARRIVALS-------------------------------------------------------
      tabItem(
        tabName = "arrivals",
        h2("Arrivals"),
        "Welcome to the Arrivals section!",
        br(),
"Here, you can monitor arrival schedules and access essential information.",
br(),

"Stay informed and ready for every landing.",
        br(), br(),
        tabBox(
          title = "",
          id = "tabset_arrivals",
          width = 12,
        # ALL ARRIVALS-----------------------------
          tabPanel(
            "All Arrivals", 
            "Below you can see all arrivals.",
            dataTableOutput("all_arrivals")
          ),
          
         #SEARCH FOR ARRIVAL------------------------ 
          tabPanel(
            "Search for arrival",
            fluidRow(
              column(
                width = 4,  
                selectInput(
                  "select_startairport",
                  "Select departure airport",
                  choices = c("All",load.startairport()),
                  selected = "All"
                )
              ),
              column(
                width = 4,  
                checkboxGroupInput(
                  "checkGroup_airline",
                  "Select airlines",
                  choices = load.airlines(),
                  selected = NULL
                )
              ),
              column(
                width = 4,  
                dateInput(
                  "date_arrival",
                  "Select date", 
                  value = '2025-02-04'
                )
              )
            ),
            
            
            fluidRow(
              column(
                width = 12,
                actionButton(
                  "search_arrival", 
                  "Search",
                  icon = icon("search")
                )
              )
            ),
            
            br(), br(),
            
            fluidRow(
              box(
                title = "Search Results",
                width = 12,
                solidHeader = TRUE,
                status='primary',
                dataTableOutput("search_results")
              )
            )
          )
        )
      ),
      
    #SUBMENU-DEPARTURES---------------------------------------------------------
      tabItem(
        tabName = "departures",
        h2("Departures"),
        "Welcome to the Departures section!",
        br(),
"Here, you can monitor departure schedules and access essential information.",
br(),
"Stay prepared and keep everything on track.",
        br(), br(),
        
        tabBox(
          title = "",
          id = "tabset_departures",
          width = 12,
          
        #ALL DEPARTURES---------------------------------------------------------  
          tabPanel(
            "All Departures", 
            "Below you can see all departures.",
            dataTableOutput("all_departures")
          ),
          
          #SEARCH DEPARTURE-----------------------------------------------------
          tabPanel(
            "Search for departure",
            
            
            fluidRow(
              column(
                width = 4,  
                selectInput(
                  "select_destination",
                  "Select destination",
                  choices = c("All",load.destination()),
                  selected="All"
                )
              ),
              column(
                width = 4,  
                checkboxGroupInput(
                  "checkGroup_airline_departures",
                  "Select airlines",
                  choices = load.airlines()
                )
              ),
              column(
                width = 4,  
                dateInput(
                  "date_departures",
                  "Select date", 
                  value = '2025-02-04'
                )
              )
            ),
            
            
            fluidRow(
              column(
                width = 12,
                actionButton(
                  "search_departures", 
                  "Search",
                  icon = icon("search")
                )
              )
            ),
            
            br(), br(),
            
            fluidRow(
              box(
                title = "Search Results",
                width = 12,
                solidHeader = TRUE,
                status='primary',
                dataTableOutput("search_results_departures")
              )
            )
          )
        )
      ),
      
    #SUBMENU-MANAGE FLIGHTS----------------------------------------------------- 
      tabItem(
        tabName = "all_flights", 
        h2("Manage flights"),
        "Welcome to the Manage Flights section!",
        br(),
        "Here, you can oversee flight details, update schedules, and ensure efficient airport operations.",
        br(),br(),
        
        tabBox(
          title = "Flights options",
          id = "tabset_flights",
          width = 12,
          
          #ALL FLIGHTS----------------------------------------------------------
          tabPanel(
            "All flights", 
            "Here you can see all flights",
            dataTableOutput("all_flights_manage")
          ),
          
          #GATE ASSIGMENT
          tabPanel("Gate Assigment",
                   h3("Here you can assign a gate for future departure"),
                   selectInput(
                     "flight_id_gate",
                     "Select Flight ID:",
                     choices = as.list(load.no_gate.departure()), 
                     selected = NULL
                   ),
                   selectInput(
                     "gate_id",
                     "Select Gate ID:",
                     choices = load.gates(), 
                     selected = NULL
                   ),
                   
                   actionButton(
                     "add_gate_assigment",
                     "Assign",
                     icon = icon("check-circle"),
                     style = "color: white; background-color: #28a745; border-color: #28a745; font-weight: bold; padding: 10px 20px; font-size: 16px; border-radius: 5px;"
                   ),
                   textOutput("assign_status") 
                   
          ),
          #UPDATE FLIGHT----------------------------------------------------------
          tabPanel(
            "Update flight",
            h3("Update a Flight"),
            
            selectInput(
              "flight_id_update",
              "Input flight ID:",
              choices=as.list(load.flights()),
              selected='5'
            ),
            
            fluidRow(
              box(
                title = "Informations about flight",
                width = 12,
                solidHeader = TRUE,
                status='primary',
                collapsible = TRUE,
                tableOutput("flight_to_update")
              )
            ),
            strong("Choose what do you want to update:"),
            br(),
            br(),
            #UPDATE OPTIONS------------------------------------------------------ 
            tabBox(
              title = "Update options",
              id = "tabset_update",
              width = 12,
              br(),
              #DEPARTURE TIME--------------------------------------------------
              tabPanel(
                "Departure Time",
                dateInput(
                  "date_update_departure",
                  "Select date:",
                  value = '2025-02-04'
                ),
                timeInput(
                  "departure_time",
                  "Select new departure time:",
                  value = as.POSIXct("12:00:00", format = "%H:%M:%S"),
                  seconds = TRUE
                )
              ),
              #ARRIVAL TIME-----------------------------------------------------
              tabPanel(
                "Arrival Time",
                dateInput(
                  "date_update_arrival",
                  "Select date:",
                  value ='2025-02-04'
                ),
                timeInput(
                  "arrival_time",
                  "Select new arrival time:",
                  value = as.POSIXct("12:00:00", format = "%H:%M:%S"),
                  seconds = TRUE
                )
              ),
              #STATUS-----------------------------------------------------------
              tabPanel(
                "Status",
                radioButtons(
                  "radio_update_status",
                  strong("Select new status:"),
                  choices = list("Planned" = "planned", "Delayed" = "delayed", "Cancelled" = "cancelled"),
                  selected = NULL
                )
              )
            ),
            
            fluidRow(
              column(
                width = 12,
                strong("Confirm update:"),
                actionButton(
                  "update_button", 
                  "Update",
                  icon = icon("check")
                )
              )
            )
          ),
      #ADD FLIGHT--------------------------------------------------------------  
          tabPanel(
            "Add flight",
            
            h3("Add a New Flight"),
            
            fluidRow(
              column(
                width = 12,
                box(
                  title = "Available connections",
                  solidHeader = TRUE,
                  status = "primary",
                  width = 12,
                  collapsible = TRUE,
                  dataTableOutput("destinations_table")
                )
              )
            ),
            
            br(),
            
            fluidRow(
              column(
                width = 12,
                selectInput(
                  "select_id_destination_add",
                  strong("Select id_destination:"),
                  choices = load.destinations(),
                  selected = NULL
                )
              )
            ),
            
            br(),
            
            fluidRow(
              column(
                width = 6,
                dateInput(
                  "date_add_departure",
                  "Select departure date:",
                  value = '2025-02-04'
                ),
                timeInput(
                  "add_departure_time",
                  "Select departure time:",
                  value = as.POSIXct("12:00:00", format = "%H:%M:%S"),
                  seconds = TRUE
                )
              ),
              column(
                width = 6,
                dateInput(
                  "date_add_arrival",
                  "Select arrival date:",
                  value = '2025-02-04'
                ),
                timeInput(
                  "add_arrival_time",
                  "Select arrival time:",
                  value = as.POSIXct("12:00:00", format = "%H:%M:%S"),
                  seconds = TRUE
                )
              )
            ),
            
            fluidRow(
              column(
                width = 12,
                strong("Confirm addition:"),
                actionButton(
                  "add_flight", 
                  "ADD",
                  icon = icon("plus"),
                  style = "margin-top: 20px; background-color: #4CAF50; color: white;"
                )
              )
            )
          ),
      #REMOVE FLIGHT-----------------------------------------------------------
          tabPanel(
            "Remove flight",
            
            h3("Remove a Flight"),
            
            fluidRow(
              column(
                width = 12,
                div(
                  class = "alert alert-warning",
                  icon("exclamation-triangle", lib = "font-awesome"),
                  strong("Warning: "),
                  "You can only remove flights with a status of 'Cancelled'."
                )
              )
            ),
            
            br(),
            
            fluidRow(
              column(
                width = 12,
                box(
                  title = "Cancelled Flights",
                  solidHeader = TRUE,
                  status = "danger",
                  width = 12,
                  collapsible = TRUE,
                  dataTableOutput("cancelled_flights_table")
                )
              )
            ),
            
            br(),
            
            fluidRow(
              column(
                width = 6,
                selectInput(
                  "flight_id_remove",
                  "Select Flight ID:",
                  choices = load.cancelled.flights(), 
                  selected = NULL
                )
              )
            ),
            
            br(),
            
            fluidRow(
              column(
                width = 12,
                actionButton(
                  "remove_flight_button",
                  "Remove Flight",
                  icon = icon("trash"),
                  class = "btn-danger"
                )
              )
            )
          )
        )
      ),
    
#LUGGAGE-----------------------------------------------------------------------
    tabItem(tabName = "luggage",
            fluidPage(
              titlePanel("Luggage Management"),
              "Welcome to the Luggage Management panel!",
              br(),
              "Here, you can track and organize luggage details efficiently.",
              br(),
              "Streamline your operations and ensure every bag finds its way to the right destination.",
              br(),br(),
              tabBox(
                width = 12,
                #SEARCH LUGGAGE-------------------------------------------------
                tabPanel("Search Luggage",
                         fluidRow(
                           column(12,
                                  selectInput("search_luggage_id", "Select Luggage ID:",
                                              choices = as.list(load.luggage())),
                                  actionButton("search_luggage_btn", "Search Luggage",
                                               icon = icon("search"))
                           )
                         ),
                         br(),
                         br(),
                         fluidRow(
                           box(
                             title = "Search Results",
                             width = 12,
                             solidHeader = TRUE,
                             status = "primary", 
                             dataTableOutput("search_luggage")  
                           )
                         )
                ),
                #ADD LUGGAGE----------------------------------------------------
                tabPanel("Add Luggage",
                         fluidRow(
                           column(
                             width=12,
                             div(
                               class = "alert alert-warning",
                               icon("exclamation-triangle", lib = "font-awesome"),
                               strong("Warning: "),
                               "You can only add luggage to flights that have not yet occurred."
                             )
                           ),
                           column(4,
                                  selectInput("reservation_luggage_id", "Select reservation ID:",
                                              choices=as.list(load.future.reservations())),
                                  selectInput("weight_luggage", "Enter weight:",
                                              choices=c(10,20,30)),
                                  
                                  
                                  strong("Confirm addition:"),
                                  actionButton(
                                    "add_luggage", 
                                    "ADD",
                                    icon = icon("plus"),
                                    style = "margin-top: 20px; background-color: #4CAF50; color: white;"
                                  )
                           )
                         )
                ),
                #REMOVE LUGGAGE------------------------------------------------
                tabPanel("Remove Luggage",
                         fluidRow(
                           column(
                             width=12,
                             div(
                               class = "alert alert-warning",
                               icon("exclamation-triangle", lib = "font-awesome"),
                               strong("Warning: "),
                               "You can only remove luggage for flights that have not yet occurred."
                             )
                           ),
                           column(4,
                                  selectInput("luggage_remove", "Select Luggage ID:", 
                                              choices = as.list(load.remove.luggage())),
                                  actionButton(
                                    "remove_luggage_button",
                                    "Remove Luggage",
                                    icon = icon("trash"),
                                    class = "btn-danger"
                                  )
                           ),
                           column(8,
                                  verbatimTextOutput("remove_luggage_status")
                           )
                         )
                ),
                #UPDATE STATUS--------------------------------------------------
                tabPanel("Update Status",
                         selectInput("status_luggage_id", "Select Luggage  ID:",
                                     choices=as.list(load.luggage())),
                         fluidRow(
                           column(4,
                                  radioButtons(
                                    "radio_update_luggage_status",
                                    strong("Select new status:"),
                                    choices = list('Checked-in','Loaded','Awaiting Pick-up','Lost','Found','Claimed'),
                                    selected = NULL
                                  )
                         ),
                         column(
                           width = 12,
                           strong("Confirm update:"),
                           actionButton(
                             "update_luggage", 
                             "Update",
                             icon = icon("check")
                           )
                         )
                         
                )
              )
            )
            )
    ),
    
#RESERVATIONS-------------------------------------------------------------------
    tabItem(tabName = "reservations",
            fluidPage(
              titlePanel("Reservations Management"),
              "Welcome to the Reservations Management section!",
              br(),
              
              "Here, you can access passenger lists, check the number of passengers, and manage bookings seamlessly.",
              br(),
              "Add new reservations and passengers to ensure an efficient and smooth travel experience for all customers.",
              br(),
              
              "Stay organized and in control of all your booking needs.",
              br(),br(),
              
              tabBox(
                width = 12,
                #LIST OF PASSENGERS--------------------------------------------
                tabPanel("List of Passengers",
                         fluidRow(
                           column(12,
                                  selectInput("select_flight_reservation", "Select Flight:", 
                                              choices = as.list(load.flights())),
                                  actionButton("show_list_passengers", "Show Passengers")
                           ),
                           column(12,
                                  dataTableOutput("passengers_table"),
                                  verbatimTextOutput("occupancy_info")
                           )
                         )
                ),
                #ADD RESERVATION-----------------------------------------------
                tabPanel("Add Reservation",
                         fluidRow(
                           column(
                             width = 12,
                             box(
                               title = "All Passengers",
                               status = "primary",
                               solidHeader = TRUE,
                               collapsible = TRUE,
                               collapsed = TRUE,
                               width = NULL,
                               style = "margin-top: 10px; margin-bottom: 10px;",
                               dataTableOutput("all_passengers_table") 
                             )
                           )
                         ),
                         fluidRow(
                           column(
                             width = 6,
                             selectInput("flight_add_reservation", "Select Flight:", 
                                         choices = as.list(load.future.flights()))
                           ),
                           column(
                             width = 6,
                             selectInput("select_passenger", "Select Passenger ID:", 
                                         choices = as.list(load.passengers()))
                           )
                         ),
                         fluidRow(
                           column(
                             width = 12,
                             strong("Confirm addition:"),
                             actionButton(
                               "add_reservation", 
                               "ADD",
                               icon = icon("plus"),
                               style = "margin-top: 20px; background-color: #4CAF50; color: white;"
                             )
                           )
                         )
                ),
                #ADD PASSENGER--------------------------------------------------
                tabPanel("Add Passenger",
                                  textInput("passenger_first_name", "Passenger First name:"),
                                  textInput("passenger_last_name", "Passenger Last name:"),
                                  textInput("document", "Input Document number:"),
                                  dateInput('date_of_birth',"Select Date of birth:"),
                                  radioButtons("gender", "Choose gander:",
                                               choices=c("M","F")),
                                  textInput("email", "Input email:"),
                                  textInput("phone", "Input phone number:"),
                                  strong("Confirm addition:"),
                                  actionButton(
                                    "add_passenger", 
                                    "ADD",
                                    icon = icon("plus"),
                                    style = "margin-top: 20px; background-color: #4CAF50; color: white;"
                                  )
                )       
              )
            )
    ),
#AIRLINES----------------------------------------------------------------------
  #WIZZAiR---------------------------------------------------------------------
tabItem(tabName = "wizzar",
        h2("Wizz Air"),
        "Welcome to the Wizz Air Management Panel!",
        br(),
        "Here, you can access detailed information about Wizz Air's operations.",
        br(),
        "Use the tools provided to manage aircrafts, view connection details, and keep the operations running smoothly",
        br(),
        br(),
        tabBox(
          width = 12,
          
          #INFORMATION----------------------------------------------------------
          tabPanel("Information",
                   fluidRow(
                     column(12, 
                            infoBox(
                              "Origin of the line", 
                              value = "Poland", 
                              icon = icon("location-arrow"),
                              color = "aqua",
                              width = 12
                            )
                     ),
                     column(6, 
                            infoBox(
                              "Most Chosen Destination", 
                              value = load.most.common.departure.destination.wizzair(), 
                              icon = icon("plane"),
                              color = "light-blue",
                              width = 12
                            )
                     ),
                     column(6, 
                            valueBox(
                              value = load.total.unique.passengers.wizzair(),
                              subtitle = "Total passengers",
                              icon = icon("users"),
                              color = "green", 
                              width = 12
                            )
                     ),
                     column(12, 
                            box(
                              title = "Supported connections", 
                              status = "primary", 
                              solidHeader = TRUE, 
                              width = NULL,
                              collapsible = TRUE,
                              dataTableOutput("connections_table_wizzair")
                            )
                     )
                   )
          ),
          #AIRCRAFTS-----------------------------------------------------------
          tabPanel("Aircrafts", 
                   fluidRow(
                     column(
                       width = 12, 
                       box(
                         title = "Owned aircrafts",
                         status = "primary", 
                         solidHeader = TRUE, 
                         width = NULL,
                         collapsible = TRUE,
                         style = "margin-top: 10px; margin-bottom: 10px; padding-left: 10px; padding-right: 10px;", 
                         dataTableOutput("owned_aircraft_table_wizzair")
                       )
                     )
                   ),
                   
                   fluidRow(
                     column(
                       width = 12,
                       tabBox(
                         title = "Aircraft Options",
                         id = "tabset_aircraft",
                         width = 12,
                         
                         #ADD AIRCRAFT-----------------------------------------
                         tabPanel("Add", 
                                  fluidRow(
                                    column(6, 
                                           textInput("model_wizzair", "Model:")
                                                       
                                    ),
                                    column(6, 
                                           numericInput("seats_wizzair", "Seats number:", value = 150, min = 1)
                                    )
                                  ),
                                  fluidRow(
                                    column(6, 
                                           numericInput("range_wizzair", "Range (in km):", value = 5000, min = 1)
                                    ),
                                    column(6, 
                                           numericInput("fuel_consumption_wizzair", "Fuel Consumption (l/h):", value = 500, min = 1)
                                    )
                                  ),
                                  fluidRow(
                                    column(6, 
                                           selectInput("fuel_type_wizzair", "Fuel Type:", choices = c("Jet A1", "SAF"))
                                    ),
                                    column(6, 
                                           actionButton("add_aircraft_wizzair", "Add", icon = icon("plus"), 
                                                        style = "margin-top: 20px; background-color: #4CAF50; color: white;")
                                    )
                                  )
                         ),
                        #REMOVE AIRCRAFT----------------------------------------
                         tabPanel("Remove", 
                                  fluidRow(
                                    column(12, 
                                           selectInput("aircraft_id_select_wizzair", "Select aircraft ID:", 
                                                       choices = as.list(load.owned.aircraft.ids.wizzair()))
                                    )
                                  ),
                                  fluidRow(
                                    column(12, 
                                           actionButton("remove_aircraft_wizzair", "Remove", icon = icon("trash"), 
                                                        style = "margin-top: 20px; background-color: #FF5733; color: white;")
                                    )
                                  )
                         ),
                        #SHARE AIRCRAFT-----------------------------------------------
                        tabPanel("Share Aircraft", 
                                 fluidRow(
                                   column(12, 
                                          box(
                                            title = "Flights without assigned aircraft",
                                            status = "danger",
                                            solidHeader = TRUE,
                                            width = NULL,
                                            collapsible = TRUE,
                                            dataTableOutput("flights_without_aircraft_table_wizzair") 
                                          )
                                   )
                                 ),
                                 fluidRow(
                                   column(6, 
                                          selectInput(
                                            "select_flight_without_aircraft_wizzair", 
                                            "Select flight to assign aircraft:", 
                                            choices = as.list(load.wizzair.flight.ids.without.aircraft())
                                          )
                                   ),
                                   column(6, 
                                          selectInput(
                                            "select_new_aircraft_wizzair", 
                                            "Select new aircraft:", 
                                            choices = as.list(load.owned.aircraft.ids.wizzair())
                                          )
                                   )
                                 ),
                                 fluidRow(
                                   column(12, 
                                          actionButton("assign_aircraft_button_wizzair", "Share", 
                                                       icon = icon("share"),
                                                       style = "margin-top: 20px; background-color: #4CAF50; color: white;")
                                   )
                                 )
                        )
                       )
                     )
                   )
          )
        )
),



#LOT----------------------------------------------------------------------------
tabItem(tabName = "lot",
        h2("LOT"),
        "Welcome to the LOT Management Panel!",
        br(),
        "Here, you can access detailed information about LOT's operations.",
        br(),
        "Use the tools provided to manage aircrafts, view connection details, and keep the operations running smoothly",
        br(),
        br(),
        tabBox(
          width = 12,
          
          #INFORMATION
          tabPanel("Information",
                   fluidRow(
                     column(12, 
                            infoBox(
                              "Origin of the line", 
                              value = "Poland", 
                              icon = icon("location-arrow"),
                              color = "aqua",
                              width = 12
                            )
                     ),
                     column(6, 
                            infoBox(
                              "Most Chosen Destination", 
                              value = load.most.common.departure.destination.lot(), 
                              icon = icon("plane"),
                              color = "light-blue",
                              width = 12
                            )
                     ),
                     column(6, 
                            valueBox(
                              value = load.total.unique.passengers.lot(),
                              subtitle = "Total passengers",
                              icon = icon("users"),
                              color = "green", 
                              width = 12
                            )
                     ),
                     column(12, 
                            box(
                              title = "Supported connections", 
                              status = "primary", 
                              solidHeader = TRUE, 
                              width = NULL,
                              collapsible = TRUE,
                              dataTableOutput("connections_table_lot")
                            )
                     )
                   )
          ),
          
          #AIRCRAFTS------------------------------------------------------------
          tabPanel("Aircrafts", 
                   fluidRow(
                     column(
                       width = 12, 
                       box(
                         title = "Owned aircrafts",
                         status = "primary", 
                         solidHeader = TRUE, 
                         width = NULL,
                         collapsible = TRUE,
                         style = "margin-top: 10px; margin-bottom: 10px; padding-left: 10px; padding-right: 10px;", 
                         dataTableOutput("owned_aircraft_table_lot")
                       )
                     )
                   ),
                   
                   fluidRow(
                     column(
                       width = 12,
                       tabBox(
                         title = "Aircraft Options",
                         id = "tabset_aircraft_lot",
                         width = 12,
                         
                         #ADD AIRCRAFT------------------------------------------
                         tabPanel("Add", 
                                  fluidRow(
                                    column(6, 
                                           textInput("model_lot", "Model:")
                                    ),
                                    column(6, 
                                           numericInput("seats_lot", "Seats number:", value = 180, min = 1)
                                    )
                                  ),
                                  fluidRow(
                                    column(6, 
                                           numericInput("range_lot", "Range (in km):", value = 6000, min = 1)
                                    ),
                                    column(6, 
                                           numericInput("fuel_consumption_lot", "Fuel Consumption (l/h):", value = 700, min = 1)
                                    )
                                  ),
                                  fluidRow(
                                    column(6, 
                                           selectInput("fuel_type_lot", "Fuel Type:", choices = c("Jet A1", "SAF"))
                                    ),
                                    column(6, 
                                           actionButton("add_aircraft_lot", "Add", icon = icon("plus"), 
                                                        style = "margin-top: 20px; background-color: #4CAF50; color: white;")
                                    )
                                  )
                         ),
                         #REMOVE AIRCRAFT---------------------------------------
                         tabPanel("Remove", 
                                  fluidRow(
                                    column(12, 
                                           selectInput("aircraft_id_select_lot", "Select aircraft ID:", 
                                                       choices = as.list(load.owned.aircraft.ids.lot()))
                                    )
                                  ),
                                  fluidRow(
                                    column(12, 
                                           actionButton("remove_aircraft_lot", "Remove", icon = icon("trash"), 
                                                        style = "margin-top: 20px; background-color: #FF5733; color: white;")
                                    )
                                  )
                         ),
                         #SHARE AIRCRAFT-----------------------------------------------
                         tabPanel("Share Aircraft", 
                                  fluidRow(
                                    column(12, 
                                           box(
                                             title = "Flights without assigned aircraft",
                                             status = "danger",
                                             solidHeader = TRUE,
                                             width = NULL,
                                             collapsible = TRUE,
                                             dataTableOutput("flights_without_aircraft_table_lot") 
                                           )
                                    )
                                  ),
                                  fluidRow(
                                    column(6, 
                                           selectInput(
                                             "select_flight_without_aircraft_lot", 
                                             "Select flight to assign aircraft:", 
                                             choices =as.list(load.lot.flight.ids.without.aircraft())
                                           )
                                    ),
                                    column(6, 
                                           selectInput(
                                             "select_new_aircraft_lot", 
                                             "Select new aircraft:", 
                                             choices = as.list(load.owned.aircraft.ids.lot())
                                           )
                                    )
                                  ),
                                  fluidRow(
                                    column(12, 
                                           actionButton("assign_aircraft_button_lot", "Share", 
                                                        icon = icon("share"),
                                                        style = "margin-top: 20px; background-color: #4CAF50; color: white;")
                                    )
                                  )
                         )
                       )
                     )
                   )
          )
          
        )
),
#RYANAIR------------------------------------------------------------------------
tabItem(tabName = "ryanair",
        h2("Ryanair"),
        "Welcome to the Ryanair Management Panel!",
        br(),
        "Here, you can access detailed information about Ryanair's operations.",
        br(),
        "Use the tools provided to manage aircraft, view connection details, and keep the operations running smoothly.",
        br(),
        br(),
        
        tabBox(
          width = 12,
          
          # INFORMATION ---------------------------------------------------------
          tabPanel("Information",
                   fluidRow(
                     column(12, 
                            infoBox(
                              "Origin of the line", 
                              value = "Ireland", 
                              icon = icon("location-arrow"),
                              color = "aqua",
                              width = 12
                            )
                     ),
                     column(6, 
                            infoBox(
                              "Most Chosen Destination", 
                              value = load.most.common.departure.destination.ryanair(), 
                              icon = icon("plane"),
                              color = "light-blue",
                              width = 12
                            )
                     ),
                     column(6, 
                            valueBox(
                              value = load.total.unique.passengers.ryanair(),
                              subtitle = "Total passengers",
                              icon = icon("users"),
                              color = "green", 
                              width = 12
                            )
                     ),
                     column(12, 
                            box(
                              title = "Supported connections", 
                              status = "primary", 
                              solidHeader = TRUE, 
                              width = 12,
                              collapsible = TRUE,
                              dataTableOutput("connections_table_ryanair")
                            )
                     )
                   )
          ),
          
          # AIRCRAFTS -----------------------------------------------------------
          tabPanel("Aircrafts", 
                   fluidRow(
                     column(12, 
                            box(
                              title = "Owned aircraft",
                              status = "primary", 
                              solidHeader = TRUE, 
                              width = 12,
                              collapsible = TRUE,
                              style = "margin-top: 10px; margin-bottom: 10px; padding-left: 10px; padding-right: 10px;",  
                              dataTableOutput("owned_aircraft_table_ryanair")
                            )
                     )
                   ),
                   
                   fluidRow(
                     column(12,
                            tabBox(
                              title = "Aircraft Options",
                              id = "tabset_aircraft_ryanair",
                              width = 12,
                              
                              # ADD AIRCRAFT -------------------------------------
                              tabPanel("Add", 
                                       fluidRow(
                                         column(6, 
                                                textInput("model_ryanair", "Model:")
                                         ),
                                         column(6, 
                                                numericInput("seats_ryanair", "Seats number:", value = 200, min = 1)
                                         )
                                       ),
                                       fluidRow(
                                         column(6, 
                                                numericInput("range_ryanair", "Range (in km):", value = 4000, min = 1)
                                         ),
                                         column(6, 
                                                numericInput("fuel_consumption_ryanair", "Fuel Consumption (l/h):", value = 600, min = 1)
                                         )
                                       ),
                                       fluidRow(
                                         column(6, 
                                                selectInput("fuel_type_ryanair", "Fuel Type:", choices = c("Jet A1", "SAF"))
                                         ),
                                         column(6, 
                                                actionButton("add_aircraft_ryanair", "Add", icon = icon("plus"), 
                                                             style = "margin-top: 20px; background-color: #4CAF50; color: white;")
                                         )
                                       )
                              ),
                              # REMOVE AIRCRAFT ---------------------------------
                              tabPanel("Remove", 
                                       fluidRow(
                                         column(12, 
                                                selectInput("aircraft_id_select_ryanair", "Select aircraft ID:", 
                                                            choices = as.list(load.owned.aircraft.ids.ryanair()))
                                         )
                                       ),
                                       fluidRow(
                                         column(12, 
                                                actionButton("remove_aircraft_ryanair", "Remove", icon = icon("trash"), 
                                                             style = "margin-top: 20px; background-color: #FF5733; color: white;")
                                         )
                                       )
                              ),
                              #SHARE AIRCRAFT-----------------------------------------------
                              tabPanel("Share Aircraft", 
                                       fluidRow(
                                         column(12, 
                                                box(
                                                  title = "Flights without assigned aircraft",
                                                  status = "danger",
                                                  solidHeader = TRUE,
                                                  width = NULL,
                                                  collapsible = TRUE,
                                                  dataTableOutput("flights_without_aircraft_table_ryanair") 
                                                )
                                         )
                                       ),
                                       fluidRow(
                                         column(6, 
                                                selectInput(
                                                  "select_flight_without_aircraft_ryanair", 
                                                  "Select flight to assign aircraft:", 
                                                  choices = as.list(load.ryanair.flight.ids.without.aircraft())
                                                )
                                         ),
                                         column(6, 
                                                selectInput(
                                                  "select_new_aircraft_ryanair", 
                                                  "Select new aircraft:", 
                                                  choices = as.list(load.owned.aircraft.ids.ryanair()) 
                                                )
                                         )
                                       ),
                                       fluidRow(
                                         column(12, 
                                                actionButton("assign_aircraft_button_ryanair", "Share", 
                                                             icon = icon("share"),
                                                             style = "margin-top: 20px; background-color: #4CAF50; color: white;")
                                         )
                                       )
                              )
                            )
                     )
                   )
          )
        )
),
#EMPLOYEES----------------------------------------------------------------------
tabItem(tabName = "employees",
        fluidPage(
          titlePanel("Employee Management"),
          "Welcome to Employee Management!",
          br(),
          "Here, you can manage your organization's employees efficiently.",
          br(),
          "View the employee list, monitor statistics, and handle hiring or firing processes.",
          br(),
          "Stay organized and keep your team at its best!",
          br(),br(),
          
          tabBox(
            width = 12,
            
            # INFORMATION PANEL ----------------------------------------------
            tabPanel("Information",
                     "Below you can see all the airport employees",
                     br(),
                     br(),
                     fluidRow(
                       column(12,
                              box(
                                title = "Employee List",
                                width = 12,
                                solidHeader = TRUE,
                                status = "primary",
                                dataTableOutput("employee_list"),
                                verbatimTextOutput("total_employees")
                              )
                       )
                     ),
                     br(),
                     fluidRow(
                       column(12,
                              infoBox(
                                title = "Longest-Serving Employee",
                                textOutput("longest_serving_employee_name"),
                                subtitle = textOutput("longest_serving_years"),
                                icon = icon("user"),
                                color = "blue"
                              )
                       )
                     )
            ),
            
            # MANAGE PANEL ---------------------------------------------------
            tabPanel("Manage",
                     fluidRow(
                       column(
                         width = 12,
                         tabBox(
                           title = "Employee Options",
                           id = "manage_tabs",
                           width = 12,
                           
                           # FIRE EMPLOYEE TAB ---------------------------------
                           tabPanel("Fire Employee",
                                    fluidRow(
                                      column(12,
                                             selectInput("employee_to_fire", 
                                                         "Select Employee:",
                                                         choices = as.list(load.employees()))
                                      )
                                    ),
                                    fluidRow(
                                      column(12,
                                             actionButton("fire_employee_btn", 
                                                          "Fire Employee",
                                                          icon = icon("user-slash"),
                                                          style = "margin-top: 20px; background-color: #FF5733; color: white;")
                                      )
                                    )
                           ),
                           
                           # HIRE EMPLOYEE TAB ---------------------------------
                           tabPanel("Hire Employee",
                                    fluidRow(
                                      column(6, 
                                             textInput("new_employee_first_name", "First Name:")
                                      ),
                                      column(6, 
                                             textInput("new_employee_last_name", "Last Name:")
                                      )
                                    ),
                                    fluidRow(
                                      column(6, 
                                             textInput("new_employee_position", "Position:")
                                      )
                                    ),
                                    fluidRow(
                                      column(6, 
                                             selectInput("new_employee_department_id", "Department ID:", choices=as.list(load.departments()))
                                      ),
                                      column(6, 
                                             actionButton("hire_employee_btn", 
                                                          "Hire Employee",
                                                          icon = icon("user-plus"),
                                                          style = "margin-top: 20px; background-color: #4CAF50; color: white;")
                                      )
                                    )
                           )
                         )
                       )
                     )
            )
          )
        )
)
      )
    )

  )


