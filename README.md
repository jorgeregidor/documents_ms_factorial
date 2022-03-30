# Document MS factorial #

## USAGE ##

Start by checking out the project from github

```
git clone 
cd documents_ms_factorial
```

**You can either run the application natively, or inside a docker container.**

## USING DOCKER ##

### REQUIREMENTS FOR DOCKER ###

  If You are going to use containers, You will need:

- [Docker](https://www.docker.com/)
- [docker-compose](https://docs.docker.com/compose/)

### EXECUTING ###

To setup the project on docker:

**Build and run project**

```
docker-compose build &&
docker-compose up
```

## NATIVELY ##

### REQUIREMENTS ###

  - **Ruby version:** 2.7.1
  - **Bundler** [How to install](http://bundler.io/)
  - **MongoDB version** 4.2 [How to install](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/)

**Just execute the script file in `bin/setup`**

**or install the dependencies manually:**

### Install global dependencies: ###

    gem install bundler

### Install gems: ###

    bundle install

### Set up the database ###

    Copy env.sample to .env and replace the values accordingly. See the Configuration section below for more information.
    
		* MONGODB_URI=mongodb://localhost:27017/document_ms_factorial_development

### Run application: ###

    bin/rails s

## TEST ##
  Run rspec on docker:

```console
docker-compose -f docker-compose-test.yml build &&
docker-compose -f docker-compose-test.yml run test &&
docker-compose -f docker-compose-test.yml down
```

  Run rspec:

```console
  bin/rspec
```

## DEPLOYMENT ##

## Configuration ##

* MONGODB_URI=mongodb://localhost:27017/document_ms_factorial_development
* MONGODB_URI_TEST=mongodb://localhost:27017/document_ms_factorial_test
