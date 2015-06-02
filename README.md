Scorched Blog
=============


## TODOs
correct responses on scorched rest
rails response symbols
http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
list posts privatly at /posts
publically at root

Separate view concept from templates

```rb
class RailsContextAdapter
  def initialize(application)
    @application
  end

  def authority
    @application.current_users
  end
end
class usecase
  # the context is an instance of the context adapter
  def initialize(context, *args)
  end
end
```

order by title or by published date

## Form requirements

- Form object should have a :default => option
- Form object should have a :required => true
  - Form object with required and default might make sense if default acts as null object?
- Form object should have a :from => 'display_name' to handle JSON responses
- Form object should not try to coerce empty string or nil unless required
  - Form object should have overwritable conditions on empty
- Form object should encourage nilObject use
- Form needs Standard Boolean, String, Integer, Float, DateTime
- Boolean can be defined. Should have a standard form thingy
- Check out virtus Array and Hash they might need to be included in awesomeness
  - There is no need for and array or hash type if Always defining collections
  - general nesting structure checkout useuful music batch
- there should be a true type that is invalid when false for check terms and conditions
