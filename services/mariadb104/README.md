# MariaDB 10.4

## Setup

Copy the `.mariadb.sample.env` environment file to a file you want to use for this container. Then set the configuration details
to the the server credentials and port that you want this instance to run with.

Note: If you need multiple versions of MariaDB at the same time, you may want to configure separate environment files to ensure
there are no port collisions. If you need to run MySQL at the same time you also need to make sure there are no port collisions as
both operate on port 3306
