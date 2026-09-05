function gpp
    # Check if both arguments are provided
    if test (count $argv) -ne 2
        echo "Usage: gpp <std_version> <filename>"
        echo "Example: gpp 17 main.cpp"
        return 1
    end

    set std_number $argv[1]
    set filename $argv[2]

    # Compile and run with strict flags
    g++ -std=c++$std_number \
        -Wall \
        -Wextra \
        -Wconversion \
        -Wshadow \
        -Wfloat-equal \
        -fsanitize=address \
        -fsanitize=undefined \
        -fno-sanitize-recover \
        -D_GLIBCXX_DEBUG \
        -DLOCAL \
        $filename \
        && ./a.out
end
