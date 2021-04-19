# Uttar Pradesh Fiscal Data Exploration

This repository is intended for scripts and findings related to the exploration of UP fiscal data.

## Table of Contents

[Background](#background)

[Methodology](#methodology)
- Basic Setup
- Pre-processing
- Exploratory Analysis

[Contributions](#contributions)

[Repo Structure](#repo-structure)

[License](#license)

## Background

This repository is an extension on the project to analyse and explore the Uttar Pradesh fiscal data extracted from the [Koshvani](http://koshvani.up.nic.in/) platform. The primary focus of the project is education related spending analysis.

Check out the linked repositories for more details around [data scoping](https://github.com/CivicDataLab/up-fiscal-data) and [data mining](https://github.com/CivicDataLab/up-fiscal-data-backend).

## Methodology

Following activities are conducted in the repository.

-   Pre-process the data to combining various files extracted
-   Clean to the data to normalize to begin analysis
-   Verify the accuracy of data extracted through automated checks
-   Explore and visualise data to identify key focus areas

The `tidyverse` and supporting packages from `R` are employed to conduct this exercise.

## Getting Started

Guidelines to execute the script.

### Basic Setup

#### Clone the Repository

```
git clone https://github.com/CivicDataLab/up-fiscal-data-explore.git
```

#### Download the Data

```
<< TBD >>
```

### Pre-processing

#### Run the master script

- Open the `up-fiscal-data-explore.Rproj`
- Source the `scripts/00-master.R` script

### Exploratory Ananlysis

- `explore` folder contains `.Rmd` files and outputs for various steps of the analyses.
- You can find the final analyses here: [Step 1](https://up-girl-ed-1.netlify.app/#1) / [Step 2]() / [Step 3]()

## Contributions

You can refer to the [contributing guidelines](https://github.com/CivicDataLab/up-fiscal-data-explore/blob/master/contribute/CONTRIBUTING.md) and understand how to contribute.

## Repo Structure

    root
    └── contribute/
    └── data/
    └── explore/
        └── step-1/
        └── ..
    └── scripts/
    └── LICENSE.md
    └── README.md

## License

This repository is under the [MIT License](https://github.com/CivicDataLab/up-fiscal-data-explore/blob/master/LICENSE.md).
