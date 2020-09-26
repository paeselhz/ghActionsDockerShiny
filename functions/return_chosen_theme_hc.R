
return_chosen_theme_hc <-
  function(hc_theme_type) {
    
    if(hc_theme_type == "538") {
      
      return(highcharter::hc_theme_538())
      
    }
    
    if(hc_theme_type == "Elementary") {
      
      return(highcharter::hc_theme_elementary())
      
    }
    
    if(hc_theme_type == "GGPlot2") {
      
      return(highcharter::hc_theme_ggplot2())
      
    }
    
    if(hc_theme_type == "Google") {
      
      return(highcharter::hc_theme_google())
      
    }
    
    if(hc_theme_type == "Null") {
      
      return(highcharter::hc_theme_null())
      
    }
    
  }
