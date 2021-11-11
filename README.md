# composer-and-node-ci Docker image

A docker image to be used on continuous integration projects. 

The idea is to include everything you need to run unit tests and build frontend projects.

Also, it is possible to run pure PHP or with frameworks like Laravel or CodeIgniter, Composer for dependency manager.

To deploy and transfer files, [Deployer](https://deployer.org), SSH, and RSync are available.

`Nginx` and `Apache` **are NOT** included.

## This image includes: 

* [NodeJS 14.x and NPM](https://github.com/nodesource/distributions/blob/master/README.md#installation-instructions)
* [yarn - latest](https://classic.yarnpkg.com/en/docs/install/#debian-stable)
* PHP 8-cli, 7.1-cli
* [Composer - latest](https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md)
* [Deployer](https://deployer.org) 
* OpenSSH client
* Git
* RSync
* MySql Client
* zsh
* vim
* Make


### Loaded modules:

```
$ php -m

[PHP Modules]
Core
ctype
curl
date
dom
fileinfo
filter
ftp
hash
iconv
json
libxml
mbstring
mcrypt
mysqli
mysqlnd
openssl
pcre
PDO
pdo_sqlite
Phar
posix
pspell
readline
Reflection
session
SimpleXML
SPL
sqlite3
standard
tokenizer
xml
xmlreader
xmlwriter
zip
zlib
```
