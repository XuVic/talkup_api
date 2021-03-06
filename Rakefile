require 'rake/testtask' 

desc 'Run all the tests'
Rake::TestTask.new(:spec) do |t|
  t.pattern = 'specs/*_spec.rb'
  t.warning = false
end

task :console do
    sh 'pry -r ./specs/test_load_all'
end


namespace :newkey do
    desc 'Create sample cryptographic key for database'
    task :db do
        require './lib/secure_db.rb'
        puts "DB_KEY: #{SecureDB.generate_key}"
    end
end


namespace :config do
    require_relative './config/environments.rb'

    app = TalkUp::Api
    task :env_var do
        puts "env: #{app.environment}"
        puts "db_filename: #{app.config.DB_FILENAME}"
    end
end

namespace :db do
    require 'sequel'

    require_relative './config/environments.rb'

    Sequel.extension :migration
    app = TalkUp::Api

    desc 'Run Migration'
    task :migrate do 
        puts "Migration #{app.environment} database to lastest"
        Sequel::Migrator.run(app.DB, 'infrastructure/database/migrations')
    end

    desc "Prints current schema version"
    task :version do    
        version = if app.DB.tables.include?(:schema_info)
        app.DB[:schema_info].first[:version]
        end || 0
        puts "Schema Version: #{version}"
    end

    desc 'Drop all table'
    task :delete do
        require_relative './config/environments.rb'

        app.DB[:issues].delete
        app.DB[:comments].delete 
    end

    desc 'Reset Database'
    task reset: [:delete, :migrate]
    
    desc 'Delete dev or test database file'
    task :wipe do
        if app.environment == :production
            puts 'Cannot wipe production database!'
            return
        end

        FileUtils.rm(app.config.DB_FILENAME)
        puts "Deleted #{app.config.DB_FILENAME}"
    end
end