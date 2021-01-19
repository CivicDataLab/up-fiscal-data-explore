# Create folder to process files
message("Create the working directory for processed data.")
dir.create(here("data", step1), showWarnings = FALSE)

# Identify all the data available
year <- list.files(here("data", step0))

# Print the years available
message("The data available for the following years:")
lapply(year, paste)

## Loop through all the years
for (y in year) {
    # Sections of data available 
    section <- list.files(here("data", step0, y))
    # Print the sections
    message("In ", y, ", the data available for the following sections:")
    lapply(section, print)
    # Create directory to save processed files
    dir.create(here("data", step1, y), showWarnings = FALSE)
    for (s in section) {
        if (s == section1) {
            message("- Processing the '", s, "' files.")
            # Read the main file
            message(">> Creating the master files.")
            grant_master <- read_csv(here("data", step0, y, s, "main_file.csv"), col_types = cols(.default = "c"))
            # Setup empty tibble to save schemes data
            scheme_master <- tribble()
            # Loop through different grants for schemes data
            grant <- grep(list.files(here("data", step0, y, s)), pattern = "\\..{3}$", invert = TRUE, value = TRUE)
            for (g in grant) {
                file <- read_csv(here("data", step0, y, s, g, paste0(g, "_prep.csv")), col_types = cols(.default = "c"))
                scheme_master <- bind_rows(scheme_master, file)
            }
            # Create directory to save processed files
            dir.create(here("data", step1, y, s), showWarnings = FALSE)
            # Save processed files
            message(">> Storing the processed files.")
            write_csv(grant_master, here("data", step1, y, s, "grant_master.csv"))
            write_csv(scheme_master, here("data", step1, y, s, "scheme_master.csv"))
        } else if (s == section2) {
            message("- Processing the '", s, "' files.")
            # Read the main file
            message(">> Creating the master files.")
            grant_master <- suppressMessages(read_csv(here("data", step0, y, s, "main_file.csv"), col_types = cols(.default = "c")))
            # Setup empty tibbles to save data
            scheme_master <- tribble()
            object_master <- tribble()
            # Loop through different grants for schemes data
            grant <- grep(list.files(here("data", step0, y, s)), pattern = "\\..{3}$", invert = TRUE, value = TRUE)
            for (g in grant) {
                file <- read_csv(here("data", step0, y, s, g, paste0(g, "_prep.csv")), col_types = cols(.default = "c"))
                scheme_master <- bind_rows(scheme_master, file)
                # Loop through different grants for object data
                object <- grep(list.files(here("data", step0, y, s, g)), pattern = "\\..{3}$", invert = TRUE, value = TRUE)
                for (o in object) {
                    file <- read_csv(here("data", step0, y, s, g, o, paste0(o, "_prep.csv")), col_types = cols(.default = "c"))
                    object_master <- bind_rows(object_master, file)
                }
            }
            # Create directory to save processed files
            dir.create(here("data", step1, y, s), showWarnings = FALSE)
            # Save processed files
            message(">> Storing the processed files.")
            write_csv(grant_master, here("data", step1, y, s, "grant_master.csv"))
            write_csv(scheme_master, here("data", step1, y, s, "scheme_master.csv"))
            write_csv(object_master, here("data", step1, y, s, "object_master.csv"))
        } else if (s == section3) {
            message("- Processing the '", s, "' files.")
            # Read the main file
            message(">> Creating the master files.")
            division_master <- suppressMessages(read_csv(here("data", step0, y, s, "main_file.csv"), col_types = cols(.default = "c")))
            # Create directory to save processed files
            dir.create(here("data", step1, y, s), showWarnings = FALSE)
            # Save processed files
            message(">> Storing the processed files.")
            write_csv(division_master, here("data", step1, y, s, "division_master.csv"))
        } else if (s == section4) {
            message("- Processing the '", s, "' files.")
            # Read the main file
            message(">> Creating the master files.")
            grant_master <- suppressMessages(read_csv(here("data", step0, y, s, "main_file.csv"), col_types = cols(.default = "c")))
            # Setup empty tibble to save schemes data
            major_head_master <- tribble()
            # Loop through different grants for schemes data
            grant <- grep(list.files(here("data", step0, y, s)), pattern = "\\..{3}$", invert = TRUE, value = TRUE)
            for (g in grant) {
                file <- read_csv(here("data", step0, y, s, g, paste0(g, "_prep.csv")), col_types = cols(.default = "c"))
                major_head_master <- bind_rows(major_head_master, file)
            }
            # Create directory to save processed files
            dir.create(here("data", step1, y, s), showWarnings = FALSE)
            # Save processed files
            message(">> Storing the processed files.")
            write_csv(grant_master, here("data", step1, y, s, "grant_master.csv"))
            write_csv(major_head_master, here("data", step1, y, s, "major_head_master.csv"))
        } else if (s == section5) {
            message("- Processing the '", s, "' files.")
            # Read the main file
            message(">> Creating the master files.")
            grant_master <- suppressMessages(read_csv(here("data", step0, y, s, "main_file.csv"), col_types = cols(.default = "c")))
            # Create directory to save processed files
            dir.create(here("data", step1, y, s), showWarnings = FALSE)
            # Save processed files
            message(">> Storing the processed files.")
            write_csv(grant_master, here("data", step1, y, s, "grant_master.csv"))
        } else if (s == section6) {
            message("- Processing the '", s, "' files.")
            # Read the main file
            message(">> Creating the master files.")
            grant_master <- suppressMessages(read_csv(here("data", step0, y, s, "main_file.csv"), col_types = cols(.default = "c")))
            # Create directory to save processed files
            dir.create(here("data", step1, y, s), showWarnings = FALSE)
            # Setup empty tibbles to save data
            scheme_master <- tribble()
            treasury_master <- tribble()
            voucher_master <- tribble()
            # Loop through different grants for schemes data
            grant <- grep(list.files(here("data", step0, y, s)), pattern = "\\..{3}$", invert = TRUE, value = TRUE)
            for (g in grant) {
                file <- read_csv(here("data", step0, y, s, g, paste0(g, "_prep.csv")), col_types = cols(.default = "c"))
                scheme_master <- bind_rows(scheme_master, file)
                scheme <- grep(list.files(here("data", step0, y, s, g)), pattern = "\\..{3}$", invert = TRUE, value = TRUE)
                # for (c in scheme) {
                #     if_else(file_exists(here("data", step0, y, s, g, c, paste0(c, "_prep.csv"))),
                #             file <- read_csv(here("data", step0, y, s, g, c, paste0(c, "_prep.csv")), col_types = cols(.default = "c")),
                #             file <- file[FALSE, ]
                #     )
                #     treasury_master <- bind_rows(treasury_master, file)
                #     treasury <- grep(list.files(here("data", step0, y, s, g, c)), pattern = "\\..{3}$", invert = TRUE, value = TRUE)
                    # for (t in treasury) {
                    #     if_else(file_exists(here("data", step0, y, s, g, c, t, paste0(t, "_prep.csv"))), 
                    #             file <- read_csv(here("data", step0, y, s, g, c, t, paste0(t, "_prep.csv")), col_types = cols(.default = "c")),
                    #             file <- tribble())
                    #     voucher_master <- bind_rows(voucher_master, file)
                    # }
                # }
            }
            # Create directory to save processed files
            dir.create(here("data", step1, y, s), showWarnings = FALSE)
            # Save processed files
            message(">> Storing the processed files.")
            write_csv(grant_master, here("data", step1, y, s, "grant_master.csv"))
            write_csv(scheme_master, here("data", step1, y, s, "scheme_master.csv"))
            # ----- write_csv(treasury_master, here("data", step1, y, s, "treasury_master.csv"))
            # ----- write_csv(voucher_master, here("data", step1, y, s, "voucher_master.csv"))
        } else if (s == section7) {
            message("- Processing the '", s, "' files.")
            # Read the main file
            message(">> Creating the master files.")
            central_scheme_master <- suppressMessages(read_csv(here("data", step0, y, s, "main_file.csv"), col_types = cols(.default = "c")))
            # Setup empty tibble to save schemes data
            scheme_master <- tribble()
            # Loop through different grants for schemes data
            scheme <- grep(list.files(here("data", step0, y, s)), pattern = "\\..{3}$", invert = TRUE, value = TRUE)
            for (c in scheme) {
                file <- read_csv(here("data", step0, y, s, c, paste0(c, "_prep.csv")), col_types = cols(.default = "c"))
                scheme_master <- bind_rows(scheme_master, file)
            }
            # Create directory to save processed files
            dir.create(here("data", step1, y, s), showWarnings = FALSE)
            # Save processed files
            message(">> Storing the processed files.")
            write_csv(central_scheme_master, here("data", step1, y, s, "central_scheme_master.csv"))
            write_csv(scheme_master, here("data", step1, y, s, "scheme_master.csv"))
        } else print("Skip")
    }
}
