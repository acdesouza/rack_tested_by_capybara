= Testing Rack app using Capybara

Who to create a Rack app and test it using a headless Capybara.

== Description

This application shows a welcome page and change its title, throught JavaScript.

Download project:

```bash
git clone
cd rack_test_by_capybara
bundle install
```

To see it working:

```bash
rackup # See it at http://localhost:9292
```

To see the tests running:

```bash
rake test # Or, just rake, since test is the default task.
```

== Requirements

OSX

```bash
$ brew install phantomjs
```

== Sources

 - [Rack app HowTo]("https://github.com/rack/rack/wiki/(tutorial)-rackup-howto")
 - [Rack server pages](https://github.com/migrs/rack-server-pages)
 - [Capybara](https://github.com/jnicklas/capybara)
 - [Poltergeist](https://github.com/teampoltergeist/poltergeist)

== Todo

 - [x] Config a rake task to test a Rack app
 - [x] Create firts test for 200 with a h1 saying "It works!"
 - [x] Create a rack app which answer 200, "It works!"
 - [x] Create test for 404 when acessing any other path
 - [x] Change RackApp to answer 404 when not accessing "/"
 - [x] Create a test to check greeting message on "/welcome"
 - [x] Add Rack server pages to show pages based on url
 - [x] Create a test to check JavaScript's greeting message, using Poltergeist
 - [ ] Add JavaScript greeting message
