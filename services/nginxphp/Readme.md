# nginx and Multiple PHP Versions

This service allows you to host websites with nginx and PHP FPM versions 5.5 - 8.0.

## Setup

### Step 1: Environment files

This service uses the `.network` and `.webroot` environment files. Make sure both of these are setup.

`.weebroot` contains the value `WEBROOT` that coorlates to the path on the HOST OPERATING SYSTEM that you would like to be accessible inside the service. This path will be mapped to the `/webroot` directory inside all of the containers. This path will be what you use to configure your sites to work from.

### Step 2: Configure nginx

There are two nginx configuration files that need to be created in order for nginx to function. `default.conf` and `nginx.conf`. Both of these files should be placed in the root directory of the service. We have provided `default.conf.example` and `nginx.conf.example` that you can copy those files to remove the `.example` from the name so you can configure.

Both of the example files come from a default nginx installation so they should allow nginx to start as they currently are (just with no sites configured)

Note: Properly configuring nginx is outside the scope of this document.

#### PHP FPM Hostnames

When configuring nginx to connect to PHP FPM use the hostname `nginxphp` and then the PHP version without period (ie for PHP 7.2 the hostname would be `nginxphp72`)

### Step 3: Configure PHP versions

This step is technically optional, but most of the PHP versions that you use will need at least some configuration.

In each of the PHP version subdirectories there is a script called `build.sh.example` that can be copied to `build.sh`. When `build.sh` exists in a PHP version subdirectory, this script will be executed when the container for that PHP version is built.

Note: Properly configuring PHP containers is outside the scope of this document. Please see https://hub.docker.com/_/php for how to properly configure a PHP Docker container.

## FAQ

### Why is the webroot volume in nginx read only?

It is my opinion that it is not the role of the webserver to be able to manipulate the files it is hosting. That responsibility
is reserved exclusively to the PHP containers.
