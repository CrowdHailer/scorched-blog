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
