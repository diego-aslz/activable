# Activable

This gem allows a model to be activated or deactivated, saving informations like
'activated_at', 'deactivated_at', 'activated_by' and 'deactivated_by'.

**THIS GEM IS NOT READY YET**

## Installation

Add this line to your application's Gemfile:

    gem 'activable', git: 'git://github.com/nerde/activable.git'

And then execute:

    $ bundle

## Usage

Add to your model:

```ruby
class User < ActiveRecord::Base
  include Activable
  # ...
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
