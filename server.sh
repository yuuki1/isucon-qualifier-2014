exec carton exec plackup                                 \
    -s Starlet                                           \
    --max-reqs-per-child=50000 --min-reqs-per-child=5000 \
    --max-workers=4 \
    --socket-path=/var/lib/nginx/app.sock \
    # --host localhost:8080 \
    -E prod app.psgi
