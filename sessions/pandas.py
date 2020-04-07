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

# # pandas Example

# The code in this file requires:
# * Python 3.5.3 or higher
# * pandas 0.25.0 or higher
# If this code fails to run in a Python 3 session, install the
# newest version of pandas by running `!pip3 install -U pandas`

# How many flights to SFO departed from each airport, and what 
# was the average departure delay (in minutes)?

import pandas as pd

flights = pd.read_csv('data/flights.csv')

flights \
  .loc[flights.dest == 'SFO', :] \
  .groupby('origin') \
  .agg(
    num_departures=('flight','size'), \
    avg_dep_delay=('dep_delay','mean'), \
  ) \
  .reset_index() \
  .sort_values('avg_dep_delay')
