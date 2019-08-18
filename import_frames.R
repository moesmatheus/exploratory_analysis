library(ggplot2)
library(tidyr)
library(dplyr)
library(lubridate)
library(xlsx)

### Account frame
#Load csv
account <- read.csv2("account.asc",dec = '.',stringsAsFactors = FALSE)  
#Get date to columns
account <- mutate(account,date = lubridate::make_date(
                  year = paste("19",substring(date,1,2),sep = ""),
                  month = substring(date,3,4),
                  day =substring(date,5,6)))



#Translate names
l1 <- list(
  "POPLATEK MESICNE"= "monthly",
  "POPLATEK TYDNE"="weekly",
  "POPLATEK PO OBRATU" ="after transaction")
account <- mutate(account, frequency = l1[frequency])
#account <- mutate(account, frequency = ifelse(is.null(frequency),'',l1[frequency]))




### Client Frame
#Load csv
client <- read.csv2("client.asc",dec = '.',stringsAsFactors = FALSE)  
#Get gender
client <- mutate(client, 
    gender_code = ifelse(as.numeric(substring(birth_number,3,4)) < 50,0,1),
    gender = ifelse(as.numeric(substring(birth_number,3,4)) < 50,'M','W')
    )
#Get birth date
client <- mutate(client, birth_date = lubridate::make_date(
    year = paste("19",substring(birth_number,1,2),sep = ""),
    month = as.numeric(substring(birth_number,3,4))-50*gender_code,
    day =substring(birth_number,5,6)  
))




### Disposition Frame - owner and user
disposition <- read.csv2("disp.asc",dec = '.',stringsAsFactors = FALSE)



### Permanent order frame
order <- read.csv2("order.asc",dec = '.',stringsAsFactors = FALSE)  
#Translate names
l2 <- list(
  "POJISTNE"='insurrance',
  "SIPO"='household',
  "LEASING"='leasing',
  "UVER"='loan'
)
order <- mutate(order, k_symbol = l2[k_symbol])
#order <- mutate(order, k_symbol = ifelse(is.null(k_symbol),'',l2[k_symbol]))



### Transaction frame
transaction <- read.csv2("trans.asc",dec = '.',stringsAsFactors = FALSE)
#Get date
transaction <- mutate(transaction,date = lubridate::make_date(
  year = paste("19",substring(date,1,2),sep = ""),
  month = substring(date,3,4),
  day =substring(date,5,6)))
#Translate type
l3 <- list(
  "PRIJEM"='credit',
  "VYDAJ"='debit'
)
transaction <- mutate(transaction, type = l3[type])
#transaction <- mutate(transaction, type = ifelse(is.null(type),'',l3[type]))
#Translate operation
l4 <- list(
  "VYBER KARTOU"='credit card withdrawal',
  "VKLAD" ='credit in cash',
  "PREVOD Z UCTU"='collection from another bank',
  "VYBER"='withdrawal in cash',
  "PREVOD NA UCET"='remittance to another bank'
)
transaction <- mutate(transaction, operation = l4[operation])
#transaction <- mutate(transaction, operation = ifelse(is.null(operation),'',l4[operation]))
#Translate symbol
l5 <- list(
  "POJISTNE"='insurrance payment',
  "SLUZBY"='payment for statement',
  "UROK"= 'interest credited',
  "SANKC. UROK"='sanction interest',
  "SIPO"= 'household',
  "DUCHOD"='old age pension',
  "UVER"='loan payment'
)
transaction <- mutate(transaction, k_symbol = l5[k_symbol])
#transaction <- mutate(transaction, k_symbol = ifelse(is.null(k_symbol),'',l5[k_symbol]))




### Loan frame
loan <- read.csv2("loan.asc",dec = '.',stringsAsFactors = FALSE)
#Get date
loan <- mutate(loan,date = lubridate::make_date(
  year = paste("19",substring(date,1,2),sep = ""),
  month = substring(date,3,4),
  day =substring(date,5,6)))




### Credit card frame
card <- read.csv2("card.asc",dec = '.',stringsAsFactors = FALSE)
#Get date
card <- mutate(card,issued = lubridate::make_date(
  year = paste("19",substring(issued,1,2),sep = ""),
  month = substring(issued,3,4),
  day =substring(issued,5,6)))




### Credit card frame
demographic <- read.csv2("district.asc",dec = '.',stringsAsFactors = FALSE)
#Change col names
n <- c("district_id","district_name","region","inhabitants","n_size_1",
       "n_size_2","n_size_3","n_size_4","n_cities","ratio of urban inhabitants",
       "average salary","unemploymant rate '95","unemploymant rate '96",
       "enterpreneurs per 1000 inhabitants","commited crimes '95","commited crimes '96")
colnames(demographic) <- n

#Write new frames to xlsx
if (FALSE) {
  account %>% write.xlsx('new_xlsx/account.xlsx')
  card %>% write.xlsx('new_xlsx/card.xlsx')
  demographic %>% write.xlsx('new_xlsx/demographic.xlsx')
  disposition %>% write.xlsx('new_xlsx/disposition.xlsx')
  loan %>% write.xlsx('new_xlsx/loan.xlsx')
  order %>% write.xlsx('new_xlsx/order.xlsx')
  transaction %>% write.xlsx('new_xlsx/transaction.xlsx')
}

#Write new frames to xlsx
if (FALSE) {
  account %>% write.xlsx('new_xlsx/account.xlsx')
  card %>% write.xlsx('new_xlsx/card.xlsx')
  demographic %>% write.xlsx('new_xlsx/demographic.xlsx')
  disposition %>% write.xlsx('new_xlsx/disposition.xlsx')
  loan %>% write.xlsx('new_xlsx/loan.xlsx')
  order %>% write.xlsx('new_xlsx/order.xlsx')
  #transaction %>% write.xlsx('new_xlsx/transaction.xlsx')
}

#Write new frames to csv
if (FALSE) {
  account %>% write.csv2('new_csv/account.csv')
  card %>% write.csv2('new_csv/card.csv')
  demographic %>% write.csv2('new_csv/demographic.csv')
  disposition %>% write.csv2('new_csv/disposition.csv')
  loan %>% write.csv2('new_csv/loan.csv')
  order %>% write.csv2('new_csv/order.csv')
  transaction %>% write.csv2('new_csv/transaction.csv')
}


