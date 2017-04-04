# Packages ----------------------------------------------------------
library(googlesheets)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)

# Inputs ------------------------------------------------------------
host <- "[HOST]"
year <- "[YEAR]"

# Get looking for teammates data ------------------------------------
looking_name <- paste0("DataFest ", year, " @ ", host, " - Team Formation Survey (Responses)")

looking <- gs_title(looking_name) %>%
  gs_read() 

# Rename columns ----------------------------------------------------

looking_col_names <- names(looking)

looking_col_names <- str_replace(looking_col_names, "Email address", "email")
looking_col_names <- str_replace(looking_col_names, "How much time do you want to spend on DataFest over the weekend\\?", "participation_level")
looking_col_names <- str_replace(looking_col_names, " Check all that apply.", "")
looking_col_names <- str_replace(looking_col_names, "Have you participated in DataFest before\\?", "participation_before")
looking_col_names <- str_replace(looking_col_names, "\\:", "")
looking_col_names <- str_replace_all(looking_col_names, " ", "_")
looking_col_names <- tolower(looking_col_names)

names(looking) <- looking_col_names

# Remove any looking people who are already on participants ---------

participants <- read_csv("data/participants.csv")
looking <- anti_join(looking, participants, by = "email")

# Write looking data ------------------------------------------------

write_csv(looking, path = "data/looking.csv")

# Save looking emails for easy emailing -----------------------------

cat(looking$email, sep = ", ", 
    file = "email-lists/looking-emails.txt")

