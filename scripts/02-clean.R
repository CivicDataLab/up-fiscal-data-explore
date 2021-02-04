# Create folder to process files
message("Create the working directory for cleaned data.")
dir.create(here("data", step2), showWarnings = FALSE)

# Identify all the data available
year <- list.files(here("data", step1))

# Print the years available
message("The processed data available for the following years:")
lapply(year, paste)

## Loop through all the years
for (y in year) {
    # Sections of data available 
    section <- list.files(here("data", step1, y))
    # Print the sections
    message("In ", y, ", the data available for the following sections:")
    lapply(section, print)
    # Create directory to save processed files
    dir.create(here("data", step2, y), showWarnings = FALSE)
    for (s in section) {
        if (s == section1) {
            message("- Cleaning the '", s, "' files.")
            # Read the Processed Files
            grant_master <- read_csv(here("data", step1, y, s, "grant_master.csv"), col_types = cols(.default = "c"))
            scheme_master <- read_csv(here("data", step1, y, s, "scheme_master.csv"), col_types = cols(.default = "c"))
            # Clean Columns Names
            grant_master <- grant_master %>% 
                clean_names()                                           # Clean columns names
            scheme_master <- scheme_master %>% 
                clean_names()                                           # Clean columns names
            # Create directory to save processed files
            dir.create(here("data", step2, y, s), showWarnings = FALSE)
            # Store Cleaned Files
            message(">> Storing the cleaned files.")
            write_csv(grant_master, here("data", step2, y, s, "grant_master.csv"))
            write_csv(scheme_master, here("data", step2, y, s, "scheme_master.csv"))
        } else if (s == section2) {
            message("- Cleaning the '", s, "' files.")
            # Read the Grant Master File
            grant_master <- read_csv(here("data", step1, y, s, "grant_master.csv"), col_types = cols(.default = "c"))
            scheme_master <- read_csv(here("data", step1, y, s, "scheme_master.csv"), col_types = cols(.default = "c"))
            object_master <- read_csv(here("data", step1, y, s, "object_master.csv"), col_types = cols(.default = "c"))
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
            dir.create(here("data", step2, y, s), showWarnings = FALSE)
            # Store Cleaned Files
            message(">> Storing the cleaned files.")
            write_csv(grant_master, here("data", step2, y, s, "grant_master.csv"))
            write_csv(scheme_master, here("data", step2, y, s, "scheme_master.csv"))
            write_csv(object_master, here("data", step2, y, s, "object_master.csv"))
        } else if (s == section3) {
            message("- Cleaning the '", s, "' files.")
            # Read the Grant Master File
            division_master <- read_csv(here("data", step1, y, s, "division_master.csv"), col_types = cols(.default = "c"))
            # Clean the datasets
            division_master <- division_master %>% 
                clean_names() %>%                                       # Clean columns names
                fill(division) %>%                                      # Impute empty Grant values
                filter(division != "TOTAL OF DIVISION:")                # Remove Sum rows
            # Create directory to save processed files
            dir.create(here("data", step2, y, s), showWarnings = FALSE)
            # Store Cleaned Files
            message(">> Storing the cleaned files.")
            write_csv(division_master, here("data", step2, y, s, "division_master.csv"))
        } else if (s == section4) {
            message("- Cleaning the '", s, "' files.")
            # Read the Grant Master File
            grant_master <- read_csv(here("data", step1, y, s, "grant_master.csv"), col_types = cols(.default = "c"))
            major_head_master <- read_csv(here("data", step1, y, s, "major_head_master.csv"), col_types = cols(.default = "c"))
            # Clean the datasets
            grant_master <- grant_master %>% 
                clean_names()                                           # Clean columns names
            major_head_master <- major_head_master %>%
                clean_names() %>%                                       # Clean columns names
                filter(grepl("\\d{4}=", major_head))                    # Filter out total rows
            # Create directory to save processed files
            dir.create(here("data", step2, y, s), showWarnings = FALSE)
            # Store Cleaned Files
            message(">> Storing the cleaned files.")
            write_csv(grant_master, here("data", step2, y, s, "grant_master.csv"))
            write_csv(major_head_master, here("data", step2, y, s, "major_head_master.csv"))
        }  else if (s == section5) {
            message("- Cleaning the '", s, "' files.")
            # Read the Grant Master File
            grant_master <- read_csv(here("data", step1, y, s, "grant_master.csv"), col_types = cols(.default = "c"))
            # Clean the datasets
            grant_master <- grant_master %>% 
                clean_names() %>%                                       # Clean columns names
                filter(grant_no != "TOTAL") %>%                         # Filter out total rows
                select(-temp1, -temp2) 
            # Create directory to save processed files
            dir.create(here("data", step2, y, s), showWarnings = FALSE)
            # Store Cleaned Files
            message(">> Storing the cleaned files.")
            write_csv(grant_master, here("data", step2, y, s, "grant_master.csv"))
        }  else if (s == section6) {
            message("- Cleaning the '", s, "' files.")
            # Read the data files
            grant_master <- read_csv(here("data", step1, y, s, "grant_master.csv"), col_types = cols(.default = "c"))
            scheme_master <- read_csv(here("data", step1, y, s, "scheme_master.csv"), col_types = cols(.default = "c"))
            treasury_master <- read_csv(here("data", step1, y, s, "treasury_master.csv"), col_types = cols(.default = "c"))
            voucher_master <- read_csv(here("data", step1, y, s, "voucher_master.csv"), col_types = cols(.default = "c"))
            # Clean the datasets
            grant_master <- grant_master %>% 
                clean_names()                                           # Clean columns names
            scheme_master <- scheme_master %>% 
                clean_names() %>%                                       # Clean columns names
                fill(scheme_code) %>%                                   # Impute empty values
                filter(!grepl("TOTAL::", scheme_code))                  # Filter out total rows
            treasury_master <- treasury_master %>% 
                clean_names() %>%                                       # Clean columns names
                fill(treasury) %>%                                      # Impute empty values
                filter(treasury != "Total:")                            # Filter out total rows
            voucher_master <- voucher_master %>%
                clean_names()                                           # Clean columns names
            # Create directory to save processed files
            dir.create(here("data", step2, y, s), showWarnings = FALSE)
            # Store Cleaned Files
            message(">> Storing the cleaned files.")
            write_csv(grant_master, here("data", step2, y, s, "grant_master.csv"))
            write_csv(scheme_master, here("data", step2, y, s, "scheme_master.csv"))
            write_csv(treasury_master, here("data", step2, y, s, "treasury_master.csv"))
            write_csv(voucher_master, here("data", step2, y, s, "voucher_master.csv"))
        }  else if (s == section7) {
            message("- Cleaning the '", s, "' files.")
            # Read the Grant Master File
            central_scheme_master <- read_csv(here("data", step1, y, s, "central_scheme_master.csv"), col_types = cols(.default = "c"))
            scheme_master <- read_csv(here("data", step1, y, s, "scheme_master.csv"), col_types = cols(.default = "c"))
            # Clean the datasets
            central_scheme_master <- central_scheme_master %>% 
                clean_names() %>%                                       # Clean columns names
                filter(central_scheme_code != "Total:")                 # Filter out total rows
            scheme_master <- scheme_master %>% 
                clean_names() %>%                                       # Clean columns names
                filter(scheme_scheme_code != "Total:")                  # Filter out total rows
            # Create directory to save processed files
            dir.create(here("data", step2, y, s), showWarnings = FALSE)
            # Store Cleaned Files
            message(">> Storing the cleaned files.")
            write_csv(central_scheme_master, here("data", step2, y, s, "central_scheme_master.csv"))
            write_csv(scheme_master, here("data", step2, y, s, "scheme_master.csv"))
        } else print("Skip")
    }
}
