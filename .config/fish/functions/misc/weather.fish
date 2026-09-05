function weather -d "Show weather forecast"
    curl -s "wttr.in/$argv[1]"
end

