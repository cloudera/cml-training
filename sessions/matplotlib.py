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

# # Matplotlib Example

# ## Preparing Data

# Many plotting libraries including Matplotlib can work
# with data in pandas DataFrames. Often, the first step
  # to visualize data with Python is to get the data into
  # a pandas DataFrame.

# This example reads the flights data from a CSV file
# into a pandas DataFrame:

import numpy as np
import pandas as pd

flights_pd = pd.read_csv('data/flights.csv')

# To prepare data for visualization, it is often
# useful to:
# * Drop unneeded columns
# * Drop missing values
# * Sample or aggregate if the data is large

# This example uses pandas DataFrame methods to perform
# some of those steps:

delays_sample_pd = flights_pd \
  .filter(['dep_delay', 'arr_delay']) \
  .dropna() \
  .sample(frac=0.10)

# Alternatively, you could use PySpark to read data
# into a Spark DataFrame, call Spark DataFrame methods
# to prepare the data, and call the `toPandas()`
# method to return a pandas DataFrame.

  
# ## Visualizing Data

# To create simple plots in Python, you can import
# `matplotlib.pyplot` and use the functions it provides.

import matplotlib.pyplot as plt

# For example, create a scatterplot to visualize the
# relationship between departure delay and arrival delay:

plt.scatter(
  x = delays_sample_pd['dep_delay'],
  y = delays_sample_pd['arr_delay']
)

# The scatterplot seems to show a positive linear
# association between departure delay and arrival delay.
