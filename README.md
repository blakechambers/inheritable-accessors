# InheritableAccessors

**Development status: Currently this is under active development, and should not be used until this section is removed from the readme.**

Easily and consistently inherit attributes and configurations.  This is particularly designed to work well with Rspec, which creates new inherited classes during each context.  More examples of usage coming soon.

## Planned features

- inheritable\_hash
  - [x] support addition
  - [ ] support delete/clear/reject
- inheritable\_set
  - [ ] support addition
  - [ ] support deletion
- [x] concerns that create an inheritable\_hash\_accessor will setup inheritance from class to class automatically
- [x] instance inherits from class hash

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'inheritable_accessors'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install inheritable_accessors

## Usage

see specs.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/inheritable-accessors/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
