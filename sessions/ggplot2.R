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

# # ggplot2 Example

# ## Preparing Data

# Most R plotting functions and packages expect input
# data to be in in-memory R data frames. Often, the
# first step to visualize data with R is to get the
# data into an in-memory R data frame.

# This example reads the flights data from a CSV file
# into a data frame:

library(readr)

flights_df <- read_csv("data/flights.csv")

# To prepare data for visualization, it is often
# useful to:
# * Drop unneeded columns
# * Drop missing values
# * Sample or aggregate if the data is large

# This example uses dplyr and base R functions to
# perform some of those steps:

library(dplyr)

delays_sample_df <- flights_df %>%
  select(dep_delay, arr_delay) %>%
  na.omit() %>% 
  sample_frac(0.10)

# Alternatively, you could use sparklyr to read data
# into a Spark DataFrame and prepare the data, then 
# use the `collect()` function to return an in-memory
# R data frame.


# ## Visualizing Data

# The ggplot2 packge is a popular choice for creating
# data visualizations in R. Start by loading the
# package:

library(ggplot2)

# To create a visualization, call `ggplot()`, passing 
# a data frame and an aesthetic mapping with `aes()`.
# Then add layers using `geom_` functions.

# For example, create a scatterplot to visualize the
# relationship between departure delay and arrival delay:

ggplot(delays_sample_df, aes(x=dep_delay, y=arr_delay)) +
  geom_point()

# The scatterplot seems to show a positive linear
# association between departure delay and arrival delay.
