OS            ?= ${PLATFORM_NAME}
BUILD_DIR     ?= build
INSTALL_DIR   ?= ${INSTALL_ROOT_nto}/aarch64le/
BUILD_TYPE    ?= Release

.PHONY: clean create build

default: clean create build

create: 
ifeq ("$(wildcard $(BUILD_DIR))", "")
	@echo "${BUILD_DIR} Directory Does not exist creating."
	mkdir ${BUILD_DIR}
else
	@echo "${BUILD_DIR} Directory Already Exists."
endif
 

build:
	@echo ${PLATFORM_NAME}
	sleep 1
ifeq ($(OS),QNX)
	cd ${BUILD_DIR}; \
	"Building Capicxx-SomeIp-Runtime"; \
	cmake -DCMAKE_TOOLCHAIN_FILE=${SOA_DIR}/soa-infra/framework/qcc8_qnx710_aarch64le.cmake -DUSE_INSTALLED_COMMONAPI=OFF -DCMAKE_BUILD_TYPE=${BUILD_TYPE} -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} -DCMAKE_PREFIX_PATH="${INSTALL_DIR}/lib/cmake/CommonAPI-3.2.0/;${INSTALL_DIR}/usr/lib/cmake/vsomeip3/" .. ; \
	make install -j8;
endif

clean:
ifeq ("$(wildcard $(BUILD_DIR))", "")
	@echo "${BUILD_DIR} Directory Does not exist."
else
	@echo "${BUILD_DIR} Directory Exists deleting."
	rm -rf ${BUILD_DIR}
endif

install: default

hinstall:
