require 'json'

module KitchenToolkit
  class Server

    def initialize(suite_name, opts = {})
      # These params are mandatories
      @suite_name      = suite_name
      @minion_id       = opts.fetch(:minion_id)
      @kitchen_profile = opts.fetch(:profile)

      # These params are optional
      @dry_run         = opts[:dry_run]
      @salt_repository = opts[:salt_repository]
    end


    def prepare
      destroy &&
      create  &&
      converge
    end


    def create
      kitchen_command('create', @suite_name)
    end


    def destroy
      kitchen_command('destroy', @suite_name)
    end


    def converge
      kitchen_command('converge', @suite_name)
    end


    def package
      kitchen_command('package', @suite_name)
    end


    def test
      dump &&
      verify
    end


    def dump
      file = "tmp/#{@minion_id}.yml"
      if dry_run?
        render_command(fetch_pillars_command)
      else
        data = fetch_pillars
        new_data = { 'pillar' => data['local'] }
        File.delete(file) if File.exist?(file)
        write_file(file, new_data.to_yaml)
      end
    end


    def verify
      kitchen_command('verify', @suite_name)
    end


    def login
      cmd = build_kitchen_command('login', @suite_name)
      if dry_run?
        render_command(cmd)
      else
        exec(cmd)
      end
    end


    def dry_run?
      @dry_run == true
    end


    def fetch_pillars_command
      build_kitchen_command('exec', @suite_name,
        "-c 'sudo salt-call --local --id #{@minion_id} --config /tmp/kitchen/etc/salt --out json --log-level quiet pillar.items'",
        '|', 'tail', '-n', '+2'
      )
    end


    private


    def kitchen_command(*args)
      cmd = build_kitchen_command(*args)
      if dry_run?
        render_command(cmd)
      else
        system(cmd)
      end
    end


    def build_kitchen_command(*args)
      "#{env_var} kitchen #{args.join(' ')}"
    end


    def env_var
      vars = ["KITCHEN_YAML='#{@kitchen_profile.file}'"]
      if salt_bootstrap_install?
        vars << "SALT_INSTALL='bootstrap'"
        vars << "SALT_BOOTSTRAP_OPTIONS='#{salt_bootstrap_options}'"
      end
      vars.join(' ')
    end


    def fetch_pillars
      data = %x[#{fetch_pillars_command}]
      JSON.load(data)
    end


    def write_file(file, data)
      File.open(file, 'w') do |f|
        f.write data
      end
    end


    def render_command(cmd)
      puts "Will run the command :".green
      puts ''
      puts cmd
      puts ''
      true
    end


    def salt_bootstrap_install?
      !@salt_repository.nil?
    end


    def salt_bootstrap_options
      "-g #{salt_repository} git #{salt_branch}"
    end


    def salt_repository
      @salt_repository ||= @salt_repository.split('#')[0]
    end


    def salt_branch
      @salt_branch ||= (@salt_repository.split('#')[1] || 'master')
    end

  end
end
