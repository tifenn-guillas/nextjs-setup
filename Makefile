IMAGE=nextjs
APP=nextjs-setup
UID := 1000
GID := 1000

.DEFAULT_GOAL := help

help:
	@echo ""
	@echo "Useful targets:"
	@echo ""
	@echo "  install  > Install project"
	@echo "  node     > Shell into Node container"
	@echo "  start    > Run the application in development mode"
	@echo "  stop     > Stop the application"
	@echo "  restart  > Restart the application in development mode"
	@echo "  build    > Build the application for production"
	@echo ""

install:
	docker build -t $(IMAGE) .
	docker run --rm -it --user $(UID):$(GID) --volume="$(CURDIR):/src" $(IMAGE) bash ./init.sh

node:
	docker run --rm --volume="$(CURDIR):/src" -it $(IMAGE) bash -c "cd /src && bash"

start:
	docker run --name $(APP) --rm --volume="$(PWD):/src" --publish 80:80 --workdir /src -it $(IMAGE) yarn run dev

stop:
	docker stop $(APP)

restart:	stop start

build:
	docker run --name $(APP) --rm --volume="$(PWD):/src" --workdir /src -it $(IMAGE) yarn run build

