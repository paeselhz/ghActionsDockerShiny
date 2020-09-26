get_sgs_bacen <-
  function(series_code, 
           initial_date = "1900-01-01",
           final_date   = Sys.Date()) {
    
    `%>%` <- magrittr::`%>%`
    
    initial_date <- as.Date(initial_date, format = '%Y-%m-%d')
    final_date   <- as.Date(final_date, format = '%Y-%m-%d')
    
    url_consulta <-
      paste0(
        'https://api.bcb.gov.br/dados/serie/bcdata.sgs.',
        series_code,
        '/dados?formato=json&dataInicial=', initial_date,
        '&dataFinal=', final_date
      )
    
    df <- NA
    
    suppressWarnings({
      
      while(is.na(df)) {
        
        df <-
          tryCatch({
            httr::content(httr::GET(url_consulta)) %>%
              purrr::map_df(
                tidyr::as_tibble
              ) %>% 
              dplyr::mutate(
                data = as.Date(data, format = '%d/%m/%Y'),
                series_code = series_code
              )    
          },
          error = function(error){
            
            message(error)
            NA
            
          },
          warning = function(warning){
            
            message(warning)
            NA
            
          })
        
      }
      
    })
    
    return(df)
    
  }
