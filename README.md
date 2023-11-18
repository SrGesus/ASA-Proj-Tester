# ASA-Proj-Tester
Unit tests for Algorithm Analysis and Synthesis projects.

## Tests

Description of each test:
* [Project 1](tests/proj1/)

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
git clone https://github.com/SrGesus/ASA-Proj-Tester
```
Provide the file [config.txt](config.txt) with the path to your source code.

Followed by
```bash
make
```
You can also run a specific test or a group of tests. But you should run make clean first. E.g:
```bash
make clean tests/proj1/A.in tests/proj1/B.in
```
You can then check out the respective output, on the same folder with the extension `.outhyp` and the diff `.diff`.
