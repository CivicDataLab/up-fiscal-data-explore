# Create folder to process files
message("Create the working directory for translating data.")
dir.create(here("data", step4), showWarnings = FALSE)

# Translation masters folders
dir.create(here("data", step4, "masters"), showWarnings = FALSE)
dir.create(here("data", step4, "masters", "original"), showWarnings = FALSE)
dir.create(here("data", step4, "masters", "translated"), showWarnings = FALSE)

# Grant Major Head
## Read the file
grant_major_head_master <- read_csv(here("data", step3, section4, "grant_major_head_master.csv"), 
                                    col_types = cols(.default = "c"))

## Extract Translation Data
## Grant Details
grant_trans <- grant_major_head_master %>% 
    group_by(grant_no, dep_name) %>%
    summarise(1)

## Major Head Details
major_head_trans <- grant_major_head_master %>% 
    group_by(major_head_code, major_head_desc) %>%
    summarise(1) %>%
    filter(!is.na(major_head_desc)) %>%
    distinct(major_head_code)


pfms_master <- read_csv(here("data", step3, section7, "pfms_master.csv"), 
                                    col_types = cols(.default = "c"))


pfms_msater_plus <- pfms_master %>% 
    mutate(major_head_code = str_extract(head, "\\d{4}")) %>%
    left_join(grant_trans, by = c("grant" = "grant_no")) %>%
    left_join(major_head_trans, by = c("major_head_code")) %>%
    select(-hierarchy, -`1`)

write_csv(pfms_msater_plus, "data/04-translated/pfms_master_plus.csv")
