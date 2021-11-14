# nginx and Multiple PHP Versions

TBD - To be documented!

## FAQ

### I don't need this many PHP versions. What can I do?

As long as the unneeded versions of PHP are not being referenced in the nginx configuration, you can comment them out of the main docker-compose.yml file

### Why is the webroot volume in nginx read only?

It is my opinion that it is not the role of the webserver to be able to manipulate the files it is hosting. That responsibility
is reserved exclusively to the PHP containers.
