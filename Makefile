MAKE="make"
INSTALL="install"
TAR="tar"
GREP="grep"
NODE="node"
NPM="npm"
DESTDIR="./dist"
PKG_VERSION := $( $(GREP) -Po '(?<="version": ")[^"]*' )
TMPDIR := $(shell mktemp -d)
DOCKER_IMAGE = "$(shell basename $(CURDIR) | tr [:upper:] [:lower:])"
DOCKER_TAG="$(DOCKER_TAG)"
CONTAINER_NAME="$(CONTAINER_NAME)"
# default modules
MODULES="php"

all: uninstall builddirs npm_dependencies swig htmlmin min-css min-js copy-img submodules

all-2: builddirs npm_dependencies swig htmlmin min-css min-js copy-img submodules

swig:
	$(NODE) node_modules/swig/bin/swig.js render -j dist.json templates/index.swig > $(CURDIR)/build/index.html

htmlmin:
	$(NODE) node_modules/htmlmin/bin/htmlmin $(CURDIR)/build/index.html -o $(CURDIR)/build/index.html

installdirs:
	mkdir -p $(DESTDIR)/ $(DESTDIR)/img
ifneq (,$(findstring php,$(MODULES)))
	mkdir -p $(DESTDIR)/includes
endif
ifneq (,$(findstring moe,$(MODULES)))
	mkdir -p $(DESTDIR)/moe/{css,fonts,includes,js,login,panel/css/font,panel/css/images,register,templates}
endif
	
min-css:
	$(NODE) $(CURDIR)/node_modules/.bin/cleancss $(CURDIR)/static/css/style.css --output $(CURDIR)/build/style.min.css

min-js:
	$(NODE) $(CURDIR)/node_modules/.bin/uglifyjs ./static/js/app.js >> $(CURDIR)/build/main.min.js

copy-img:
	cp -v $(CURDIR)/static/img/*.png $(CURDIR)/build/img/

copy-php:
ifneq ($(wildcard $(CURDIR)/static/php/.),)
	cp -rv $(CURDIR)/static/php/* $(CURDIR)/build/
else
	$(error The php submodule was not found)
endif

copy-moe:
ifneq ($(wildcard $(CURDIR)/moe/.),)
	cp -rv $(CURDIR)/moe $(CURDIR)/build/
else
	$(error The moe submodule was not found)
endif

install: installdirs
	cp -rv $(CURDIR)/build/* $(DESTDIR)/

dist:
	DESTDIR=$(TMPDIR)/uguu-$(PKGVERSION)
	export DESTDIR
	install
	$(TAR) cJf uguu-$(PKG_VERSION).tar.xz $(DESTDIR)
	rm -rf $(TMPDIR)
	
clean:
	rm -rvf $(CURDIR)/node_modules 
	
uninstall:
	rm -rvf $(CURDIR)/build
	rm -rvf $(DESTDIR)/
	
npm_dependencies:
	$(NPM) install

build-image:
		docker build -f docker/Dockerfile --build-arg VERSION=$(UGUU_RELEASE_VER) --no-cache -t $(DOCKER_IMAGE):$(DOCKER_TAG) .

run-container:
		 docker run --name $(CONTAINER_NAME) -d -p 8080:80 -p 8081:443 --env-file docker/.env $(DOCKER_IMAGE):$(DOCKER_TAG)

purge-container:
	if docker images | grep $(DOCKER_IMAGE); then \
	 	docker rm -f $(CONTAINER_NAME) && docker rmi $(DOCKER_IMAGE):$(DOCKER_TAG) || true;\
	fi;		

builddirs:
	mkdir -p $(CURDIR)/build $(CURDIR)/build/img 
ifneq (,$(findstring php,$(MODULES)))
	mkdir -p $(CURDIR)/build/classes $(CURDIR)/build/includes
endif
ifneq (,$(findstring moe,$(MODULES)))
	mkdir -p $(CURDIR)/build/moe/{css,fonts,includes,js,login,panel/css/font,panel/css/images,register,templates}
endif

submodules:
	$(info The following modules will be enabled: $(MODULES))
ifneq (,$(findstring php,$(MODULES)))
	$(MAKE) copy-php
endif
ifneq (,$(findstring moe,$(MODULES)))
	$(MAKE) copy-moe
endif
