# Packages ----------------------------------------------------------
library(googlesheets)
library(tidyverse)
library(stringr)

# Inputs ------------------------------------------------------------
host <- "[HOST]"
year <- "[YEAR]"

# Get looking for teammates data ------------------------------------
looking_name <- paste0("DataFest ", year, " @ ", host, " - Team Formation Survey (Responses)")

looking <- gs_title(looking_name) %>%
  gs_read() 

# Rename columns ----------------------------------------------------

names(looking) <- names(looking)
  str_replace("Email address", "email")
  str_replace("How much time do you want to spend on DataFest over the weekend\\?", "participation_level")
  str_replace(" Check all that apply.", "")
  str_replace("Have you participated in DataFest before\\?", "participation_before")
  str_replace("\\:", "")
  str_replace_all(" ", "_")
  tolower()

# Remove any looking people who are already on participants ---------

participants <- read_csv("data/participants.csv")
looking <- anti_join(looking, participants, by = "email")

# Write looking data ------------------------------------------------

write_csv(looking, path = "data/looking.csv")

# Save looking emails for easy emailing -----------------------------

cat(looking$email, sep = ", ", 
    file = "email-lists/looking-emails.txt")

