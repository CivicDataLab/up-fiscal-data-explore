# Create folder to process files
message("Create the working directory for combined data.")
dir.create(here("data", step4), showWarnings = FALSE)

# Grant Major Head
grant_major_head_master <- read_csv(here("data", step3, section4, "grant_major_head_master.csv"), col_types = cols(.default = "c"))

# Grant Capital / Revenue
grant_capital_revenue_master <- read_csv(here("data", step3, section5, "grant_capital_revenue_master.csv"), col_types = cols(.default = "c"))
