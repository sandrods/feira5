require 'yaml'
require 'erb'
require 'ostruct'

class Configs < Hashr

  # Configs.new(:google_analytics)
  def Configs.from_file(config_file_base_name)
    confs = YAML.load(ERB.new(File.read(Rails.root.join("config", "#{config_file_base_name}.yml"))).result)
    env = confs[Rails.env] || confs['default']
    new(env)
  end

end
