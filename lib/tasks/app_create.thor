require 'thor/group'
require 'active_support'
require 'active_support/core_ext' # para usar o camelcase

module App

  class Create < Thor::Group

    include Thor::Actions

    desc <<-TXT
Cria uma nova aplicação a partir do modelo.
    TXT

    argument :app_name, type: :string, desc: 'nome da aplicação (ex: my_app)'

    class_option :cable,
                  type: :boolean,
                  default: true,
                  desc: 'Utilizar ActionCable'

    class_option :sidekiq,
                  type: :boolean,
                  default: true,
                  desc: 'Utilizar Sidekiq'

    def self.source_root
      File.expand_path("../..", File.dirname(__FILE__))
    end

    def copy_files
      say "Copiando modelo..."
      base_dir = File.expand_path("../../..", File.dirname(__FILE__))
      self.destination_root = "#{base_dir}/#{app_name}"

      regexp_arquivos_ignorar = %r{
        /node_modules/|
        /\.git/|
        /tmp/|
        /log/|
        database\.yml\z|
        app_create\.thor\z|
        /spec/modelo/
      }x

      directory '.',
                mode: :preserve,
                exclude_pattern: regexp_arquivos_ignorar
    end


    def replace_app_name
      say "Modificando arquivos..."

      gsub_file 'package.json', 'modelo51', app_name

      gsub_file 'app/views/layouts/application.html.erb', 'Modelo51', app_name
      gsub_file 'app/views/layouts/_navbar.html.erb', 'MODELO52', app_name

      gsub_file 'config/application.rb', 'Modelo', app_name.camelcase
      gsub_file 'config/cable.yml', 'modelo51_production', "#{app_name}_production"
      gsub_file 'config/environments/production.rb', 'modelo51_#{Rails.env}', "#{app_name}_\#{Rails.env}"
      gsub_file 'config/initializers/sidekiq.rb', '_MODELO', app_name

      gsub_file 'lib/tasks/deploy.rake', 'sidekiq-MODELO', "sidekiq-#{app_name}"
    end


    def remove_action_cable
      return if options[:cable]

      say 'Disabling Action Cable'

      comment_lines 'config/application.rb', 'action_cable'
      remove_file 'app/assets/javascripts/cable.js'
      remove_dir 'app/assets/javascripts/channels'
      remove_dir 'app/channels'
      remove_file 'config/cable.yml'
    end


    def remove_sidekiq
      return if options[:sidekiq]

      say 'Disabling Sidekiq'

      comment_lines 'Gemfile', "gem 'sidekiq'"
      comment_lines 'Gemfile', "gem 'redis-namespace'"

      comment_lines 'config/application.rb', 'active_job'
      comment_lines 'config/environments/production.rb', 'queue_adapter'
      comment_lines 'config/initializers/sidekiq.rb', /.*/

      comment_lines 'lib/tasks/deploy.rake', 'idekiq'
    end


    def remove_redis
      return if options[:sidekiq] || options[:cable]

      comment_lines 'Gemfile', "gem 'redis'"
    end


    def create_config_files
      say "Criando arquivos de configuracao..."

      copy_file 'config/database.yml.example', "config/database.yml"
      copy_file 'config/app_config.yml.example', "config/app_config.yml"
      copy_file 'config/environments/production.rb', 'config/environments/staging.rb'
    end


    def get_packages
      say "Running bundle / yarn"

      inside "." do
        run "bundle"
        run "yarn"
      end
    end


    def git_init
      say "Creating git repository"

      inside "." do
        run "git init"
        run "git add ."
        run "git commit -m 'Aplicacao gerada a partir do modelo'"
      end
    end


    def final_message
      say ''
      say 'Aplicação gerada com sucesso!!', :green
      say '  -> ' + destination_root
      say ''
      say 'Para criar usuario no banco:', :blue
      say "  rake db:user:create[#{app_name}_dev_username]", :blue
      say '  rake db:user:grants', :blue
    end


  end

end
