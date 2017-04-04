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
consultants_name <- paste0("DataFest ", year, " @ ", host, " - Consultant Sign up (Responses)")

consultants <- gs_title(consultants_name) %>%
  gs_read() 

# Rename columns ----------------------------------------------------

consultants_col_names <- names(consultants)

consultants_col_names <- str_replace(consultants_col_names, "Email address", "email")
consultants_col_names <- str_replace(consultants_col_names, "Your affiliation: .{1,}", "affiliation")
consultants_col_names <- str_replace(consultants_col_names, "Your title:", "title")
consultants_col_names <- str_replace(consultants_col_names, "Which .{1,}", "shift_preference")
consultants_col_names <- str_replace(consultants_col_names, "How many .{1,}", "hours_preference")
consultants_col_names <- str_replace(consultants_col_names, "Check if you agree", "photo")
consultants_col_names <- str_replace(consultants_col_names, "\\:", "")
consultants_col_names <- str_replace(consultants_col_names, "-", "")
consultants_col_names <- str_replace_all(consultants_col_names, " ", "_")
consultants_col_names <- tolower(consultants_col_names)

names(consultants) <- consultants_col_names

# Assign role -------------------------------------------------------

consultants <- consultants %>%
  mutate(role = "Consultant")

# Write consultants data --------------------------------------------

write_csv(consultants, path = "data/consultants.csv")

# Save consultants emails for easy emailing -------------------------

cat(consultants$email, sep = ", ", 
    file = "email-lists/consultants-emails.txt")
