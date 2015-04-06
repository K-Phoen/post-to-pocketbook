Post-to-PocketBook
==================

Little pet-project used to convert a URL (typically linking to a blog post) to
something readable by my PocketBook.

It uses the Send-to-PocketBook feature to turn a URL into a PDF and send it to
your account.

## Installation

### System libraries

libfontconfig is needed:

```sh
sudo apt-get install libfontconfig1
```

redis is needed by Sidekiq:

```sh
sudo apt-get install redis-server
```

### Development environment

Define the application' secrets:

```sh
cp config/secrets.yml{.dist,}
```

Setup the database:

```sh
rake db:schema:load
rake db:migrate
```

Launch the server:

```sh
rails server -b 0.0.0.0
```

Launch Sidekiq

```sh
bundle exec sidekiq
```

## License

This library is under the [MIT](LICENSE) license.
