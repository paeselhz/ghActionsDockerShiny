FROM rocker/shiny:4.0.0

RUN apt-get update \
  && apt-get install -y \
    libxml2-dev \
    libglpk-dev \
  && install2.r \
    --error \
    dplyr \
    shiny \
    purrr \
    highcharter \
    shinyWidgets \
    shinycssloaders \
    devtools \
    xml2 \
    igraph \
    readr
  
RUN R -e "devtools::install_github('wilsonfreitas/rbcb')"

COPY . /srv/shiny-server

RUN chmod -R 777 /srv/shiny-server