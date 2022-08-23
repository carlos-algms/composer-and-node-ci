
build_8:
	docker buildx build --rm . \
		-f Dockerfile \
		-t carlosalgms/composer-and-node-ci:latest \
		-t carlosalgms/composer-and-node-ci:php8-jammy


build_71:
	docker buildx build --rm . \
		-f Dockerfile \
		--build-arg=PHP_VERSION="7.1" \
		--build-arg=DEPLOYER_VERSION="v6.6.0" \
		--build-arg=COMPOSER_VERSION="2.2.18" \
		-t carlosalgms/composer-and-node-ci:php7.1-jammy \
