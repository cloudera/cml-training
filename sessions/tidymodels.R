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

# # tidymodels Example

# This example demonstrates a simple regression modeling
# task using the
# [parsnip](https://parsnip.tidymodels.org)
# package, with help from two other packages in the
# [tidymodels](https://www.tidymodels.org) collection
# of packages.

# The code in this file requires the packages readr,
# rsample, parsnip, and yardstick. If this code fails to
# run in an R session, install these packages by running
# `install.packages(c("readr", "rsample", "parsnip", "yardstick"))`


# ## Load Packages

library(readr)
library(dplyr)
library(rsample)
library(parsnip)
library(yardstick)
library(ggplot2)


# ## Prepare Data

# Read the flights data from the CSV file into a data frame
flights_df <- read_csv("data/flights.csv")

# Drop unneeded columns then drop rows with missing
# values or outliers
flights_clean_df <- flights_df %>%
  select(dep_delay, arr_delay) %>%
  na.omit() %>% 
  filter(dep_delay < 400)

# Split the data into an 80% training set and a 20%
# evaluation (test) set, using the `initial_split()`
# function in the
# [rsample](https://rsample.tidymodels.org)
# package
flights_split <- initial_split(
  flights_clean_df,
  prop = 0.8
)
flights_train <- training(flights_split)
flights_test <- testing(flights_split)


# ## Specify and Train Model

# To train a model with parsnip, you use one of the
# model functions listed in the 
# [table of models](https://www.tidymodels.org/find/parsnip/)
# on the parsnip website. You specify an _engine_
# (typically an R modeling package) using the 
# `set_engine()` function, then you call the
# `fit()` function to train the model.

model <- linear_reg() %>%
  set_engine("lm") %>%
  fit(arr_delay ~ dep_delay, data = flights_train)


# ## Evaluate Model

# To evaluate the model, first you use the model to 
# generate predictions for the test (evaulation) set

# To generate predictions from the trained model, call
# parsnip's `predict()` function, passing the trained model
# object as the first argument, and the data to predict
# on as the `new_data` argument
test_pred <- predict(model, new_data = flights_test)

# Then combine the column of predictions with the
# columns of actual feature values (x) and target
# values (y), so these columns are together in one
# data frame
test_results <- bind_cols(
  test_pred,
  flights_test %>% select(dep_delay, arr_delay)
)

# Then to evaluate the model, use the `metrics()`
# function in the
# [yardstick](https://yardstick.tidymodels.org)
# package. This function estimates several common
# model performance metrics
test_results %>% 
  metrics(truth = arr_delay, estimate = .pred) 


# ## Interpret Model

# Display a scatterplot of the actual feature values (x)
# and target (y) values in the test set, with the 
# regression line overlaid
ggplot(flights_test, aes(x = dep_delay, y = arr_delay)) +
  geom_point(color = "steelblue") +
  geom_line(data = test_results, aes(x = dep_delay, y = .pred))

# Print the coefficient (slope) and intercept of the
# linear regression model
model$fit$coefficients


# ## Make Predictions

# See what predictions the trained model generates for
# five new records (feature only)
new_data <- tibble(
  dep_delay = c(-6.0, 2.0, 11.0, 54.0, 140.0)
)

# Call the `predict` function to use the trained model to
# make predictions on this new data
predictions <- predict(model, new_data)

# Print the predictions
predictions


# ## Save Model

# Use the `saveRDS()` function to persist the model for
# future use
saveRDS(model, "models/model.rds")

# Later, you can use the `readRDS()` function to load
# the saved model in a new R session
#```r
#model <- readRDS("models/model.rds")
#```

# Trained R model objects are sometimes very large.
# Before saving a model, consider using the
# [butcher](https://tidymodels.github.io/butcher/)
# package to reduce its size by removing parts that
# are not needed to generate predictions.
