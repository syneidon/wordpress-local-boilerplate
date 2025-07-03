# Wordpress Local Boilerplate

A lightweight Docker-based boilerplate for quickly setting up a local WordPress development environment. Ideal for developers who want isolated and reusable WP setups.

![Example usage](example.gif)

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed and running
- Basic Unix shell environment (macOS/Linux or WSL on Windows)

## Technologies Used

- Docker & Docker Compose
- Bash scripts
- WordPress (latest version)

## How to

1. Copy the environment file:
    ```bash
    cp .env.example .env
    ```
2. Edit `.env` file:
    - Set a unique `PROJECT_NAME`
    - Adjust port mapping if needed
3. Download WordPress:
    ```bash
    ./download_wp.sh`
    ```
    Or download it manually into the current folder.
4. Start the local environment:
    ```bash
    ./compose.sh
    ```
    Or use docker directly specifying your project name (same as env `PROJECT_NAME`):
    ```bash
    docker compose -p "myprojectname" up -d
    ```
5. Visit http://localhost to complete the WordPress setup.
    - Database name is equal to env `PROJECT_NAME`

## Scripts

- `download_wp.sh`: Downloads the latest WordPress release into the current folder
- `compose.sh`: Starts Docker Compose using the provided project name to isolate volumes and networks
--

## Contributing
Feel free to open issues or submit pull requests to improve this boilerplate (maybe adding Windows compatibility?)

## License
[MIT](https://opensource.org/licenses/MIT)

Created with ❤️ by [Syneidon](https://syneidon.com)
