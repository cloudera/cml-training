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

# # scikit-learn Example

# This example demonstrates a simple regression modeling
# task using the using the
# [`LinearRegression`](http://scikit-learn.org/stable/modules/generated/sklearn.linear_model.LinearRegression.html)
# class in the 
# [`sklearn.linear_model`](http://scikit-learn.org/stable/modules/classes.html#module-sklearn.linear_model)
# module.

# The code in this file must be run in a Python 3 session
# and requires the scikit-learn library. If this code 
# fails to run in a Python 3 session, install
# scikit-learn by running `!pip3 install -U scikit-learn`


# ## Import Modules

import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt
from joblib import dump, load


# ## Prepare Data

# Read the flights data from the CSV file into a pandas
# DataFrame
flights_pd = pd.read_csv('data/flights.csv')

# Drop unneeded columns then drop rows with missing
# values or outliers
flights_clean_pd = flights_pd \
  .filter(['dep_delay', 'arr_delay']) \
  .dropna() \
  .loc[flights_pd.dep_delay < 400, :]

# Separate the features (x) and targets (y)
features = flights_clean_pd.filter(['dep_delay'])
targets = flights_clean_pd.filter(['arr_delay'])

# Split the features and targets each into an 80% 
# training set and a 20% test set, using 
# scikit-learn's 
# [`train_test_split`](http://scikit-learn.org/stable/modules/generated/sklearn.model_selection.train_test_split.html)
# function
train_x, test_x, train_y, test_y = train_test_split(
  features,
  targets,
  test_size=0.2
)


# ## Specify and Train Model

# Create the linear regression model object ("estimator")
# by calling the `LinearRegression` function
model = LinearRegression()

# Call the `fit` method to train the model
model.fit(train_x, train_y)


# ## Evaluate Model

# Call the `score` method to compute the coefficient of
# of determination (R-squared) on the test set. This is 
# the proportion of the variation in the target that
# can be explained by the model
model.score(test_x, test_y)

# Call the `predict` method to use the trained model to
# make predictions on the test set
test_pred = model.predict(test_x)

# Display a scatterplot of the actual feature values (x)
# and target (y) values in the test set, with the 
# regression line overlaid
plt.scatter(test_x, test_y); plt.plot(test_x, test_pred, c='k')


# ## Interpret Model

# Print the coefficient (slope) of the linear regression
# model
model.coef_[0]

# Print the intercept of the linear regression model
model.intercept_


# ## Make Predictions

# See what predictions the trained model generates for
# five new records (feature only)
d = {'dep_delay': [-6.0, 2.0, 11.0, 54.0, 140.0]}
new_data = pd.DataFrame(data=d)

# Call the `predict` method to use the trained model to
# make predictions on this new data
predictions = model.predict(new_data)

# Print the predictions
print(predictions)


# ## Save Model

# Use joblib's `dump` function to persist the model for
# future use
dump(model, 'models/model.joblib') 

# Later, you can use joblib's `load` function to load the
# saved model in a new Python session
#```python
#model = load('models/model.joblib')
#```
