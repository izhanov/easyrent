# Easyrent

The project addresses business management issues in the car rental industry.

"What Is Dead May Never Die" – Ironborn prayer

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Ruby 3.2.2
- Rails 7.1.2
- PostgreSQL 14
- Redis 7.2.3
- Sidekiq
- Typesense 0.25.2 (the search engine)
- VIPS & imagemagick (for image processing)

## Installation

### To install this project, follow these steps:

1. Clone the repository: `git clone https://github.com/rentacarsxeasyrent/easyrent.git`
2. Navigate into the project directory: `cd easyrent`
3. Install dependencies: `bundle install`

### To install Typesense via docker, follow these steps:

1. `docker pull typesense/typesense:0.25.2`
2. `docker run -p 8108:8108 \`
    `-v$(pwd)/typesense-data:/data typesense/typesense:0.25.2 \`
            `--data-dir /data \`
            `--api-key=$TYPESENSE_API_KEY \`
    `--enable-cors`

**If you develop on macOS X just use Docker Desktop for running**

**NOTE! If you want run Typesense self-hosted try this:**

`curl -O https://dl.typesense.org/releases/0.25.2/typesense-server-0.25.2-amd64.deb`

### To install imagemagick and VIPS

1. `sudo apt install imagemagick libvips`

## Usage

### Before start the project be sure that these services are run:

1. PostgreSQL 14
2. Redis 7.2.3
3. Typesense 0.25.2 (via docker or self-hosted)


### Then just run

```bash
 # ~/home/easyrent
 bin/dev
```

### Troubleshooting

##### Ruby

Issues with openssl

```
brew install openssl@3

rvm install 3.2.2 --with-openssl-dir=$(brew --prefix openssl@3)
```

##### Puma

Issues with openssl

```bash
bundle config build.puma --with-cflags="-Wno-error=implicit-function-declaration"

gem install puma:6.4.0 -- --with-cppflags=-I/usr/local/opt/openssl@3/include
```
