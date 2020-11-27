# Load Packages
library(here)
library(tidyverse)

# Read the files

# Identify all the data available
year <- list.files(here("data", "raw"))

# Print the years available
message("The data available for the following years:")
lapply(year, paste)

## Loop through all the years
for (y in year) {
    # Sections of data available 
    section <- list.files(here("data", "raw", y))
    # Print the sections
    message("In ", y, ", the data available for the following sections:")
    lapply(section, print)
    for (s in section) {
        if (s == "budgetary_scheme_expenditure") {
            message("- Processing the '", s, "' files.")
            grant <- grep(list.files(here("data", "raw", y, s)), pattern = ".csv", invert = TRUE, value = TRUE)
            # Read the main file
            grant_master <- read_csv(here("data", "raw", y, s, "main_file.csv"), col_types = cols(.default = "c"))
            # Setup empty tibble to save schemes data
            message(">> Creating the master files.")
            scheme_master <- tribble()
            # Loop through different grants for schemes data
            for (g in grant) {
                file <- read_csv(here("data", "raw", y, s, g, paste0(g, "_prep.csv")), col_types = cols(.default = "c"))
                scheme_master <- bind_rows(scheme_master, file)
            }
            # Create directory to save processed files
            dir.create(here("data", "processed", y), showWarnings = FALSE)
            dir.create(here("data", "processed", y, s), showWarnings = FALSE)
            # Save processed files
            message(">> Storing the processed files.")
            write_csv(grant_master, here("data", "processed", y, s, "grant_master.csv"))
            write_csv(scheme_master, here("data", "processed", y, s, "scheme_master.csv"))
        } else if (s == "ddo_wise_expenditure") {
            message("- Processing the '", s, "' files.")
            ddo <- grep(list.files(here("data", "raw", y, s)), pattern = ".csv", invert = TRUE, value = TRUE)
            # Read the main file
            ddo_master <- suppressMessages(read_csv(here("data", "raw", y, s, "main_file.csv"), col_types = cols(.default = "c")))
            # Setup empty tibbles to save data
            message(">> Creating the master files.")
            grant_master <- tribble()
            scheme_master <- tribble()
            treasury_master <- tribble()
            voucher_master <- tribble()
            # Loop through different grants for schemes data
            for (d in ddo) {
                file <- read_csv(here("data", "raw", y, s, d, paste0(d, "_prep.csv")), col_types = cols(.default = "c"))
                grant_master <- bind_rows(grant_master, file)
                scheme <- grep(list.files(here("data", "raw", y, s, d)), pattern = ".csv", invert = TRUE, value = TRUE)
                for (c in scheme) {
                    file <- read_csv(here("data", "raw", y, s, d, c, paste0(c, "_prep.csv")), col_types = cols(.default = "c"))
                    scheme_master <- bind_rows(scheme_master, file)
                    treasury <- grep(list.files(here("data", "raw", y, s, d, c)), pattern = ".csv", invert = TRUE, value = TRUE)
                    for (t in treasury) {
                        file <- read_csv(here("data", "raw", y, s, d, c, t, paste0(t, "_prep.csv")), col_types = cols(.default = "c"))
                        treasury_master <- bind_rows(treasury_master, file)
                        voucher <- grep(list.files(here("data", "raw", y, s, d, c, t)), pattern = ".csv", invert = TRUE, value = TRUE)
                        for (v in voucher) {
                            file <- read_csv(here("data", "raw", y, s, d, c, t, v, paste0(v, "_prep.csv")), col_types = cols(.default = "c"))
                            voucher_master <- bind_rows(voucher_master, file)
                        }
                    }
                }
            }
            # Create directory to save processed files
            dir.create(here("data", "processed", y), showWarnings = FALSE)
            dir.create(here("data", "processed", y, s), showWarnings = FALSE)
            # Save processed files
            message(">> Storing the processed files.")
            write_csv(ddo_master, here("data", "processed", y, s, "ddo_master.csv"))
            write_csv(grant_master, here("data", "processed", y, s, "grant_master.csv"))
            write_csv(scheme_master, here("data", "processed", y, s, "scheme_master.csv"))
            write_csv(treasury_master, here("data", "processed", y, s, "treasury_master.csv"))
            write_csv(voucher_master, here("data", "processed", y, s, "voucher_master.csv"))
        } else if (s == "department_wise_expenditure") {
            message("- Processing the '", s, "' files.")
            grant <- grep(list.files(here("data", "raw", y, s)), pattern = ".csv", invert = TRUE, value = TRUE)
            # Read the main file
            grant_master <- suppressMessages(read_csv(here("data", "raw", y, s, "main_file.csv"), col_types = cols(.default = "c")))
            # Setup empty tibbles to save data
            message(">> Creating the master files.")
            scheme_master <- tribble()
            object_master <- tribble()
            # Loop through different grants for schemes data
            for (g in grant) {
                file <- read_csv(here("data", "raw", y, s, g, paste0(g, "_prep.csv")), col_types = cols(.default = "c"))
                scheme_master <- bind_rows(scheme_master, file)
                object <- grep(list.files(here("data", "raw", y, s, g)), pattern = ".csv", invert = TRUE, value = TRUE)
                for (o in object) {
                    file <- read_csv(here("data", "raw", y, s, g, o, paste0(o, "_prep.csv")), col_types = cols(.default = "c"))
                    object_master <- bind_rows(object_master, file)
                }
            }
            # Create directory to save processed files
            dir.create(here("data", "processed", y), showWarnings = FALSE)
            dir.create(here("data", "processed", y, s), showWarnings = FALSE)
            # Save processed files
            message(">> Storing the processed files.")
            write_csv(grant_master, here("data", "processed", y, s, "grant_master.csv"))
            write_csv(scheme_master, here("data", "processed", y, s, "scheme_master.csv"))
            write_csv(object_master, here("data", "processed", y, s, "object_master.csv"))
        } else if (s == "division_wise_expenditure") {
            message("- Processing the '", s, "' files.")
            # Read the main file
            division_master <- suppressMessages(read_csv(here("data", "raw", y, s, "main_file.csv"), col_types = cols(.default = "c")))
            # Create directory to save processed files
            dir.create(here("data", "processed", y), showWarnings = FALSE)
            dir.create(here("data", "processed", y, s), showWarnings = FALSE)
            # Save processed files
            message(">> Storing the processed files.")
            write_csv(division_master, here("data", "processed", y, s, "division_master.csv"))
        } else if (s == "grant_major_head_wise_expenditure") {
            message("- Processing the '", s, "' files.")
            grant <- grep(list.files(here("data", "raw", y, s)), pattern = ".csv", invert = TRUE, value = TRUE)
            # Read the main file
            grant_master <- suppressMessages(read_csv(here("data", "raw", y, s, "main_file.csv"), col_types = cols(.default = "c")))
            # Setup empty tibble to save schemes data
            message(">> Creating the master files.")
            major_head_master <- tribble()
            # Loop through different grants for schemes data
            for (g in grant) {
                file <- read_csv(here("data", "raw", y, s, g, paste0(g, "_prep.csv")), col_types = cols(.default = "c"))
                major_head_master <- bind_rows(major_head_master, file)
            }
            # Create directory to save processed files
            dir.create(here("data", "processed", y), showWarnings = FALSE)
            dir.create(here("data", "processed", y, s), showWarnings = FALSE)
            # Save processed files
            message(">> Storing the processed files.")
            write_csv(grant_master, here("data", "processed", y, s, "grant_master.csv"))
            write_csv(major_head_master, here("data", "processed", y, s, "major_head_master.csv"))
        } else if (s == "grant_wise_capital_revenue_expenditure") {
            message("- Processing the '", s, "' files.")
            # Read the main file
            grant_master <- suppressMessages(read_csv(here("data", "raw", y, s, "main_file.csv"), col_types = cols(.default = "c")))
            # Create directory to save processed files
            dir.create(here("data", "processed", y), showWarnings = FALSE)
            dir.create(here("data", "processed", y, s), showWarnings = FALSE)
            # Save processed files
            message(">> Storing the processed files.")
            write_csv(grant_master, here("data", "processed", y, s, "grant_master.csv"))
        } else if (s == "pfms_expenditure_detail") {
            message("- Processing the '", s, "' files.")
            scheme <- grep(list.files(here("data", "raw", y, s)), pattern = ".csv", invert = TRUE, value = TRUE)
            # Read the main file
            central_scheme_master <- suppressMessages(read_csv(here("data", "raw", y, s, "main_file.csv"), col_types = cols(.default = "c")))
            # Setup empty tibble to save schemes data
            message(">> Creating the master files.")
            scheme_master <- tribble()
            # Loop through different grants for schemes data
            for (c in scheme) {
                file <- read_csv(here("data", "raw", y, s, c, paste0(c, "_prep.csv")), col_types = cols(.default = "c"))
                scheme_master <- bind_rows(scheme_master, file)
            }
            # Create directory to save processed files
            dir.create(here("data", "processed", y), showWarnings = FALSE)
            dir.create(here("data", "processed", y, s), showWarnings = FALSE)
            # Save processed files
            message(">> Storing the processed files.")
            write_csv(central_scheme_master, here("data", "processed", y, s, "central_scheme_master.csv"))
            write_csv(scheme_master, here("data", "processed", y, s, "scheme_master.csv"))
        } else print("Skip")
    }
}

# Clear all the objects
rm(list = ls())
