# Packages ----------------------------------------------------------
library(googlesheets)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)

# Inputs ------------------------------------------------------------

participants <- read_csv("data/participants.csv")
judges <- read_csv("data/judges.csv")
consultants <- read_csv("consultants.csv")

# Combine data ------------------------------------------------------

all <- bind_rows(participants, judges, consultants)

# Write judges data -------------------------------------------------

write_csv(all, path = "data/all.csv")
