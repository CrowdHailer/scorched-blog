class IndexPage
  class PostPresenter
    def initialize(post)
      @post = post
    end

    def title
      @post.title
    end
  end

  def initialize(posts)
    @posts = posts
  end

  def title
    'All Posts | Scorched Blog'
  end

  def page_number
    @posts.current_page
  end

  def each_post
    @posts.each do |post|
      yield PostPresenter.new post
    end
  end
end
