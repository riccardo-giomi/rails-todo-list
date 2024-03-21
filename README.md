# Rails TODO list

A Ruby on Rails 7.1 application that allows to create, change, delete and
reorder TODO notes.

This is a simple exercise in Hotwire and StimilusJS, starting from a "normal"
Rails application created with my
[quickstart template](https://github.com/riccardo-giomi/rails-7.1-quickstart).

Drag-and-drop re-ordering is accomplished with:

- [Positioning](https://github.com/brendon/positioning)
- [SortableJS](https://github.com/SortableJS/Sortable) 
- [RequestJS for Rails](https://github.com/rails/requestjs-rails)

## Prerequisites

These are the Ruby and Bundler versions the application was bundled with, more
recent versions should also work:

- Ruby 3.2.2
- Bundler 2.4.22

You will also need *[SQLite3](https://www.sqlite.org/)* and *libvips* (see
[here](https://github.com/libvips/ruby-vips) for more information).

## Installation

The following commands will download the app's code, download or update the
required Ruby Gems, and prepare a database for the application.

``` bash
git clone https://github.com/riccardo-giomi/rails-todo-list
cd rails-todo-list
bundle
bin/rails db:setup
```

Five example Todos are available as seeds:

``` bash
bin/rails db:seed
```

The specs are still incomplete, missing examples for sorting and general Hotwire
behaviour, but what is available can be run with:

``` bash
bundle exec rspec
```

The server can be started with:
``` bash
bin/dev
```

The application will be available to a browser at `http://localhost:3000`.
