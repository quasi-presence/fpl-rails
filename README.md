# Fantasy Points League (FPL) - FPL-RAILS

## Project overview

See the main FPL repo for project overview [README](https://github.com/quasi-presence/fpl#readme)

## Setup

FPL-RAILS setup is a docker based setup.

1. Checkout the repo
2. Copy `.env.example` to `.env.development` (or whichever environment your running)
3. Update .env file based on your configuration
4. Update `docker-compose.yml` based on your configuration
5. Run `docker-compose run web bundle install`
6. Start app by running `docker-compose up -d`
7. Run `docker-compose run web bundle exec rails db:migrate`
7. Restart for good measure `docker-compose down && docker-compose up -d`

## Implemented Features

  * [x] Home page
  * [x] Sign up
  * [x] Login
  * [x] Logout
  * [x] View dashboard
  * [x] View profile
  * [x] Update profile
  * [ ] Create league
  * [ ] View dashboard/leagues
  * [ ] View league details
  * [ ] Invite league members
  * [ ] Create league event/schedule
  * [ ] Member notifications
    * [ ] Member picks
    * [ ] Event results
  * [ ] Select event picks
  * [ ] Enter event results
  * [ ] Collect real league data via APIs or web scrapers
    * [ ] Competitors
    * [ ] Scheduled events
    * [ ] Event results
  * [ ] TBD

## Notes
