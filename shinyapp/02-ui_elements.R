# Input -------------------------------------------------------------------

# list of countries in data
load("./data/hmdcbook.Rdata")
# country labels
cntry_lab  <- hmdcbook$Label

# UI Elements -------------------------------------------------------------

# country dropdown menu
cntry_dropdown <-
  column(4,
         selectInput("country",
                     label     = "Choose Country",
                     choices   = cntry_lab, multiple = FALSE,
                     selected  = "Sweden",
                     selectize = FALSE)
  )

# country comparison dropdown menu
cntry1_diff_dropdown <-
  column(2,
         selectInput("country_1",
                     label     = "Choose Country 1",
                     choices   = cntry_lab, multiple = FALSE,
                     selected  = "Sweden",
                     selectize = FALSE)
  )
cntry2_diff_dropdown <-
  column(2,
         selectInput("country_2",
                     label     = "Choose Country 2",
                     choices   = cntry_lab, multiple = FALSE,
                     selected  = "Denmark",
                     selectize = FALSE)
  )

# sex radio button
sex_radio <-
  column(1,
         # sex checkbox
         radioButtons(inputId = "sex",
                      label   = "Choose Sex",
                      choices = list(Total  = "fm",
                                     Female = "f",
                                     Male   = "m"),
                      selected = "fm")
  )

# show/hide advanced options
advanced_switch <-
  checkboxInput(inputId = "advanced",
                label   = "Advanced Options",
                value   = FALSE)

# timebase radio button
timebase_radio <-
         radioButtons(inputId = "timebase",
                      label   = "Choose Timebase",
                      choices = list(Period  = "period",
                                     Cohort  = "cohort"),
                      selected = "period")

# scale switch
scale_switch <-
  checkboxInput(inputId = "cont_scale",
                label   = "Continuous Scale",
                value   = FALSE)

# option to put grid on top
grid_on_top_switch <-
  checkboxInput(inputId = "grid_on_top",
                label   = "Grid on Top",
                value   = FALSE)

# about
about <-
  column(5,
         p("Idea & Realization:", br(),
           a(href = "https://github.com/jschoeley", "Jonas Schöley"), "at",
           a(href = "http://www.sdu.dk/en/om_sdu/institutter_centre/maxo", br(),
             "Max-Planck Odense Center on the Biodemography of Aging")),
         p("Data Source:", br(),
           a(href = "http://www.mortality.org/", "Human Mortality Database"),
           "retrieved March 6, 2016"),
         p("Register at", a(href = "http://www.mortality.org/", "http://www.mortality.org/"),
           "to download the data and learn more about it.")
  )

# UI Functions ------------------------------------------------------------

UIPlotTitle <- function(title) {
  fluidRow(class = "plot_main_title",
           h4(textOutput(title),
              align = "center"))
}

UIPlotSubTitle <- function(subtitle) {
  fluidRow(class = "plot_sub_title",
           h5(textOutput(subtitle),
              align = "center"))
}

UIPlot <- function (plot) {
  fluidRow(class = "plotRow",
           plotOutput(plot, height = "100%"))
}
