# Packages ----------------------------------------------------------
library(googlesheets)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)

# Inputs ------------------------------------------------------------
host <- "[HOST]"
year <- "[YEAR]"

# Get participant data ----------------------------------------------

part_wide_name <- paste0("DataFest ", year, " @ ", host, " - Team Sign up (Responses)")

part_wide <- gs_title(part_wide_name) %>%
  gs_read()

# Rename columns ----------------------------------------------------

names(part_wide) <- names(part_wide) %>%
  str_replace(" of team member", "") %>%
  str_replace(" in DataFest before", "") %>%
  str_replace(" Check all that apply.", "") %>%
  str_replace("Email address", "email") %>%
  str_replace("Dietary restrictions", "diet") %>%
  str_replace("Check if you agree", "photo") %>%
  str_replace("\\:", "") %>%
  str_replace("-", "") %>%
  str_replace_all(" ", "_") %>%
  tolower()

# Wide to long ------------------------------------------------------

participants <- part_wide %>%
  select(-photo) %>%
  gather(column, entry, last_name_1:diet_5, -timestamp, -team_name) %>%
  mutate(person_in_team = str_match(column, "[0-9]")) %>%
  mutate(column = str_replace(column, "_[0-9]", "")) %>%
  spread(column, entry) %>%    # orders columns in alphabetical order (?)
  filter(!is.na(last_name)) %>%
  arrange(team_name, last_name, first_name) %>%
  select(-person_in_team) %>%
  select(timestamp, team_name, first_name, last_name, email, school, 
         class_year, major, participation, diet, tshirt_size)    # reorder columns

# Check if there are duplicate emails -------------------------------

if(any(duplicated(participants$email)) == TRUE){
  stop("There are duplicates!")
  participants$email[duplicated(participants$email)]
}

# Corrections: Based on emails received from students ---------------

# Gordon Hawkins is sophomore, participated before
participants <- participants %>%
  mutate(class_year = ifelse(email == "gordon.hawkins@hu.edu", "Sophomore", class_year)) %>%
  mutate(participation = ifelse(email == "gordon.hawkins@hu.edu", "Yes", participation))

# Assign role ------------------------------------------------------

participants <- participants %>%
  mutate(role = "Participant")

# Write participant data -------------------------------------------

participants <- participants %>%
  arrange(last_name)

write_csv(participants, path = "data/participants.csv")

# Save participant emails for easy emailing -------------------------

cat(participants$email, sep = ", ", 
    file = "email-lists/participants-emails.txt")
