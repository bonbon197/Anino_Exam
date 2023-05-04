# Anino Exam

This is a Ruby on Rails API for a leaderboard application. The application allows users to register their names and scores, and view a leaderboard ranking the users by score.

## Getting Started

To run this application, you will need to have the following installed:

- Ruby 2.6.10
- Rails 5.2.8
- PostgreSQL

To set up the application, follow these steps:

1. Clone this repository.
2. Run `bundle install` to install dependencies.
3. Create the database by running `rails db:create`.
4. Migrate the database by running `rails db:migrate`.
5. Seed the database by running `rails db:seed`.

## Running the Application

To run the application, use the following command: `rails s`. This will start a local server at `http://localhost:3000`.

## API Endpoints

The following API endpoints are available:

### Users

#### `POST /api/v1/user`

Creates a new user. The request body should contain a JSON object with the following attributes:

- `name` (string): The name of the user.

#### `GET /api/v1/user/:_id`

Returns the user with the specified ID.

### Leaderboards

#### `GET /api/v1/leaderboard/:_id`

Returns the leaderboard and it's accompanying entries with the specified ID.

#### `POST /api/v1/admin/leaderboard`

Admin endpoint. (No auth) Creates a new leaderboard. The request body should contain a JSON object with the following attributes:

- `name` (string): The name of the leaderboard.

### Entries

#### `POST /api/v1/leaderboards/:_id/user/:_id`

Creates a new entry for the specified leaderboard. The request body should contain a JSON object with the following attributes:

- `score` (integer): The score for the entry.

## Running Tests

To run the test suite, use the following command: `bundle exec rspec`.

## Author

Antonio Dapat III
