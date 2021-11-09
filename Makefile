TARGET_DIRECTORY = $(shell echo "${PWD}/target/")
PRJ_SRC_DIRECTORY = $(shell echo "${PWD}/src/")
PRJ_SRC = $(shell ls ${PWD}/src) # All scripts from ./src
PRJ_LIB = $(shell ls -d ${PWD}/lib/*) # All libs from ./lib

export PRJ_SRC
export PRJ_LIB

SHELL := /bin/env bash
all: create_target define_main add_dependencies invoke_main make_target_exec ensure_lf_line_endings archive_target

create_target:
	if [[ ! -d "./target" ]]; then mkdir target; fi

define_main:
	for script in $${PRJ_SRC[*]}; do echo -e "#!/usr/bin/env bash\n" > ${TARGET_DIRECTORY}$${script}; echo -e "set -euo pipefail\n" >> ${TARGET_DIRECTORY}$${script}; echo -e "function main() {" >> ${TARGET_DIRECTORY}$${script}; cat "${PRJ_SRC_DIRECTORY}$${script}" | sed -e 's/^/  /g' >> ${TARGET_DIRECTORY}$${script}; echo -e "\n}\n" >> ${TARGET_DIRECTORY}$${script}; done
	
add_dependencies:
	for script in $${PRJ_SRC[*]}; do for filename in $${PRJ_LIB[*]}; do cat $${filename} >> ${TARGET_DIRECTORY}$${script}; echo >> ${TARGET_DIRECTORY}$${script}; done ; done

invoke_main:
	for script in $${PRJ_SRC[*]}; do echo -e "main \$$@" >> ${TARGET_DIRECTORY}$${script}; done

make_target_exec:
	chmod +x ${TARGET_DIRECTORY}*.sh

ensure_lf_line_endings:
	for script in $${PRJ_SRC[*]}; do sed 's/\r$$//' ${TARGET_DIRECTORY}$${script}; done

archive_target:
	cd ${TARGET_DIRECTORY}; tar -cvf target.tar . 
