namespace :ridgepole do
  desc 'Apply schema to database'
  task apply: :environment do
    config_file = 'config/database.yml'
    schema_file = 'Schemafile'
    command = "bundle exec ridgepole --apply --config #{config_file} --env #{Rails.env} --file #{schema_file}"

    puts '=== run ridgepole... ==='
    puts "[Running] #{command}"

    system command
  end
end
