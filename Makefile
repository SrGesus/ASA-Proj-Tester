CONFIG=config.txt
include $(CONFIG)

ifeq ($(patsubst %.c,,$(SOURCE)),)
TARGET 		:=	./target
COMMAND 	:=	$(TARGET)
$(TARGET): $(SOURCE)
	gcc -O3 -ansi -Wall $< -o $@ -lm
endif
ifeq ($(patsubst %.cpp,,$(SOURCE)),)
TARGET 		:= ./target
COMMAND 	:= $(TARGET)
$(TARGET): $(SOURCE)
	g++ -std=c++11 -O3 -Wall file.cpp $< -o $@ -lm
endif
ifeq ($(patsubst %.rs,,$(SOURCE)),)
TARGET 		:= ./target
COMMAND 	:= $(TARGET)
$(TARGET): $(SOURCE)
	rustc --edition=2021 -C opt-level=3 -o $@ $<
endif
ifeq ($(patsubst %.java,,$(SOURCE)),)
TARGET 		:= $(patsubst %.java, %.class, $(SOURCE))
COMMAND 	:= java -Xss32m -Xmx256 -cp $$(dirname $(SOURCE)) $(patsubst %.java, %, $(SOURCE))
$(TARGET): $(SOURCE)
	javac $<
endif
ifeq ($(patsubst %.py,,$(SOURCE)),)
TARGET		:=
COMMAND 	:= python $(SOURCE)
$(TARGET): $(SOURCE)
endif

ccred 		:= \033[0;31m\033[1m
ccgreen 	:= \033[0;32m\033[1m
ccend		:= \033[0m

TEST_FOLDER := tests/proj1
TESTS		:= $(sort $(shell find $(TEST_FOLDER) -type f -name '*.in'))
TESTS_NUM 	 = $(shell find $(TEST_FOLDER) -type f -name '*.in' | wc -l)
TESTS_FAIL 	 = $$(find $(TEST_FOLDER) -type f -name '*.diff' | wc -l)

.DEFAULT_GOAL := all
.PHONY: all clean force
all: clean_tests $(TARGET) $(TESTS)
	@printf "\n\n"
	@if [ $(TESTS_FAIL) -gt 0 ]; \
	then \
		printf "$(ccred)Failed Tests:$(ccend)\n"; \
	    cat failed_tests.txt; \
		printf "Tests Passed $(ccred)[$$(($(TESTS_NUM) - $(TESTS_FAIL)))/$(TESTS_NUM)]$(ccend)\n"; \
	else \
		printf "Tests Passed $(ccgreen)[$$(($(TESTS_NUM) - $(TESTS_FAIL)))/$(TESTS_NUM)]$(ccend)\n"; \
	fi

# Compare test results
tests/%.in: force tests/%.out
	@$(COMMAND) < tests/$*.in > tests/$*.outhyp
	@-if (diff -iw -B --color tests/$*.outhyp tests/$*.out) > /dev/null; \
	then \
		printf "$* $(ccgreen)PASSED$(ccend).\n"; \
	else \
		printf "$* $(ccred)FAILED$(ccend).\n"; \
		(diff -iwu -B --color tests/$*.outhyp tests/$*.out || touch tests/$*.diff) 2> /dev/null; \
		(diff -iwu -B --color tests/$*.outhyp tests/$*.out > tests/$*.diff || touch tests/$*.diff) 2> /dev/null; \
		echo $* >> failed_tests.txt; \
	fi
	@echo

tests/%.out:
	$(error $@ is missing. Please create it.)

clean: clean_tests
	@$(RM) target

clean_tests:
	@$(RM) tests/*/*.outhyp
	@$(RM) tests/*.outhyp
	@$(RM) tests/*/*.diff
	@$(RM) tests/*.diff
	@$(RM) failed_tests.txt


$(SOURCE):
	$(error Could not find file in $(SOURCE))

# Force target to run
force:
