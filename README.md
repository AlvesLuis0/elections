# Elections

A simple election project

[See the changelog](/CHANGELOG.md)

## Features

- [x] Create elections
- [x] Vote
- [x] See results in graph form

![New election](/images/new.png)
![Vote](/images/vote.png)
![Results](/images/results.png)

## Starting

### Prerequisites

- Git
- Ruby 3.3.6
- Bundler
- Docker

### Running

```sh
git clone https://github.com/AlvesLuis0/elections
cd elections
docker compose up -d
bundle install
rails db:prepare
rails server
```

## Technologies

- Ruby on Rails
- Docker
- Postgresql

## Learnings

- How to fix N+1 queries with **Bullet**
- How to use charts with **Chartkick**
- How to create nested and dynamic forms with **Rails Nested Form**
- How to create tests with **RSpec**
- How to manage **Github Workflows**