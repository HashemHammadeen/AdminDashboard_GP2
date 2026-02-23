name: CI/CD Pipeline

on:
  push:
    branches: [ "main" ] # Runs every time you push to main

jobs:
  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: password
        ports:
          - 5432:5432
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.4.8' # Matches your Dockerfile
          bundler-cache: true

      - name: Run Tests
        env:
          RAILS_ENV: test
          DATABASE_URL: postgres://postgres:password@localhost:5432/test_db
        run: |
          bundle exec rails db:test:prepare
          bundle exec rake # This will fail the build if tests fail

  build-and-push:
    needs: test # This ensures Docker only builds if tests pass
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_HUB_USERNAME }}
          password: ${{ secrets.DOCKER_HUB_TOKEN }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: hmsh00/admin_dashboard_gp:latest