APP=aws-tools
NS=texastribune

interactive: build
	docker run --rm --interactive --tty \
		--volume=$$(pwd):/app \
		--env-file=env-docker \
		--name=${APP} \
		${NS}/${APP} bash

build:
	docker build --tag=${NS}/${APP} .

