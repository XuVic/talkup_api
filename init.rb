folders = %w[domain config lib application infrastructure]

folders.each do |folder|
    require_relative "#{folder}/init.rb"
end