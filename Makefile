IMAGE=carlosalgms/composer-and-node-ci
TARGET=Dockerfile

build_8:
	docker pull $(IMAGE):php8 || true; \
	docker buildx build --rm . \
		--load
		-f $(TARGET) \
		-t $(IMAGE):latest \
		-t $(IMAGE):php8

build_74:
	docker buildx build --rm . \
		-f $(TARGET) \
		--load \
		--build-arg=PHP_VERSION="7.4" \
		-t $(IMAGE):php7.4 \

build_71:
	docker buildx build --rm . \
		-f $(TARGET) \
		--load \
		--build-arg=PHP_VERSION="7.1" \
		--build-arg=DEPLOYER_VERSION="v6.6.0" \
		--build-arg=COMPOSER_VERSION="2.2.18" \
		-t $(IMAGE):php7.1 \
