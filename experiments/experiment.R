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

# # Experiments Example with tidymodels

# Parse command-line arguments. This script expects
# one argument: the string `true` or `false`:
arguments <- commandArgs(trailingOnly = TRUE)
if (length(arguments) > 0 && 
    tolower(arguments[1]) == "true") {
  fit_intercept <- TRUE
} else {
  fit_intercept <- FALSE
}


# Load packages:
library(cdsw)
library(readr)
library(dplyr)
library(rsample)
library(parsnip)
library(yardstick)


# Read and prepare data:
flights_df <- read_csv("data/flights.csv")

flights_clean_df <- flights_df %>%
  select(dep_delay, arr_delay) %>%
  na.omit() %>% 
  filter(dep_delay < 400)

flights_split <- initial_split(
  flights_clean_df,
  prop = 0.8
)
flights_train <- training(flights_split)
flights_test <- testing(flights_split)


# Specify the model and train it using the training
# sample:
if (fit_intercept) {
  model_formula <- arr_delay ~ dep_delay
} else {
  model_formula <- arr_delay ~ dep_delay - 1
}
model <- linear_reg() %>%
  set_engine("lm") %>%
  fit(model_formula, data = flights_train)


# Evaluate the model using the test sample. Track the
# value of R-squared (rounded to four decimal
# places) to compare experiment results:
test_pred <- predict(model, new_data = flights_test)

test_results <- bind_cols(
  test_pred,
  flights_test %>% select(dep_delay, arr_delay)
)

r2 <- test_results %>% 
  metrics(truth = arr_delay, estimate = .pred) %>%
  filter(.metric == "rsq") %>%
  pull(.estimate)

track.metric("R_squared", round(r2, 4))


# Save the model for future use:
saveRDS(model, "model.rds")
track.file("model.rds")
