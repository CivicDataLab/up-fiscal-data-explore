# Create folder to process files
message("Create the working directory for transformed data.")
dir.create(here("data", step3), showWarnings = FALSE)

# Identify all the years of data available
year <- list.files(here("data", step2))

# Setup
s = section1
# Setup empty tibble to save the data
grant_master_all <- tribble()
scheme_master_all <- tribble()
# Loop through all the years
for (y in year) {
    message("- Transforming the '", s, "' files for ", y, ".")
    # Read the Processed Files
    grant_master <- read_csv(here("data", step2, y, s, "grant_master.csv"), col_types = cols(.default = "c"))
    scheme_master <- read_csv(here("data", step2, y, s, "scheme_master.csv"), col_types = cols(.default = "c"))
    # Transform the Processed Files
    grant_master <- grant_master %>%
        rename_at(vars(starts_with("actual_progressive_expenditure")), funs(str_extract(., "actual_progressive_expenditure_upto_month"))) %>%
        # Update !
        rename_at(vars(starts_with("provisional_exp_current_month")), funs(str_extract(., "provisional_exp_current_month"))) %>%
        select(grant_no, department_name, total_budget_provision, progressive_allotment, 
               actual_progressive_expenditure_upto_month, provisional_exp_current_month) %>%
        mutate(fiscal_year = str_replace_all(str_replace_all(y, "fy_", ""), "_", "-20"))
    scheme_master <- scheme_master %>%
        rename_at(vars(starts_with("actual_progressive_expenditure")), funs(str_extract(., "actual_progressive_expenditure_upto_month"))) %>%
        rename_at(vars(starts_with("provisional_exp_current_month")), funs(str_extract(., "provisional_exp_current_month"))) %>%
        select(scheme_code, scheme_name, total_budget_provision, progressive_allotment, 
               actual_progressive_expenditure_upto_month, provisional_exp_current_month,
               fiscal_year, hierarchy)
    # Create directories to save files
    dir.create(here("data", step3, s), showWarnings = FALSE)
    # Combine master files across years
    message(">> Creating the master files accross years.")
    grant_master_all <- bind_rows(grant_master_all, grant_master)
    scheme_master_all <- bind_rows(scheme_master_all, scheme_master)
}

# Join the hierarchy of files
budgetary_scheme_master <- scheme_master_all %>%
    left_join(grant_master_all, 
              by = c("fiscal_year", "hierarchy" = "grant_no"),
              suffix = c("", "_2")) %>%
    select(!ends_with("_2"))

# Store Cleaned Files
message(">> Storing the transformed files.")
write_csv(budgetary_scheme_master, here("data", step3, s, "budgetary_scheme_master.csv"))
write_csv(grant_master_all, here("data", step3, s, "grant_master_all.csv"))
write_csv(scheme_master_all, here("data", step3, s, "scheme_master_all.csv"))

# Setup
s = section2
# Setup empty tibble to save the data
grant_master_all <- tribble()
scheme_master_all <- tribble()
object_master_all <- tribble()
# Loop through all the years
for (y in year) {
    message("- Transforming the '", s, "' files for ", y, ".")
    # Read the Processed Files
    grant_master <- read_csv(here("data", step2, y, s, "grant_master.csv"), col_types = cols(.default = "c"))
    scheme_master <- read_csv(here("data", step2, y, s, "scheme_master.csv"), col_types = cols(.default = "c"))
    object_master <- read_csv(here("data", step2, y, s, "object_master.csv"), col_types = cols(.default = "c"))
    grant_master <- grant_master %>%
        mutate(fiscal_year = str_replace_all(str_replace_all(y, "fy_", ""), "_", "-20"))
    scheme_master <- scheme_master
    object_master <- object_master %>%
        mutate(object = sprintf("%02d", as.integer(object))) %>%
        separate(hierarchy, sep = "\\$", c("grant", NA, "scheme"), extra = "drop")
    # Create directories to save files
    dir.create(here("data", step3, s), showWarnings = FALSE)
    # Combine master files across years
    message(">> Creating the master files accross years.")
    grant_master_all <- bind_rows(grant_master_all, grant_master)
    scheme_master_all <- bind_rows(scheme_master_all, scheme_master)
    object_master_all <- bind_rows(object_master_all, object_master)
}

# Join the hierarchy of files
department_wise_master <- object_master_all %>%
    left_join(scheme_master_all,
              by = c("fiscal_year", "grant", "scheme"),
              suffix = c("", "_2")) %>%
    left_join(grant_master_all,
              by = c("fiscal_year", "hierarchy" = "grant_no"),
              suffix = c("", "_3")) %>%
    select(!ends_with(c("_2", "_3")))

# Store Cleaned Files
message(">> Storing the transformed files.")
write_csv(department_wise_master, here("data", step3, s, "department_wise_master.csv"))
write_csv(grant_master_all, here("data", step3, s, "grant_master_all.csv"))
write_csv(scheme_master_all, here("data", step3, s, "scheme_master_all.csv"))
write_csv(object_master_all, here("data", step3, s, "object_master_all.csv"))

# Setup
s = section3
# Setup empty tibble to save the data
division_master_all <- tribble()
# Loop through all the years
for (y in year) {
    message("- Transforming the '", s, "' files for ", y, ".")
    # Read the Processed Files
    division_master <- read_csv(here("data", step2, y, s, "division_master.csv"), col_types = cols(.default = "c"))
    # Update the data
    division_master <- division_master %>%
        mutate(fiscal_year = str_replace_all(str_replace_all(y, "fy_", ""), "_", "-20"))
    # Create directories to save files
    dir.create(here("data", step3, s), showWarnings = FALSE)
    # Combine master files across years
    message(">> Creating the master files accross years.")
    division_master_all <- bind_rows(division_master_all, division_master)
}

# Store Cleaned Files
message(">> Storing the transformed files.")
write_csv(division_master_all, here("data", step3, s, "division_master_all.csv"))

# Setup
s = section4
# Setup empty tibble to save the data
grant_master_all <- tribble()
major_head_master_all <- tribble()
# Loop through all the years
for (y in year) {
    message("- Transforming the '", s, "' files for ", y, ".")
    # Read the Processed Files
    grant_master <- read_csv(here("data", step2, y, s, "grant_master.csv"), col_types = cols(.default = "c"))
    major_head_master <- read_csv(here("data", step2, y, s, "major_head_master.csv"), col_types = cols(.default = "c"))
    # Transform the Processed Files
    grant_master <- grant_master %>%
        rename_at(vars(starts_with("actual_progressive_expenditure")), funs(str_extract(., "actual_progressive_expenditure_upto_month"))) %>%
        # Update !
        rename_at(vars(starts_with("provisional_current_month_expenditure")), funs(str_extract(., "provisional_current_month_expenditure"))) %>%
        rename_at(vars(starts_with("total_expenditure_in_month")), funs(str_extract(., "total_expenditure_in_month"))) %>%
        select(grant_no, dep_name, total_budget_provision, progressive_allotment,
               actual_progressive_expenditure_upto_month, provisional_current_month_expenditure,
               total_expenditure_in_month) %>%
        mutate(fiscal_year = str_replace_all(str_replace_all(y, "fy_", ""), "_", "-20"))
    major_head_master <- major_head_master %>%
        rename_at(vars(contains("_march")), funs(str_replace(., "_march", ""))) %>%
        rename_at(vars(contains("_april")), funs(str_replace(., "_april", ""))) %>%
        separate(major_head, c("major_head_code", "major_head_desc"), sep = "=") %>%
        pivot_longer(total_budget_provision_plan:total_expenditure_in_month_non_plan, "plan_non_plan_temp") %>%
        mutate(plan_non_plan = if_else(str_detect(plan_non_plan_temp, "_non_plan"), "N", "P"),
               key_final = str_remove(plan_non_plan_temp, "_non_plan"),
               key_final = str_remove(key_final, "_plan")) %>%
        select(-plan_non_plan_temp) %>%
        pivot_wider(names_from = key_final, values_from = value) %>%
        select(major_head_code, major_head_desc, voted_charged, plan_non_plan,
               total_budget_provision:total_expenditure_in_month, fiscal_year, hierarchy)
    # Create directories to save files
    dir.create(here("data", step3, s), showWarnings = FALSE)
    # Combine master files across years
    message(">> Creating the master files accross years.")
    grant_master_all <- bind_rows(grant_master_all, grant_master)
    major_head_master_all <- bind_rows(major_head_master_all, major_head_master)
}

# Join the hierarchy of files
grant_major_head_master <- major_head_master_all %>%
    left_join(grant_master_all,
              by = c("fiscal_year", "hierarchy" = "grant_no"),
              suffix = c("", "_2")) %>%
    select(!ends_with("_2")) %>%
    rename(grant_no = hierarchy)

# Store Cleaned Files
message(">> Storing the transformed files.")
write_csv(grant_major_head_master, here("data", step3, s, "grant_major_head_master.csv"))
write_csv(grant_master_all, here("data", step3, s, "grant_master_all.csv"))
write_csv(major_head_master_all, here("data", step3, s, "major_head_master_all.csv"))

# Setup
s = section5
# Setup empty tibble to save the data
grant_master_all <- tribble()
# Loop through all the years
for (y in year) {
    message("- Transforming the '", s, "' files for ", y, ".")
    # Read the Processed Files
    grant_master <- read_csv(here("data", step2, y, s, "grant_master.csv"), col_types = cols(.default = "c"))
    # Transform the Processed Files
    grant_master <- grant_master %>%
        mutate(fiscal_year = str_replace_all(str_replace_all(y, "fy_", ""), "_", "-20")) %>%
        rename_at(vars(contains("_september")), funs(str_replace(., "_september", "")))
    # Create directories to save files
    dir.create(here("data", step3, s), showWarnings = FALSE)
    # Combine master files across years
    message(">> Creating the master files accross years.")
    grant_master_all <- bind_rows(grant_master_all, grant_master)
}

# Store Cleaned Files
message(">> Storing the transformed files.")
write_csv(grant_master_all, here("data", step3, s, "grant_capital_revenue_master.csv"))
write_csv(grant_master_all, here("data", step3, s, "grant_master_all.csv"))

# Setup
s = section6
# Setup empty tibble to save the data
grant_master_all <- tribble()
scheme_master_all <- tribble()
# Loop through all the years
for (y in year) {
    message("- Transforming the '", s, "' files for ", y, ".")
    # Read the Processed Files
    grant_master <- read_csv(here("data", step2, y, s, "grant_master.csv"), col_types = cols(.default = "c"))
    scheme_master <- read_csv(here("data", step2, y, s, "scheme_master.csv"), col_types = cols(.default = "c"))
    # Transform the Processed Files
    grant_master <- grant_master %>%
        rename_at(vars(starts_with("actual_progressive_expenditure")), funs(str_extract(., "actual_progressive_expenditure_upto_month"))) %>%
        # Update !
        rename_at(vars(starts_with("provisional_current_month_expenditure")), funs(str_extract(., "provisional_current_month_expenditure"))) %>%
        rename_at(vars(starts_with("total_expenditure_in_month")), funs(str_extract(., "total_expenditure_in_month"))) %>%
        mutate(fiscal_year = str_replace_all(str_replace_all(y, "fy_", ""), "_", "-20"),
               grant_no = if_else(str_length(grant_no) < 3, 
                                  suppressWarnings(sprintf("%03d", as.integer(grant_no))), 
                                  grant_no))
    scheme_master <- scheme_master %>%
        rename_at(vars(contains("_march")), funs(str_replace(., "_march", ""))) %>%
        rename_at(vars(contains("_april")), funs(str_replace(., "_april", ""))) %>%
        separate(scheme_code, sep = "=", c("scheme_code", "scheme_name"), extra = "drop") %>%
        separate(standard_object, sep = "-> ", c("standard_object_code", "standard_object_name"), extra = "drop")
    # Create directories to save files
    dir.create(here("data", step3, s), showWarnings = FALSE)
    # Combine master files across years
    message(">> Creating the master files accross years.")
    grant_master_all <- bind_rows(grant_master_all, grant_master)
    scheme_master_all <- bind_rows(scheme_master_all, scheme_master)
}

# Join the hierarchy of files
grant_wise_master <- scheme_master_all %>%
    left_join(grant_master_all, 
              by = c("fiscal_year", "hierarchy" = "grant_no"),
              suffix = c("", "_2")) %>%
    select(!ends_with("_2"))

# Store Cleaned Files
message(">> Storing the transformed files.")
write_csv(grant_wise_master, here("data", step3, s, "grant_wise_master.csv"))
write_csv(grant_master_all, here("data", step3, s, "grant_master_all.csv"))
write_csv(scheme_master_all, here("data", step3, s, "scheme_master_all.csv"))

# Setup
s = section7
# Setup empty tibble to save the data
central_scheme_master_all <- tribble()
scheme_master_all <- tribble()
# Loop through all the years
for (y in year) {
    message("- Transforming the '", s, "' files for ", y, ".")
    # Read the Processed Files
    central_scheme_master <- read_csv(here("data", step2, y, s, "central_scheme_master.csv"), col_types = cols(.default = "c"))
    scheme_master <- read_csv(here("data", step2, y, s, "scheme_master.csv"), col_types = cols(.default = "c"))
    # Transform the Processed Files
    central_scheme_master <- central_scheme_master %>%
        mutate(fiscal_year = str_replace_all(str_replace_all(y, "fy_", ""), "_", "-20"))
    scheme_master <- scheme_master %>%
        separate(scheme_scheme_code, sep = "-", c("central_scheme_code", "state_scheme_code"), extra = "drop") %>%
        mutate(grant = sprintf("%03d", as.integer(grant)))
    # Create directories to save files
    dir.create(here("data", step3, s), showWarnings = FALSE)
    # Combine master files across years
    message(">> Creating the master files accross years.")
    central_scheme_master_all <- bind_rows(central_scheme_master_all, central_scheme_master)
    scheme_master_all <- bind_rows(scheme_master_all, scheme_master)
}

# Join the hierarchy of files
pfms_master <- scheme_master_all %>%
    left_join(central_scheme_master_all,
              by = c("central_scheme_code", "state_scheme_code", "fiscal_year"),
              suffix = c("", "_2")) %>%
    select(!ends_with("_2"))

# Store Cleaned Files
message(">> Storing the transformed files.")
write_csv(central_scheme_master_all, here("data", step3, s, "central_scheme_master_all.csv"))
write_csv(scheme_master_all, here("data", step3, s, "scheme_master_all.csv"))
