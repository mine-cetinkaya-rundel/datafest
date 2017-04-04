# Packages ----------------------------------------------------------
library(googlesheets)
library(readr)
library(dplyr)
library(tidyr)
library(stringr)

# Inputs ------------------------------------------------------------
host <- "[HOST]"
year <- "[YEAR]"

# Get judges data ---------------------------------------------------

judges_name <- paste0("DataFest ", year, " @ ", host, " - Judge Info (Responses)")

judges <- gs_title(judges_name) %>%
  gs_read()

# Rename columns ----------------------------------------------------

names(judges) <- names(judges) %>%  
  str_replace("Email address", "email") %>%
  str_replace("Your affiliation: .{1,}", "affiliation") %>%
  str_replace("Your title:", "title") %>%
  str_replace("Do you have a preference .{1,}", "preference") %>%
  str_replace("Check if you agree", "photo") %>%
  str_replace("\\:", "") %>%
  str_replace_all("-", "") %>%
  str_replace_all(" ", "_") %>%
  tolower()

# Assign role -------------------------------------------------------

judges <- judges %>%
  mutate(role = "Judge")

# Write judges data -------------------------------------------------

write_csv(judges, path = "data/judges.csv")

# Save judges emails for easy emailing ------------------------------

cat(judges$email, sep = ", ", 
    file = "email-lists/judges-emails.txt")

