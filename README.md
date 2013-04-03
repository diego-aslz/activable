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

Configure the models you want to be "activable":

    $ rails g activable Product
    $ rails g activable Category
    $ rails g activable User
    $ rake db:migrate

Your models will look like this:

```ruby
class Product < ActiveRecord::Base
  is_activable
  # ...
end
```

Optionally, you can customize each model to have a differente configuration from
the on in the initializer file:

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

## Testing the gem

    rspec spec

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
