CONFIG=config.txt
include $(CONFIG)

ifeq ($(patsubst %.c,,$(SOURCE)),)
	LANGUAGE=C
endif
ifeq ($(patsubst %.cpp,,$(SOURCE)),)
	LANGUAGE=CPP
endif
ifeq ($(patsubst %.rs,,$(SOURCE)),)
	LANGUAGE=RUST
endif
ifeq ($(patsubst %.java,,$(SOURCE)),)
	LANGUAGE=JAVA
endif
ifeq ($(patsubst %.py,,$(SOURCE)),)
	LANGUAGE=PYTHON
endif

C_TARGET =	./c_target
CPP_TARGET = ./cpp_target
RUST_TARGET = ./rs_target
JAVA_TARGET = $(patsubst %.java, %.class, $(SOURCE))
PYTHON_TARGET = 

TARGET= ${${LANGUAGE}_TARGET}

C_COMMAND =	$(C_TARGET)
CPP_COMMAND = $(CPP_TARGET)
RUST_COMMAND = $(RUST_TARGET)
JAVA_COMMAND = java -Xss32m -Xmx256 -cp $$(dirname $(SOURCE)) $(patsubst %.java, %, $(SOURCE))
PYTHON_COMMAND = python $(SOURCE)

all: $(TARGET)
	@echo $(LANGUAGE)
	@echo $(TARGET)

$(C_TARGET): $(SOURCE)
	gcc -O3 -ansi -Wall $< -o $@ -lm

$(CPP_TARGET): $(SOURCE)
	g++ -std=c++11 -O3 -Wall file.cpp $< -o $@ -lm

$(RUST_TARGET): $(SOURCE)
	rustc --edition=2021 -C opt-level=3 -o $@ $<

$(JAVA_TARGET): $(SOURCE)
	javac $<

