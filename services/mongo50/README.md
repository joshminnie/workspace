# Mongo 5.0

This creates a Mongo 5.0 container.

## Setup

This container requires additional setup to run properly. You must create a file called `init-mongo.js` that is a copy of
`init-mongo.sample.js` that contains the same credentials and database name that you specificed in the `.mongo.env` environment
file.
