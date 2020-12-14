# Load Packages
library(here)               # Dynamic Path Tracing
library(tidyverse)          # Data Processing 
library(janitor)            # Data Cleaning
library(fs)                 # File System Operations

# Set Processing Step Variables
message("Setup all stages of the process.")

step0 <- "00-raw"
step1 <- "01-processed"
step2 <- "02-cleaned"
step3 <- "03-transformed"
step4 <- "04-combined"

# Set Data Section Variables
message("Setup all sections of data processed.")

section1 <- "budgetary_scheme_expenditure"
section2 <- "department_wise_expenditure"
section3 <- "division_wise_expenditure"
section4 <- "grant_major_head_wise_expenditure"
section5 <- "grant_wise_capital_revenue_expenditure"
section6 <- "grant_wise_expenditure"
section7 <- "pfms_expenditure_detail"

# Run the process
message(">> Processing the raw data files.")
source(here("scripts", "01-process.R"), echo = TRUE)

message(">> Cleaning the processed data for use.")
source(here("scripts", "02-clean.R"), echo = TRUE)

message(">> Transforming data cleaned data for verification.")
source(here("scripts", "03-transform.R"), echo = TRUE)

message(">> Combine the transformed data to explore.")
source(here("scripts", "04-combine.R"), echo = TRUE)

# Clear Environment
# rm(list = ls())
