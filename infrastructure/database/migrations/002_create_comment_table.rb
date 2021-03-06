require 'sequel'

Sequel.migration do
    change do 
        create_table(:comments) do
            uuid :id, primary_key: true
            foreign_key :issue_key, table: :issues

            String :content, null: false

            DateTime :created_at
            DateTime :updated_at
            
        end
    end
end