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

# # sparklyr Example

# The code in this file requires the sparklyr package.
# If this code fails to run in an R session, install
# sparklyr by running `install.packages("sparklyr")`

# ## Starting a Spark Application

# Begin by loading the sparklyr package:

library(sparklyr)

# Then call `spark_connect()` to start a Spark application.
# This example also gives the Spark application a name:

spark <- spark_connect(app_name = "cml-training-sparklyr")

# Now you can use the connection object named `spark` to
# read data into Spark.


# ## Reading Data

# Read the flights dataset. This data is in CSV format
# and includes a header row. Spark can infer the schema
# automatically from the data:

flights <- spark_read_csv(
  sc = spark,
  name = "nyc_flights_2013",
  path = "data/flights.csv",
  header = TRUE,
  infer_schema = TRUE
)

# The result is a Spark DataFrame named `flights`. Note
# that this is not an R data frame—it is a pointer to a
# Spark DataFrame.


# ## Inspecting Data

# Inspect the Spark DataFrame to gain a basic
# understanding of its structure and contents.

# To make the code more readable, the examples below use
# the pipe operator `%>%`.

# Print the number of rows:

flights %>% sdf_nrow()

# Print the column names:

flights %>% colnames()

# Print five rows of data, for as many columns as fit on
# the screen:

flights %>% head(5)

# Print 10 rows (the default number is 10):

flights

# Use `as.data.frame()` to return an in-memory R data
# frame. In CML, this displays in a scrollable grid.
# For example, return five rows as an in-memory R data
# frame, then display it:

flights_df <- flights %>% head(5) %>% as.data.frame()
flights_df

# Caution: When working with a large Spark DataFrame,
# limit the number of rows before returning an in-memory
# R data frame


# ## Transforming Data Using dplyr Verbs

# sparklyr works together with the popular R package
# [dplyr](http://dplyr.tidyverse.org). sparklyr enables
# you to use dplyr *verbs* to manipulate data with Spark.

# The main dplyr verbs are:
# * `select()` to select columns
# * `filter()` to filter rows
# * `arrange()` to order rows
# * `mutate()` to create new columns
# * `summarise()` to aggregate

# There are also some other, less important verbs, like
# `rename()` and `transmute()`, that are variations on
# the main verbs.

# In addition to verbs, dplyr also has the function
# `group_by()`, which allows you to perform operations by
# group.

# Load the dplyr package:

library(dplyr)

# `select()` returns the specified columns:

flights %>% select(carrier)

# `distinct()` works like `select()` but returns only
# distinct values:

flights %>% distinct(carrier)

# `filter()` returns rows that satisfy a Boolean
# expression:

flights %>% filter(dest == "SFO")

# `arrange()` returns rows arranged by the specified
# columns:

flights %>% arrange(month, day)

# The default sort order is ascending. Use the helper
# function `desc()` to sort by a column in descending
# order:

flights %>% arrange(desc(month), desc(day))

# `mutate()` adds new columns or replaces existing
# columns using the specified expressions:

flights %>% mutate(on_time = arr_delay <= 0)

flights %>% mutate(flight_code = paste0(carrier, flight))

# `summarise()` performs aggregations using the specified
# expressions.

# Use aggregation functions such as `n()`, `n_distinct()`,
# `sum()`, and `mean()`. With some of these functions,
# you must specify `na.rm = TRUE` to silence warnings
# about missing values:

flights %>% summarise(n = n())

flights %>%
  summarise(num_carriers = n_distinct(carrier))

# `group_by()` groups data by the specified columns, so
# aggregations can be computed by group:

flights %>%
  group_by(origin) %>%
  summarise(
    num_departures = n(),
    avg_dep_delay = mean(dep_delay, na.rm = TRUE)
  )

# By chaining together multiple dplyr verbs, you can
# analyze data to answer questions. For example:

# How many flights to SFO departed from each airport,
# and what was the average departure delay (in minutes)?

flights %>%
  filter(dest == "SFO") %>%
  group_by(origin) %>%
  summarise(
    num_departures = n(),
    avg_dep_delay = mean(dep_delay, na.rm = TRUE)
  ) %>%
  arrange(avg_dep_delay)


# ## Spark DataFrames Functions

# In addition to the dplyr verbs, there are also some
# other data manipulation functions you can use with
# sparklyr. For example:

# `na.omit()` filters out rows with missing values:

flights %>% na.omit()

# `sdf_sample()` returns a random sample of rows:

flights %>%
  sdf_sample(fraction = 0.05, replacement = FALSE)


# ## Using SQL Queries

# Instead of using dplyr verbs, you can use a SQL query
# to achieve the same result:

tbl(spark, sql("
  SELECT origin,
    COUNT(*) AS num_departures,
    AVG(dep_delay) AS avg_dep_delay
  FROM nyc_flights_2013
  WHERE dest = 'SFO'
  GROUP BY origin
  ORDER BY avg_dep_delay"))


# ## Cleanup

# Stop the Spark application:

spark_disconnect(spark)
