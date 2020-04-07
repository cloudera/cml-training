# Copyright 2020 Cloudera, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# # dplyr Example

# The code in this file requires the packages readr and dplyr.
# If this code fails to run in an R session, install these
# packages by running `install.packages(c("readr", "dplyr"))`

# How many flights to SFO departed from each airport, and what 
# was the average departure delay (in minutes)?

library(readr)

flights <- read_csv("data/flights.csv")

library(dplyr)

flights %>%
  filter(dest == "SFO") %>%
  group_by(origin) %>%
  summarise(
    num_departures = n(),
    avg_dep_delay = mean(dep_delay, na.rm = TRUE)
  ) %>%
  arrange(avg_dep_delay)
