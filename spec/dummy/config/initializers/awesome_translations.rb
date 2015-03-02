if Rails.env.development?
  AwesomeTranslations.config.paths_to_translate = [File.realpath("#{Rails.root}/../..")]
end
