# Load Packages
library(here)
library(tidyverse)
library(janitor)

# Read the files

# Identify all the data available
year <- list.files(here("data", "processed"))

# Print the years available
message("The processed data available for the following years:")
lapply(year, paste)

## Loop through all the years
for (y in year) {
    # Sections of data available 
    section <- list.files(here("data", "processed", y))
    # Print the sections
    message("In ", y, ", the data available for the following sections:")
    lapply(section, print)
    for (s in section) {
        if (s == "budgetary_scheme_expenditure") {
            message("- Cleaning the '", s, "' files.")
            # Read the Grant Master File
            grant_master <- read_csv(here("data", "processed", y, s, "grant_master.csv"), col_types = cols(.default = "c"))
            # Clean Columns Names
            grant_master <- grant_master %>% clean_names()
            # Read the Schemes Master File
            scheme_master <- read_csv(here("data", "processed", y, s, "scheme_master.csv"), col_types = cols(.default = "c"))
            # Clean Columns Names
            scheme_master <- scheme_master %>% clean_names()
            # Create directory to save processed files
            dir.create(here("data", "cleaned", y), showWarnings = FALSE)
            dir.create(here("data", "cleaned", y, s), showWarnings = FALSE)
            # Store Cleaned Files
            write_csv(grant_master, here("data", "cleaned", y, s, "grant_master.csv"))
            write_csv(scheme_master, here("data", "cleaned", y, s, "scheme_master.csv"))
        } else if (s == "department_wise_expenditure") {
            message("- Cleaning the '", s, "' files.")
            # Read the Grant Master File
            grant_master <- read_csv(here("data", "processed", y, s, "grant_master.csv"), col_types = cols(.default = "c"))
            scheme_master <- read_csv(here("data", "processed", y, s, "scheme_master.csv"), col_types = cols(.default = "c"))
            object_master <- read_csv(here("data", "processed", y, s, "object_master.csv"), col_types = cols(.default = "c"))
            # Clean the datasets
            grant_master <- grant_master %>% 
                clean_names() %>%                                       # Clean columns names
                filter(!is.na(grant_no))                                # Remove Sum rows (NA values)
            scheme_master <- scheme_master %>%
                clean_names() %>%                                       # Clean columns names
                filter(!is.na(grant)) %>%                               # Remove Sum rows (NA values)
                mutate(grant = na_if(grant, "----")) %>%                # Clean Grant Number Column
                fill(grant)                                             # Impute empty Grant values
            object_master <- object_master %>%
                clean_names() %>%                                       # Clean columns names
                filter(!is.na(object))                                  # Remove Sum rows (NA values)
            # Create directory to save processed files
            dir.create(here("data", "cleaned", y), showWarnings = FALSE)
            dir.create(here("data", "cleaned", y, s), showWarnings = FALSE)
            # Store Cleaned Files
            write_csv(grant_master, here("data", "cleaned", y, s, "grant_master.csv"))
            write_csv(scheme_master, here("data", "cleaned", y, s, "scheme_master.csv"))
            write_csv(object_master, here("data", "cleaned", y, s, "object_master.csv"))
        } else if (s == "division_wise_expenditure") {
            message("- Cleaning the '", s, "' files.")
            # Read the Grant Master File
            division_master <- read_csv(here("data", "processed", y, s, "division_master.csv"), col_types = cols(.default = "c"))
            # Clean the datasets
            division_master <- division_master %>% 
                clean_names() %>%                                       # Clean columns names
                fill(division) %>%                                      # Impute empty Grant values
                filter(division != "TOTAL OF DIVISION:")                # Remove Sum rows
            # Create directory to save processed files
            dir.create(here("data", "cleaned", y), showWarnings = FALSE)
            dir.create(here("data", "cleaned", y, s), showWarnings = FALSE)
            # Store Cleaned Files
            write_csv(division_master, here("data", "cleaned", y, s, "division_master.csv"))
        } else if (s == "grant_major_head_wise_expenditure") {
            message("- Cleaning the '", s, "' files.")
            # Read the Grant Master File
            grant_master <- read_csv(here("data", "processed", y, s, "grant_master.csv"), col_types = cols(.default = "c"))
            major_head_master <- read_csv(here("data", "processed", y, s, "major_head_master.csv"), col_types = cols(.default = "c"))
        } else print("Skip")
    }
}

# Corrections
# 1. Budgetary Schemes - Fiscal Year - main_file.csv
# 2. Department Wise - Fiscal Year - main_file.csv
# 3. Department Wise - Object - Object Code
# 4. Department Wise - Object - Hierarchy
# 4. Department Wise - Object - Hierarchy
