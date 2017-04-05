# Packages ----------------------------------------------------------
library(googlesheets)
library(tidyverse)
library(stringr)

# Inputs ------------------------------------------------------------
host <- "[HOST]"
year <- "[YEAR]"

# Get looking for teammates data ------------------------------------
consultants_name <- paste0("DataFest ", year, " @ ", host, " - Consultant Sign up (Responses)")

consultants <- gs_title(consultants_name) %>%
  gs_read() 

# Rename columns ----------------------------------------------------

names(consultants) <- names(consultants) %>%
  str_replace("Email address", "email")
  str_replace("Your affiliation: .{1,}", "affiliation")
  str_replace("Your title:", "title")
  str_replace("Which .{1,}", "shift_preference")
  str_replace("How many .{1,}", "hours_preference")
  str_replace("Check if you agree", "photo")
  str_replace("\\:", "")
  str_replace("-", "")
  str_replace_all(" ", "_")
  tolower()

# Assign role -------------------------------------------------------

consultants <- consultants %>%
  mutate(role = "Consultant")

# Write consultants data --------------------------------------------

write_csv(consultants, path = "data/consultants.csv")

# Save consultants emails for easy emailing -------------------------

cat(consultants$email, sep = ", ", 
    file = "email-lists/consultants-emails.txt")
