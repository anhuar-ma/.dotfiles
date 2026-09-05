function docker-clean -d "Prune unused Docker resources"
    if not command -q docker
        echo "docker not found" >&2
        return 1
    end
    read -l -P "Remove all unused containers, images, networks, and volumes? [y/N] " confirm
    if test "$confirm" = y -o "$confirm" = Y
        docker system prune -af --volumes
    end
end

