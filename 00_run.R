# R scripts ---------------------------------------------------------
source("01_get_part_data.R")
source("02_get_looking_data.R")
source("03_get_cons_data.R")
source("04_get_judge_data.R")
source("05_combine_data.R")

# Rmd documents -----------------------------------------------------
render_markdown("06_participant_roster.Rmd")
render_markdown("07_looking_roster.Rmd")
render_markdown("08_consultant_roster.Rmd")
render_markdown("09_judge_roster.Rmd")
render_markdown("10_participant_summary.Rmd")
render_markdown("11_orders.Rmd")
render_markdown("12_info_guide.Rmd")
render_markdown("13_consulting_judging_info.Rmd")