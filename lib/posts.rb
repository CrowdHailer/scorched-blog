class Posts < Errol::Repository
  class Inquiry < Errol::Inquiry
    default :admin, false
    default :page, 1
    default :page_size, 15
  end

  class << self
    def record_class
      Post::Record
    end

    def inquiry(requirements)
      Inquiry.new requirements
    end

    def dispatch(record)
      Post.new record
    end

    def receive(entity)
      entity.record
    end
  end

  def dataset
    raw_dataset.order :title
  end
end
