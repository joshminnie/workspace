# nginx

This service allows you to run a webserver using nginx

## Configuration

There are two nginx configuration files that need to be created in order for nginx to function. `default.conf` and `nginx.conf`.
Both of these files should be placed in the root directory of the service. We have provided `default.sample.conf` and
`nginx.sample.conf` that you can copy those files to remove the `.sample` from the name so you can configure.

Both of the example files come from a default nginx installation so they should allow nginx to start as they currently are (just
with no sites configured)

Note: Properly configuring nginx is outside the scope of this document
