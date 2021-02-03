# composer-and-node-ci Docker image

A docker image to be used on continuous integration projects. 

The idea is to include everything you need to run unit tests and build frontend projects.

Also, it is possible to run pure PHP or with frameworks like Laravel or CodeIgniter, Composer for dependency manager.

To deploy and transfer files, [deployer](https://deployer.org) and RSync are available.


## This image includes: 

* [NodeJS 14.x and NPM](https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions)
* [yarn - latest](https://classic.yarnpkg.com/en/docs/install/#debian-stable)
* PHP 7:latest
* [composer - latest](https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md)
* [deployer](https://deployer.org) 
* OpenSSH client
* Git
* RSync
* MySql Client
