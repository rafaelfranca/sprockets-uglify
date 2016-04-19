# Sprockets + [schmooze](https://github.com/Shopify/schmooze) + NodeJS' uglify

All the implementation is at the [`config/initializers/assets.rb`](/config/initializers/assets.rb).

To test it just run:

```
bin/setup
RAILS_ENV=production bin/rake assets:precompile
```
