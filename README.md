# pybaseball-api

# Introduction

This project is a Vagrantfile that uses Chef to create an API that delivers information relating to baseball.  

The Chef cookbook will create and load a database with baseball data then start the Flask API that
delivers the data over REST.  

This project gave me a chance to learn some Chef and Python.  I also picked up some Linux admin knowledge.

Going forward, I would like to add API integration tests using something like behave or Cucumber to actually test the API.  Then, possibly create
a front-end tool to query the API.

The Python API is a work in progress.  It only serves up individual player statistics.  It
is not currently documented.

# Instructions

Clone the repository then enter "vagrant up".  You will then have the API available at http://localhost:9090/api.
A sample query is http://localhost:9090/api/v1/players?last_name=Aaron

# TODO
* Integration tests
* Unit tests for Python
* API Documentation
* API Extension
