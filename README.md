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

post has
title
date
body markdown
email
published
