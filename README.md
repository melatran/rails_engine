# Rails Engine API

This is a solo project for BE 2003 Mod 3. Rails Engine is an E-Commerce Application. It is working in a service-oriented architecture, meaning the front and back ends of this application are separate and communicate via APIs. My job in the backend is to expose the data that powers the site through an API that the front end will consume. [Rails Driver](https://github.com/turingschool-examples/rails_driver) is the front end of the application. It includes a test suite as well as a front end to test your application.It should be noted that in most professional applications, the front end would not be written in Rails. More likely, a pure front end application would use a Javascript framework such as React. However, in order to make this portion of the project more understandable to BEM3 students, it was written in Rails.

## Endpoints

| API Endpoint    | Path                         |Description
| -----------     | ---------------------------- |-------------
| Merchant All    | /api/v1/merchants            |
| Merchant Solo   | /api/v1/merchants/1          |
| Items All       | /api/v1/items                |
| Item Solo       | /api/v1/items/1              |
