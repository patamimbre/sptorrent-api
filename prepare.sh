#!/bin/sh

# Localy used variables
export RACK_HOME="/app"
export RACK_ENV="development"
export PORT="5678"

# Prerequisites
cd ${RACK_HOME} && \
bundle install --clean --jobs=4 && \
gem clean
