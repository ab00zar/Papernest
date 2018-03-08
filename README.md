# README

This is a simple Rails 5 api app to check the coverage of French mobile operators based on the given address.

Some points to mention:

*  I deployed it on Heroku here: http://papernest.herokuapp.com 

* You can try GET ../closest/your address... which returns one result for each operator based on the closest location registered in the database (csv file) from the searched address.

* You can also try GET ../all/your address ... that returns all the results within 10 KM around the searched address.

* I developed a function to convert Lambert 93 to GPS coordinates as the input.csv file includes Lambert93 locations.

* It is deployed on Heroku free plan and as the data inserted to the database exceeded the maximum allowed number of rows, Heroku might remove some data in the near future which affects my app and its results.

* You can play with it using HTTPie (https://httpie.org)

* Any feedbak or comment is appreciated. 
