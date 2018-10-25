# target: validate
.PHONY:  validate
validate:
	shellcheck --shell=bash *.bash

# target: test
.PHONY:  test
test:
	./test.sh
