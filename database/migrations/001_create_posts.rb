Sequel.migration do
  up do
    create_table(:posts) do
      # primary_key :id, :type => :varchar, :auto_increment => false, :unique => true
      # String :email, :null => false, :unique => true
      # String :password, :null => false
      TrueClass :published, :default => false

    end
  end

  down do
    drop_table(:users)
  end
end
