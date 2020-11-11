# Dockerfile to build customized Cloudera Machine Learning (CML) engine image

# Specify a base engine image
FROM docker.repository.cloudera.com/cloudera/cdsw/engine:13-cml-2020.10-1

# Install Linux software
RUN apt-get update && apt-get install -y ffmpeg

# Install Python packages
RUN pip3 install -U folium joblib pendulum scikit-learn

# Install R packages
RUN Rscript -e "install.packages(c('dplyr','leaflet','lubridate','parsnip','readr','rsample','sparklyr','yardstick'))"
