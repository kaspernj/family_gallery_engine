namespace :family_gallery do
  task "dbreset" => ["db:drop", "db:create", "db:migrate", "plugin_migrator:migrate"]
end
