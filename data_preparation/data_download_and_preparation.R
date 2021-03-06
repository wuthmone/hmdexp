library(hmdget) # download human mortality database data
                # devtools::install_github("jschoeley/hmdget")
library(dplyr)  # data verbs, operations on subsets of data
library(tidyr)  # tidy data, convert between long and wide
library(readr)  # fast csv read and write

# HMD credentials
username <- "***"
password <- "***"

# Download HMD data -------------------------------------------------------

# all countries, mortality rates, period and cohort
hmd_mx <- HMDget(.country = hmdcbook$Code,
                 .timeframe = "p+c", .measure = "mx",
                 username, password)

#write_csv(hmd_mx, path = "./priv/raw_data/hmdmx.csv")
#hmd_mx <- read_csv("./priv/raw_data/hmdmx.csv")

# Transform Data ----------------------------------------------------------

# mortality rates
hmd_mx %>%
  # variable names to lowercase
  rename(country = Country, timebase = Timeframe, sex = Sex,
         year = Year, age = Age) %>%
  mutate(
    # rename variable levels
    timebase = tolower(timebase),
    sex      = ifelse(sex == "Female", "f", ifelse(sex == "Male", "m", "fm")),
    # project cohort-age data onto period-age grid
    year     = ifelse(timebase == "cohort", year + age, year),
    # set mx of 0 to NA
    mx       = ifelse(mx == 0, NA, mx)
  ) %>%
  # remove NA's
  na.omit() -> hmd_mx

# save data for use in shiny app (rounded to 5 digits to save space)
hmd_mx %>% mutate(mx = round(mx, 5)) -> hmd_mx
save(hmd_mx, file = "./shinyapp/data/hmd_mx.Rdata")

# derive data set for mortality rate sex ratios
hmd_mx %>%
  # compute sex ratios of mortality rates
  filter(sex != "fm") %>%
  spread(key = sex, value = mx) %>%
  mutate(mx_sex_diff = f/m) %>%
  # strip sex specific mortality rates
  select(-f, -m) %>%
  # remove NA's
  na.omit() -> hmd_mx_sex_diff

# save data for use in shiny app (rounded to 5 digits to save space)
hmd_mx_sex_diff %>% mutate(mx_sex_diff = round(mx_sex_diff, 5)) -> hmd_mx_sex_diff
save(hmd_mx_sex_diff, file = "./shinyapp/data/hmd_mx_sex_diff.Rdata")
