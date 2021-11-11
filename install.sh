#!/bin/sh

# Install bundler if needed and then install the bundle.
gem install bundler --conservative
bundle install

# Add the current working directory to the path
touch $HOME/.profile
echo "export PATH=\"\$PATH:${PWD}\"" >> $HOME/.profile
. $HOME/.profile
