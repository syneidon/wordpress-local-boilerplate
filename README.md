# Wordpress Local Boilerplate

## Setup

1. copy `.env.example` file into `.env` (`cp .env.example .env`)
2. edit `.env` file specifying `PROJECT_NAME` into something new, and ports if needed
3. execute `./download_wp.sh` (a bash script) or download WordPress manually in this same folder
4. execute `./compose.sh` or manually `docker compose -p "myprojectname" up -d`, so that network and volumes will be unique and this boilerplate could be reused generating different compose projects
5. open http://localhost and start WP setup

--

![Example usage](example.gif)

--

Gifted by [Syneidon](https://syneidon.com){:target="_blank"}
