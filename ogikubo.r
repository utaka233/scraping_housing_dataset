library(rvest)
library(stringr)
library(readr)
library(dplyr)

urls <- c()
for(i in 1:67){
  urls[i] <- paste0("https://suumo.jp/jj/chintai/ichiran/FR301FC005/?shkr1=03&cb=0.0&shkr3=03&shkr2=03&rn=0015&smk=&mt=9999999&ar=030&bs=040&shkr4=03&ct=9999999&ra=013&ek=001506640&md=01&cn=9999999&tc=0401106&mb=0&fw2=&et=9999999&pn=", i)
}

name <- c()
value <- c()
area <- c()
age <- c()
distance <- c()

for(url in urls){
  tmp_page_html <- read_html(url)
  tmp_name <- html_nodes(tmp_page_html, "a.js-cassetLinkHref") %>% html_text()
  tmp_value <- html_nodes(tmp_page_html, "div.detailbox-property-point") %>% 
    html_text() %>%
    parse_number(na=c('', 'NA'), locale=default_locale())
  tmp_area <- html_nodes(tmp_page_html, "td.detailbox-property-col.detailbox-property--col3") %>%
    html_text() %>%
    str_subset("m2") %>%
    parse_number(na=c('', 'NA'), locale=default_locale())
  tmp_age <- html_nodes(tmp_page_html, "td.detailbox-property-col.detailbox-property--col3") %>%
    html_text() %>%
    str_subset("築") %>%
    str_replace_all(pattern = "新", replacement = "0") %>%
    parse_number(na=c('', 'NA'), locale=default_locale())
  tmp_distance <- html_nodes(tmp_page_html, "div.detailnote-box") %>% 
    html_nodes(xpath = '//div[@style="font-weight:bold"]') %>%
    html_text() %>%
    parse_number(na=c('', 'NA'), locale=default_locale())
  
  print(paste0("step:", i, " distance:", length(tmp_distance)))
  name <- c(name, tmp_name)
  value <- c(value, tmp_value)
  area <- c(area, tmp_area)
  age <- c(age, tmp_age)
  distance <- c(distance, tmp_distance)
}

data <- tibble(name, value, area, age, distance)
