# booking system

### Ruby version: 2.6.5


Project written almost in pure Ruby code. Only three gems were used for:
- `sinatra` for API
- `rspec` for testing the app
- `rack-test` for testing API


To run tests, run:
```
bundle exec rspec spec
```


To start the app, run:
```
ruby application.rb
```


To perform API request from a console, run i.e.:
```
curl -d "name=John&amount=3" -X POST http://localhost:4567/bookings
```


#### Design decision:
- Since the app does not have a database, no intermediary objects are needed, two classes `Booking` and `Airplane` are enough
- `Airplane` basically does not do a lot, we only need to it to know what will be the seats matrix
- `Booking` performs all the logic in term of allocating passenges
- Allocating passenges happens basically in three steps: 
    1. Comfortable - so they enjoy the trip and sit together
    2. Aisle - so passenges still can sit not far awat from each other
    3. Random - filling the rest of the empty seats
- `#book` method reserves a seat and returns the result
- `#show` method shows all reservations _(decided to implement it this way, because instructions were not clear 100% about that method)_
- Project written using TDD methodology
- All the Coding Challenge Requirements are met
- We should be able to use any kind of airplanes with one aisle
- We can perform as many reservations as possible by the time an airplane is full


#### Possible enhancements:
- Add support for big airplanes (more than one aisle)
- Consider weight destribution (allocate passengers also from the back of the air plane, not only from the front)
