#!/bin/bash

# Get arguments
cppfile="$1"
stdnumber="$2"

# Check if input and output files exist, if not create them
touch in out

# Compile the cpp file
g++ -std=c++${stdnumber} \
    -Wall -Wextra -Wconversion -Wshadow -Wfloat-equal \
    -Wnon-virtual-dtor -Wold-style-cast -Woverloaded-virtual \
    -Wpedantic -Wdouble-promotion -Wformat=2 -Wnull-dereference \
    -Wcast-align -Wuseless-cast \
    -fsanitize=address -fsanitize=undefined -fsanitize=float-divide-by-zero \
    -fsanitize=float-cast-overflow -fno-sanitize-recover \
    -DGLIBCXXDEBUG -DDEBUG \
    -g -O2 \
    "${cppfile}" -o program.out 2>Log

# Check if compilation was successful
if [ $? -eq 0 ]; then
    # Run the program with input file and redirect output
    ./program.out < in > out 2>>Log
else
    echo "Compilation failed. Check Log file for details."
    exit 1
fi
