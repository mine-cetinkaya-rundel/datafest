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

judges_col_names <- names(judges)

judges_col_names <- str_replace(judges_col_names, "Email address", "email")
judges_col_names <- str_replace(judges_col_names, "Your affiliation: .{1,}", "affiliation")
judges_col_names <- str_replace(judges_col_names, "Your title:", "title")
judges_col_names <- str_replace(judges_col_names, "Do you have a preference .{1,}", "preference")
judges_col_names <- str_replace(judges_col_names, "Check if you agree", "photo")
judges_col_names <- str_replace(judges_col_names, "\\:", "")
judges_col_names <- str_replace_all(judges_col_names, "-", "")
judges_col_names <- str_replace_all(judges_col_names, " ", "_")
judges_col_names <- tolower(judges_col_names)

names(judges) <- judges_col_names

# Assign role -------------------------------------------------------

judges <- judges %>%
  mutate(role = "Judge")

# Write judges data -------------------------------------------------

write_csv(judges, path = "data/judges.csv")

# Save judges emails for easy emailing ------------------------------

cat(judges$email, sep = ", ", 
    file = "email-lists/judges-emails.txt")

