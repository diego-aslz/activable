# Activable

This gem allows a model to be activated or deactivated, saving informations like
'activated_at', 'deactivated_at', 'activated_by' and 'deactivated_by'.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activable', git: 'git://github.com/nerde/activable.git'
```

And then execute:

    $ bundle

## Usage

Create the initializer file:

    $ rails g activable:install

Configure the models you want to be "activable". They need to be created first:

    $ rails g model product description
    $ rails g activable product
    $ rake db:migrate

Your models will look like this:

```ruby
class Product < ActiveRecord::Base
  is_activable
  # ...
end
```

Optionally, you can customize each model to have a different configuration from
that in the initializer file:

```ruby
class Product < ActiveRecord::Base
  is_activable has_responsible: false
  # ...
end

class Category < ActiveRecord::Base
  is_activable responsible: "Admin"
  # ...
end
```

### Working with it

By default, new objects of a "activable" model are active:

```ruby
p = Product.new
p.active? # => true
```

If your model has a responsible, you **must** provide it before saving your object:

```ruby
p = Product.new
p.save # will not work, it will say that activated_by_id is required

# You need to do something like this
p = Product.new
p.activate responsible: current_user
```

The same rule applies when deactivating an object:

```ruby
product.deactivate responsible: current_user
```

You can check whether it is active or not whenever you want by calling the method
`active?`. Another useful informations are stored and you can see them:

```ruby
product.activated_at
product.deactivated_at

# And if it has a responsible:
product.activated_by # if has responsible
product.deactivated_by # if has responsible
```

## Testing the gem

    rspec spec

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
