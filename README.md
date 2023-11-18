# ASA-Proj-Tester
Unit tests for Algorithm Analysis and Synthesis projects.


## Dependencies

- Makefile - You probably already have it

### On MacOS
If you want to run this on MacOS you will need to install GNU's diff command for this to work properly. I recommend using a package manager like brew:
```bash
brew install diffutils
```

## How to run
Clone the repo
```bash
git clone https://github.com/SrGesus/PO-2023-TESTS
```
Provide the file [config](config) with the necessary paths to the folder po-uilib is in and your project folder.

Followed by
```bash
make
```
You can run a single or a group of tests. But you should run make clean first. E.g:
Running only the professor's tests
```bash
make clean tests/professor/*.in
```
Running one test:
```bash
make clean tests/Gesus/0-ADDRESS.in
```
Running a few tests:
```bash
make clean tests/Branquinho/test47.in tests/Gesus/0-ADDRESS.in
```
You can then check out the respective output, on the same folder with the extension `.outhyp` and the diff `.diff`.
