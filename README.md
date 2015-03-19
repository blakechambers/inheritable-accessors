# InheritableAccessors [![Build Status](https://travis-ci.org/blakechambers/inheritable-accessors.svg)](https://travis-ci.org/blakechambers/inheritable-accessors)

Easily and consistently inherit attributes and configurations.  This is particularly designed to work well with Rspec, which creates new inherited classes during each context.  More examples of usage coming soon.

## Planned features

- inheritable\_hash
  - [x] support addition
  - [ ] support delete/clear/reject
- inheritable\_set
  - [x] support addition
  - [ ] support deletion

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

see [specs](https://github.com/blakechambers/inheritable-accessors/blob/master/spec/inheritable_accessors_spec.rb).

## Contributing

1. Fork it ( https://github.com/blakechambers/inheritable-accessors/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
