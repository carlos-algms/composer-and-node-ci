IMAGE=carlosalgms/composer-and-node-ci
TARGET=Dockerfile

build_8:
	docker pull $(IMAGE):php8 || true; \
	docker buildx build --rm . \
		-f $(TARGET) \
		-t $(IMAGE):latest \
		-t $(IMAGE):php8


build_71:
	docker buildx build --rm . \
		-f $(TARGET) \
		--build-arg=PHP_VERSION="7.1" \
		--build-arg=DEPLOYER_VERSION="v6.6.0" \
		--build-arg=COMPOSER_VERSION="2.2.18" \
		-t $(IMAGE):php7.1 \
