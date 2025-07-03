# Wordpress Local Boilerplate


1. copy `.env.example` file into `.env` (`cp .env.example .env`)
2. edit `.env` file specifying `PROJECT_NAME` into something new, and ports if needed
3. execute `./download_wp.sh` (a bash script) or download WordPress manually in this same folder
4. execute `docker compose up -d`
5. open http://localhost and start WP setup