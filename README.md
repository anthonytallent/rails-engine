# Rails Engine 

## Table of Contents 
- [Overview](#overview)
- [Goals Achieved](#goals-achieved)
- [Configuration](#configuration)
- [How To Use](#how-to-use)
- [Contributor](#contributor)
- [Database Schema](#database-schema)


## Overview
[Rails Engine](https://github.com/aedanjames/rails-engine) is a service-oriented architecture E-Commerce application that exposes data through API endpoints, for a front-end will consume. 

## Goals Achieved    
* Work in a service-oriented architecture, use TDD to build out API endpoints to expose data. 
* Use Serializers to format JSON responses.
* Use SQL and ActiveRecord to gather data.
* Account for edge-cases and sad paths.

## Configuration 
|             |               |               |               |
|   :----:    |    :----:     |    :----:     |    :----:     |
| Ruby 2.7.x  | SQL           | SimpleCov     | Git           |
| Rails       | ActiveRecord  | Faker         | VSCode        |
| RSpec       | HTML5         | ShouldaMatcher| Postman       |
| Pry         | Postgresql    | FactoryBot    | Fast JsonApi  |

## How to Use 
This app is not on a live server at this time, 
**Visit** [This url](https://github.com/anthonytallent/rails-engine).
- In your console, type the following commands, one at a time: 
  - `$ git clone git@github.com:anthonytallent/rails-engine.git`
  - `$ bundle install`
  - `$ rake db:{create,migrate, seed}`
- Start your server in your console. If on OSX using terminal, you'll enter `$ rails s`
- Use a tool such as Postman in order to hit the API endpoints. 
- Api endpoints are as follows: 
  - GET http://localhost:3000/api/v1/merchants
  - GET http://localhost:3000/api/v1/merchants/{{merchant_id}}
  - GET http://localhost:3000/api/v1/merchants/{{merchant_id}}/items
  - GET http://localhost:3000/api/v1/items
  - GET http://localhost:3000/api/v1/items/{{item_id}}
  - POST http://localhost:3000/api/v1/items
  - PUT http://localhost:3000/api/v1/items/{{item_id}}
  - GET http://localhost:3000/api/v1/items/{{item_id}}/merchant
  **Note** in url, search terms params can be changed. `?name={{desired search term}}` Current params are placeholders
  - GET http://localhost:3000/api/v1/merchants/find?name=iLl 
  - GET http://localhost:3000/api/v1/items/find_all?name=hArU 
  - GET http://localhost:3000/api/v1/merchants/find_all?name=ILL
  - GET http://localhost:3000/api/v1/items/find?name=hArU


## Contributor
:bust_in_silhouette: **Anthony Blackwell Tallent** 
- [GitHub](https://github.com/anthonytallent)
- [LinkedIn](https://www.linkedin.com/in/anthony-blackwell-tallent-b36916255/)

## Database Schema
Below you will see a diagaram showing the relationships for all of the tables

![rails-engine](https://user-images.githubusercontent.com/60626984/102558905-c71b0280-408b-11eb-9252-b1816d72f428.png)

## Requirements
- must use Rails 5.2.x
- must use PostgreSQL
- all code must be tested via feature tests and model tests, respectively
