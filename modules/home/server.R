
observe({
  
  shinyWidgets::updatePickerInput(
    session,
    inputId = "series_chosen",
    choices = table_sgs %>%
      dplyr::filter(state == input$states_chosen &
                      seasonal_adjusted == as.numeric(input$use_seasonally_adjusted)) %>%
      dplyr::pull(name) %>%
      unique() %>%
      sort()
  )
  
})

dataset_states <-
  reactive({
    
    df <-
      table_sgs %>% 
      dplyr::filter(
        state == input$states_chosen
      )
    
    return(df)
    
  })

time_series_df <-
  reactive({
    
    serie <- input$series_chosen
    
    series_code <-
      dataset_states() %>% 
      dplyr::filter(
        name == serie &
          seasonal_adjusted == input$use_seasonally_adjusted
      ) %>% 
      dplyr::pull(code) %>% 
      .[1]
    
    
    time_series <-
      rbcb::get_series(c(valor = series_code)) %>% 
      mutate(
        series_code = series_code
      )  
    
  })

output$plot_series <- 
  renderHighchart({
    
    time_series <- 
      time_series_df()
    
    series_code <-
      time_series %>% 
      dplyr::pull(series_code) %>% 
      unique()
    
    title <-
      table_sgs %>% 
      dplyr::filter(
        code == series_code
      ) %>% 
      dplyr::pull(description) %>% 
      paste0(., " - Código: ", series_code)
    
    serie <-
      table_sgs %>% 
      dplyr::filter(
        code == series_code
      ) %>% 
      dplyr::pull(name)
    
    highchart(type = "stock") %>%
      hc_add_series(time_series, "line", hcaes(x = date, y = valor), name = serie) %>%
      hc_xAxis(type = "datetime") %>% 
      hc_title(text = title) %>% 
      hc_subtitle(text = "Dados extraídos do Sistema Gerenciador de Séries Temporais do Banco Central") %>% 
      hc_rangeSelector(buttons = list(
        list(type = 'month', count = 6, text = "6m"),
        list(type = 'year', count = 1, text = "1y"),
        list(type = 'year', count = 2, text = "2y"),
        list(type = 'year', count = 5, text = "5y"),
        list(type = 'all', text = "All")
      )) %>% 
      hc_add_theme(return_chosen_theme_hc(input$hc_theme_choice))
    
    
  })
