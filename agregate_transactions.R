library(ggplot2)
library(tidyr)
library(dplyr)
library(lubridate)
library(xlsx)
library(reshape2)

#unique(transaction$k_symbol)


#transaction %>% dplyr::filter(k_symbol=u)

#x <- reshape2::dcast(transaction, account_id ~ k_symbol)

#select(transaction, account_id, date, k_symbol , amount ) %>%
#  reshape2::dcast(account_id + date ~ k_symbol, value.var = "amount")

transaction %>% 
  select(account_id, k_symbol , amount ) %>%
    group_by(account_id, k_symbol)