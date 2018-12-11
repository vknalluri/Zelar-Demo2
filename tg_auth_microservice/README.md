# README

This is a Authorization Microservice which is aimed to provide authentication layer and manage users.

Instructions to configure the Application:

* Ruby version: 2.5.1

* System dependencies: PostgresSQL, Rails, RVM

* Database creation: 

  1. Create a postgres user
  2. Create a database and ensure that new postgres user created owns the database. 
  3. Configre database.yml file
  4. rake db:migrate (to run migrations)

* How to run the test suite: rspec (from the project directory)

* Deployment instructions: cap deploy productio

* Running application (from the project directory): 

  1. Use RVM and create a gemset (ex: rvm use 2.5.1@tg_auth --create)
  2. gem install bundle 
  3. bundle install
  4. rake db:migrate
  5. rails s -p 3001 (We are using port number 3001 for this microservice and gateway uses port 3000. This are configurable and you can change them and run the microservices with desired port numbers along with making changes at angular application level to consider new port.)

* To view the API interface please visit: http://localhost:3001/docs/