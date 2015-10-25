# OmniAuth::Medium

An OmniAuth strategy for authenticating with the [Medium API](https://medium.com/developers/welcome-to-the-medium-api-3418f956552).

Before you can use this, you need to obtain API credentials from Medium.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-medium'
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install omniauth-medium
```

## Usage

### Rails

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :medium, ENV["MEDIUM_CLIENT_ID"], ENV["MEDIUM_CLIENT_SECRET"]
end
```

### Rack

```ruby
use OmniAuth::Builder do
  provider :medium, ENV["MEDIUM_CLIENT_ID"], ENV["MEDIUM_CLIENT_SECRET"]
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/penman/omniauth-medium. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

