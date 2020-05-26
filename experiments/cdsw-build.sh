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

# Example build script used to customize the engine 
# environment for Experiments in CML

# This file must be moved to the project's root
# directory for CML to detect it

!pip3 install -U scikit-learn

Rscript -e "install.packages(repos='https://cloud.r-project.org', c('readr', 'rsample', 'parsnip', 'yardstick'))"
