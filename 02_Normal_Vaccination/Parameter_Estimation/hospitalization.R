library(tidyverse)

df <- read_csv("current-covid-patients-hospital.csv")

df <- df[df$Code == "USA",]
df$num <- as.numeric(rownames(df))

df_start <- df[df$Day == "2020-12-14",]$num

df <- df[df$num >= df_start,]
df <- df[,"Daily hospital occupancy"]

write.csv(df, file = 'hospitalization_clean.csv',row.names=FALSE)
