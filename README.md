# Rails Engine API

This is a solo project for BE 2003 Mod 3. Rails Engine is an E-Commerce Application. It is working in a service-oriented architecture, meaning the front and back ends of this application are separate and communicate via APIs. My job in the backend is to expose the data that powers the site through an API that the front end will consume. [Rails Driver](https://github.com/turingschool-examples/rails_driver) is the front end of the application. It includes a test suite as well as a front end to test your application.It should be noted that in most professional applications, the front end would not be written in Rails. More likely, a pure front end application would use a Javascript framework such as React. However, in order to make this portion of the project more understandable to BEM3 students, it was written in Rails.

## Getting Started

```
git clone git@github.com:melatran/rails_engine.git
```

## Instructions

- run `bundle install`
- run `rake db:reset`
- run `bundle exec rake import`
- run `rails s`

## JSON Response

Reponse for Merchant
```
{
 "data": {
      "id": "1",
      "type": "merchant",
      "attributes": {
          "name": "Schroeder-Jerde",
          "id": 1
        }
  }
}
```

Response for item
```
{
  "data": {
    "id": "67",
    "type": "item",
    "attributes": {
          "id": 67,
          "name": "Item Est Tempore",
          "description": "Sit et eveniet est dolor soluta nihil consequatur. Voluptatem modi sapiente nam. Esse sunt cumque ea aut aut consequatur quia.",
          "unit_price": 136.49,
          "merchant_id": 3
      }
    }
}
```

Response for Revenue

```
{
  "data": {
      "id": "1",
      "type": "merchant_revenue",
      "attributes": {
          "revenue": 528774.6400000005
        }
    }
}
```

## ReST Endpoints

| API Endpoint       | Path                                |Description
| ------------------ | ----------------------------------- |---------------------------------
| Merchant All       | `GET` /api/v1/merchants             |Returns the data of all merchants in database
| Merchant Solo      | `GET` /api/v1/merchants/:id         |Returns the data for a single merchant
| Create Merchant    | `POST` /api/v1/merchants            |Creates a new merchant
| Update Merchant    | `PUT` /api/v1/merchants/:id         |Update an exsiting merchant
| Update Merchant    | `PATCH` /api/v1/merchants/:id       |Update an exisitng merchant
| Delete Merchant    | `DELETE` /api/v1/merchants/:id      |Delete an existing merchant
| Items All          | `GET` /api/v1/items                 |Returns the data of all items in database
| Item Solo          | `GET` /api/v1/items/:id             |Returns the data of a single item
| Create Item        | `POST` /api/v1/items                |Creates a new item
| Update Item        | `PUT` /api/v1/items/:id             |Update an exsiting item
| Update Item        | `PATCH` /api/v1/items/:id           |Update an exisitng item
| Delete Item        | `DELETE` /api/v1/items/:id          |Delete an existing item


## Relationship Endpoints

| API Endpoint       | Path                                |Description
| ------------------ | ----------------------------------- |---------------------------------
| Merchant Items     | `GET`/api/v1/merchants/:id/items    |Returns all the items for that one merchant
| Items Merchant     | `GET`/api/v1/items/:id/merchant     |Returns the merchant the item belongs to


## Find Endpoints

| API Endpoint       | Path                                        |Description
| ------------------ | ---------------------------------------     |---------------------------------
| Merchant Find      | `GET`/api/v1/merchants/find?parameters      |Returns the first data that matches the param
| Merchant Find All  | `GET`/api/v1/merchants/find_all?parameters  |Returns the all the data that matches the param
| Item Find          | `GET`/api/v1/items/find?parameters          |Returns the first data that matches the param
| Item Find All      | `GET`/api/v1/items/find_all?parameters      |Returns the all the data that matches the param


## Business Intelligence Endpoints

| API Endpoint          | Path                                             |Description
| ------------------    | ---------------------------------------------    |---------------------------------
| Merchant Most Revenue | `GET`/api/v1/merchants/most_revenue?quantity=x   |Returns the merchants with the most revenue where x = limit sent
| Merchant Most Items   | `GET`/api/v1/merchants/most_items?quantity=x     |Returns the merchants who has sold the most items where x = limit sent
| Revenue By Date       | `GET`/api/v1/revenue?start=x&end=x               |Returns the total revenue earned between a date range where x = date
| Merchant Revenue      | `GET`/api/v1/merchants/:id/revenue               |Returns the revenue earned from a single merchant
