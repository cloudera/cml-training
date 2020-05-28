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

# # Models Example with tidymodels

# Load required packages:
library(dplyr)

# Load the trained model:
model <- readRDS("model.rds")

# Define a function that can be called to generate
# predictions from the model:
pred_arr_delay <- function(args) {
  dep_delay <- args$dep_delay
  prediction <- model %>%
    predict(list(dep_delay = dep_delay)) %>%
    pull(.pred)
  list(pred_arr_delay = round(prediction))
}

# Example input as an R list:
#```r
#list(dep_delay = 43)
#```

# Example input as JSON:
#```
#{"dep_delay": 43}
#```

# Example output as JSON:
#```
#{"pred_arr_delay": 38}
#```
