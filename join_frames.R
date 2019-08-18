library(ggplot2)
library(tidyr)
library(dplyr)
library(lubridate)
library(xlsx)

#Base frame accounts 
master_frame <- account %>%
  #Join accounts
  left_join(loan, by = 'account_id') %>%
  #Join Demographie
  left_join(demographic, by = 'district_id') %>%
  #Join disposition
  left_join(
    dplyr::filter(disposition, type == 'OWNER' ) %>% 
      left_join(disposition %>% group_by(account_id) %>% summarise(dependants = n()-1), by = 'account_id')
    , by = 'account_id') %>%
  #Join client
  left_join(client,by = 'client_id') %>%
  #Join card
  left_join(card, by = 'disp_id')

  
