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

# # Models Example with scikit-learn

# Import required modules:
from joblib import load

# Load the trained model:
model = load('model.joblib')

# Define a function that can be called to generate
# predictions from the model:
def pred_arr_delay(args):
  dep_delay = args["dep_delay"]
  pred_arr_delay = model.predict([[dep_delay]]).item()
  return {"pred_arr_delay": pred_arr_delay}
