# Coding Bootcamp Review App

> Fanatical about coding bootcamps for Software Engineering, Data Science, Cybersecurity and User Experience Design? Want to know which the best schools out there are or maybe submit your own reviews if you previously attended a coding bootcamp?

Welcome to the *Coding Bootcamp Review App* - your go-to app for all things concerned with coding bootcamp schools, courses and reviews!

## Getting started

### Prerequisites

1. Open a new Terminal window and check whether Ruby is installed on your computer by running the following command:

```
ruby -v
```

2. If Ruby is not installed, then go through the Ruby installation instructions <a href="https://www.ruby-lang.org/en/documentation/installation/" target="_blank">here</a>

### Installation

1. Click the *Clone or download* button on this GitHub page and download the app as a Zip file.

2. Extract the contents of the Zip file to a location of your choice on your computer.

3. From Terminal, navigate to the location where you extracted the Zip file. Alternatively, from that location, right-click the extracted folder and select the option to open a new Terminal window.

4. Run the following command to ensure all the necessary Ruby Gemfiles are loaded with the application. 

```
bundle install
```

The application uses the Gems: *sinatra-activerecord, activerecord, sqlite3, pry, rake, csv*

5. Run the following commands to generate the database of the application and to load the necessary data

```
rake db:migrate
rake db:seed
```

### Running the app

*Coding Bootcamp Review App* is a command-line interface (CLI) application and as such must be run from a Terminal window. 

1. Run the command below to start the app in Terminal.

```
ruby bin/run.rb
```

2. Enter your username to sign in

```
Hello, what is your username?
username1
```

3. You will then be taken to the main menu where you can select options to read, submit or manage reviews

```
Please select from the following:
- read : browse all reviews
- submit: submit a review
- manage : update or delete your reviews
- exit : end your session
```

## Release notes for Coding Bootcamp Review App v1.0

### Main features

* Sign in using your unique username.
* Read reviews for specific schools, order reviews by highest, lowest and top ratings, and search reviews by keyword.
* Submit reviews for schools and courses.
* Manage your current reviews by updating them with new content or deleting them if you choose to.

## Authors
* <a href="https://github.com/geewey" target="_blank">Gee-Wey Yue</a>
* <a href="https://github.com/tishchungoora" target="_blank">Tish Chungoora</a>