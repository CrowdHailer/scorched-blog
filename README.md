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

## Notes
#### Delivery separation
The interactors act as a hard boundary between the domain logic and the delivery mechanism. The load sequence requires the application which boots the Model. It is possible to load the domain without loading the delivery mechanism.
```
$ irb -r ./config/boot
```
It is possible to remove the application and tests and still have a working system.
```
$ rm -rf app/ test/app
```

#### Example update action in the posts controller
```rb
def update(id)
  form = UpdatePost::Form.new request.POST['post']

  interactor = UpdatePost.new self, id, form

  interactor.success do |post|

  end

  interactor.not_found do |id|

  end

  interactor.invalid_params do |post, form|

  end
end
```

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
