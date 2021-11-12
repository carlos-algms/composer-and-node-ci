
build_8:
	docker build . --rm \
		-t carlosalgms/composer-and-node-ci:latest \
		-t carlosalgms/composer-and-node-ci:php8

build_7:
	docker build . --rm \
		--build-arg=FROM_IMAGE="php:7-cli-alpine" \
		-t carlosalgms/composer-and-node-ci:php7

build_71:
	docker build . --rm \
		-t carlosalgms/composer-and-node-ci:php7.1 \
		--build-arg=FROM_IMAGE="php:7.1-cli-alpine" \
		--build-arg=DEPLOYER_VERSION="v6.6.0" \
		--build-arg=PECL_EXT="" \
		--build-arg=ENABLE_EXT="" \
		--build-arg=PHP_EXT="mysqli pspell zip mcrypt"
