# NewsFilterApp

Take a look at presentation http://slides.com/dieterpisarewski/newsfilter

## Installation

### Ruby
Newsfilter app requires ruby 2.1.1. So you have to install it.

### Postgres

    # OS X(Homebrew) installation
    brew install postgresql
    
    # Debian installation
    apt-get install postgresql postgresql-client
    
### Native extensions
Some ruby gems require C/C++ compiler or native libraries. 
Please install a C/C++ compiler for your operating system. 
To install native extensions for gems please refer to their documentation for installation instructions.

* https://github.com/taf2/curb
* http://nokogiri.org/tutorials/installing_nokogiri.html

### Rubygems

    # run bundler to install all required gems
    bundle

### Database

    # create a database.yml
    cp config/database.example.yml config/database.yml

    # start postgres
    postgres -D /usr/local/var/postgres

    # create all needed databases
    rake db:create:all

    # create needed extensions (uuid-ossp)
    psql -c 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"' news_filter_app_development

    # run all migrations
    rake db:migrate

    # kill postgres with STRG+C
    
## Usage

### Create a user

    rails r "User.create(email: 'demo@example.com', password: 'your_password', password_confirmation: 'your_password')"

### Start foreman

    # create your Procfile.local
    cp Procfile.local.example Procfile.local

    # run all needed services (stop the foreman with STRG+C)
    foreman start -f Procfile.local
    
### Application

    # open the application in the browser
    open http://localhost:3000

    # run all specs
    rake

### Import articles
Run rake task periodically to fetch new articles from feeds.
 
    # run rake task
    rake newsfilter:rss_article:create