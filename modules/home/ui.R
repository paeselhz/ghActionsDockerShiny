home_ui <-
  tabPanel(
    title = "Home Page",
    icon = icon("line-chart"),
    value = "home_page",
    column(
      width = 3,
      pickerInput(
        inputId = "states_chosen",
        choices = list(
          `Brasil` = table_sgs %>% 
            dplyr::filter(is_state != 1) %>% 
            dplyr::pull(state) %>% 
            unique() %>% 
            sort(),
          `Estados` = table_sgs %>% 
            dplyr::filter(is_state == 1) %>% 
            dplyr::pull(state) %>% 
            unique() %>% 
            sort()
        ),
        selected = "Brasil",
        multiple = FALSE
      ),
      pickerInput(
        inputId = "series_chosen",
        choices = table_sgs %>% 
          dplyr::filter(
            state == "Brasil"
          ) %>% 
          dplyr::pull(name) %>% 
          unique() %>% 
          sort(),
        multiple = FALSE
      ),
      materialSwitch(
        inputId = "use_seasonally_adjusted",
        label = "Apenas Séries com Ajuste Sazonal", 
        value = FALSE,
        status = "primary"
      ),
      radioGroupButtons(
        inputId = "hc_theme_choice",
        label = "Escolha o tema do gráfico Highchart",
        choices = c("538", 
                    "Elementary",
                    "GGPlot2", 
                    "Google",
                    "Null"),
        selected = "GGPlot2",
        individual = TRUE,
        checkIcon = list(
          yes = tags$i(class = "fa fa-circle", 
                       style = "color: steelblue"),
          no = tags$i(class = "fa fa-circle-o", 
                      style = "color: steelblue"))
      )
    ),
    column(
      width = 9,
      highchartOutput("plot_series",
                      height = "500px") %>% 
        withSpinner(type = 4,
                    color = "#6cb73b")
    )
  )