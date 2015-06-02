class DestroyPost < AllSystems::Interactor

  def initialize(context, id)
    @context = context
    @id = id
  end

  def outcomes
    [:success]
  end

  attr_reader :context, :id

  def go!
    post = Posts.fetch(id) { report_success }
    Posts.remove post
    report_success
  end
end
