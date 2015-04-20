# InheritableAccessors [![Build Status](https://travis-ci.org/blakechambers/inheritable-accessors.svg)](https://travis-ci.org/blakechambers/inheritable-accessors)

Easily and consistently inherit attributes and configurations.  This is particularly designed to work well with Rspec, which creates new inherited classes during each context.

## Usage

Inheritable accessors comes with 3 inheritable components that can be used:
an iheritable hash, set, and option accessor.

### InheritableHashAccessor

```ruby
class Parent
  include InheritableAccessors::InheritableHashAccessor

  inheritable_hash_accessor :options

  options[:a] = 1
end

class Child < Parent
  options[:b] = 2
end

item = Child.new

# deleted items do not affect parent items
item.delete(:a)
item.options[:c] = 3

Parent.options.to_hash
#=> {a: 1})
Child.options.to_hash
#=> {a: 1, b: 1})
item.options.to_hash
#=> {b: 2, c: 3})
```

### InheritableOptionAccessor

```ruby
class MyRequest
  include InheritableAccessors::InheritableHashAccessor
  include InheritableAccessors::InheritableOptionAccessor

  inheritable_hash_accessor   :request_opts
  inheritable_option_accessor :path, :action, :params, for: :request_opts

  # passing an argument to the accessor will "set" that value.
  action "GET"

  action # => "GET"

  # passing a block will use the value of the block, but *only* when it is
  # called.  Block values will be memoized after the first run.
  path { secret_path }

  protected

  def secret_path
    "/secret_path"
  end

end


request = MyRequest.new
request.path # => "/secret_path"
request.path "/other_path"
request.path # => "/other_path"


```

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
