class ShowPost < AllSystems::Interactor

  def initialize(context, id)
    @context = context
    @id = id
  end

  def outcomes
    [:found, :not_found]
  end

  attr_reader :context, :id

  def go!
    report_found Posts.fetch(id) { |id| report_not_found id }
  end
end
