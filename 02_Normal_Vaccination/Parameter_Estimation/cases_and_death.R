library(tidyverse)

# Read in file from cases and deaths from NYT
df <- read_csv("cases.csv")

# Index rows by number
df$index <- rownames(df)

# Get start date and 120 days later
start <- df[df$date == '2020-12-14',]$index
end <- as.numeric(start) + 120
start <- as.numeric(start)
df$index <- as.numeric(df$index)
df <- df[df$index >= start & df$index <= end,]

# Write cleaned data
df <- df %>% select(cases, deaths)
write.csv(df, file = 'cases_clean.csv',row.names=FALSE)
