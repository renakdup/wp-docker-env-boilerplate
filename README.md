# Docker Environment Boilerplate for WordPress

### Docker configuration:
- Nginx 1.20
- PHP 7.4
- Composer > 2.1  
- MySQL 5.6
- PhpMyAdmin 5
- Node 16.14.2
- WP-CLI > 2.5.0

## Instructions
1. You need to add the string to `hosts` file your OS:  
`127.0.0.1 	wp-docker-boilerplate.local`
```bash 
    # copy & paste and fill variables
    cp .env.dist .env
    
    # run docker project
    make d.up
    
    # install wordpress dependencies
    make composer.install
    
    # install wordpress
    make wp.core.download
```
2. Visit site [wp-docker-boilerplate.local](http://wp-docker-boilerplate.local)   

### Import/Export DB

#### Import  
You need to put on your file to `./docker/mysql/backup` with the name `import_db.sql`, then you need to run the command `make mysql.import`.

#### Export
You need to run the command `make mysql.export`, then you will see the exported file by `/docker/mysql/backup` path.

---
### Other cases
If you have a problems with access right for files, try using the next command for fixing it:

```
# It is using your user:usergroup
make fix-access-right-for FILE/DIR`
``` 
or  
`sudo chown USER:GROUP FILE`

If you want change domain, you need to change `server_name` in `./docker/nginxconf.d/default.conf`.


###  Q/A  
If you get next error on MacOS  
```failed to solve with frontend dockerfile.v0: failed to create LLB definition: no match for platform in manifest sha256:20575ecebe6216036d25dab5903808211f1e9ba63dc7825ac20cb975e34cfcae: not found```

create `docker-compose.override.yml` in the project and add following lines:
```
services:
  mysql:
    platform: linux/amd64
    image: mysql:5.6 #or any other version
``` 
 

