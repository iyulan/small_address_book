Small Address Book
----------------

#### Install dependencies
```
$ bundle install
```
#### Database
* Create db config file
```
$ cp config/database.yml.example config/database.yml
```
* Setup
```
$ rake db:create
```
* Initialization
```
$ rake db:migrate
```

#### Run tests
```
$ rspec
```
