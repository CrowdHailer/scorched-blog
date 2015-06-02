Sequel.migration do
  up do
    create_table(:posts) do
      primary_key :id, :type => :varchar, :auto_increment => false, :unique => true
      String :email, :null => false, :unique => true
      String :title
      String :body
      Date :published_date
      TrueClass :published, :default => false
      # publication_date
    end
  end

  down do
    drop_table(:posts)
  end
end
