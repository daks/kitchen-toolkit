require 'thor'
require 'kitchen-toolkit/kitchen_wrapper'

module KitchenToolkit
  class CLI < Thor

    def self.render_available_profiles_and_suites
      str = ''
      KitchenToolkit.kitchen_profiles.each do |profile|
        str << "* #{profile} SUITE_NAME: (#{profile.suites.map(&:to_s).join(' | ')}) \n\n"
      end
      str
    end

    def self.render_available_profiles
      KitchenToolkit.kitchen_profiles.map { |s| "* #{s}" }.join("\n\n")
    end

    class_option :dry_run, type: :boolean, default: false


    #########
    # Login #
    #########

    desc "login KITCHEN_PROFILE SUITE_NAME", "Log into the virtual machine of SUITE_NAME defined in KITCHEN_PROFILE"

    long_desc <<-LONGDESC
      `ci-tool login KITCHEN_PROFILE SUITE_NAME` will log you into the virtual machine of the test suite.

      KITCHEN_PROFILE can be either :

      #{render_available_profiles_and_suites}
    LONGDESC

    def login(profile, suite)
      do_basic_checks_and_call_wrapper(profile, suite, options, :login)
    end


    ###########
    # Prepare #
    ###########

    desc "prepare KITCHEN_PROFILE SUITE_NAME", "Prepare the virtual machine for SUITE_NAME defined in KITCHEN_PROFILE"

    long_desc <<-LONGDESC
      `ci-tool prepare KITCHEN_PROFILE SUITE_NAME` will prepare a new virtual machine to run the test suite.

      It wil run Kitchen actions in this order : destroy > create > converge.

      At the end, a new virtual machine is attended to be working and salted.

      KITCHEN_PROFILE can be either :

      #{render_available_profiles_and_suites}
    LONGDESC

    option :salt_repository, type: :string, desc: 'The Salt repository to use (ex: https://github.com/saltstack/salt.git#foo-bar)'

    def prepare(profile, suite)
      do_basic_checks_and_call_wrapper(profile, suite, options, :prepare)
    end


    ###########
    # Create #
    ###########

    desc "create KITCHEN_PROFILE SUITE_NAME", "Create the virtual machine for SUITE_NAME defined in KITCHEN_PROFILE"

    long_desc <<-LONGDESC
      `ci-tool create KITCHEN_PROFILE SUITE_NAME` will create the new virtual machine for the test suite.

      KITCHEN_PROFILE can be either :

      #{render_available_profiles_and_suites}
    LONGDESC

    option :salt_repository, type: :string, desc: 'The Salt repository to use (ex: https://github.com/saltstack/salt.git#foo-bar)'

    def create(profile, suite)
      do_basic_checks_and_call_wrapper(profile, suite, options, :create)
    end


    ###########
    # Destroy #
    ###########

    desc "destroy KITCHEN_PROFILE SUITE_NAME", "Destroy the virtual machine of SUITE_NAME defined in KITCHEN_PROFILE"

    long_desc <<-LONGDESC
      `ci-tool destroy KITCHEN_PROFILE SUITE_NAME` will destroy the virtual machine of the test suite.

      KITCHEN_PROFILE can be either :

      #{render_available_profiles_and_suites}
    LONGDESC

    def destroy(profile, suite)
      do_basic_checks_and_call_wrapper(profile, suite, options, :destroy)
    end


    ############
    # Converge #
    ############

    desc "converge KITCHEN_PROFILE SUITE_NAME", "Run Salt on the virtual machine of SUITE_NAME defined in KITCHEN_PROFILE"

    long_desc <<-LONGDESC
      `ci-tool converge KITCHEN_PROFILE SUITE_NAME` will run Salt on the virtual machine.

      KITCHEN_PROFILE can be either :

      #{render_available_profiles_and_suites}
    LONGDESC

    option :salt_repository, type: :string, desc: 'The Salt repository to use (ex: https://github.com/saltstack/salt.git#foo-bar)'

    def converge(profile, suite)
      do_basic_checks_and_call_wrapper(profile, suite, options, :converge)
    end


    ########
    # Test #
    ########

    desc "test KITCHEN_PROFILE SUITE_NAME", "Dump pillars of the virtual machine of SUITE_NAME defined in KITCHEN_PROFILE then run Kitchen tests"

    long_desc <<-LONGDESC
      `ci-tool test KITCHEN_PROFILE SUITE_NAME` will dump pillars of the virtual machine and then will run the Kitchen tests.

      KITCHEN_PROFILE can be either :

      #{render_available_profiles_and_suites}
    LONGDESC

    def test(profile, suite)
      do_basic_checks_and_call_wrapper(profile, suite, options, :test)
    end


    ########
    # Dump #
    ########

    desc "dump KITCHEN_PROFILE SUITE_NAME", "Dump pillars of the virtual machine of SUITE_NAME defined in KITCHEN_PROFILE"

    long_desc <<-LONGDESC
      `ci-tool dump KITCHEN_PROFILE SUITE_NAME` will dump pillars of the virtual machine.

      KITCHEN_PROFILE can be either :

      #{render_available_profiles_and_suites}
    LONGDESC


    def dump(profile, suite)
      do_basic_checks_and_call_wrapper(profile, suite, options, :dump)
    end


    ##########
    # Verify #
    ##########

    desc "verify KITCHEN_PROFILE SUITE_NAME", "Run Kitchen tests on the virtual machine of SUITE_NAME defined in KITCHEN_PROFILE"

    long_desc <<-LONGDESC
      `ci-tool verify KITCHEN_PROFILE SUITE_NAME` will run Kitchen tests on the virtual machine.

      KITCHEN_PROFILE can be either :

      #{render_available_profiles_and_suites}
    LONGDESC

    def verify(profile, suite)
      do_basic_checks_and_call_wrapper(profile, suite, options, :verify)
    end


    ###########
    # Package #
    ###########

    desc "package KITCHEN_PROFILE SUITE_NAME", "Run Kitchen package on the virtual machine of SUITE_NAME defined in KITCHEN_PROFILE"

    long_desc <<-LONGDESC
      `ci-tool package KITCHEN_PROFILE SUITE_NAME` will run Kitchen package on the virtual machine. It will create a new Vagrant box ready for upload.

      KITCHEN_PROFILE can be either :

      #{render_available_profiles_and_suites}
    LONGDESC

    def package(profile, suite)
      do_basic_checks_and_call_wrapper(profile, suite, options, :package)
    end


    ########
    # List #
    ########

    desc "list KITCHEN_PROFILE", "List instances of virtual machines of KITCHEN_PROFILE"

    long_desc <<-LONGDESC
      `ci-tool list KITCHEN_PROFILE` will run Kitchen list for the KITCHEN_PROFILE.

      KITCHEN_PROFILE can be either :

      #{render_available_profiles}
    LONGDESC

    def list(profile)
      profile = check_if_profile_exist(profile)
      check_return KitchenWrapper.list(profile)
    end


    private


    def do_basic_checks_and_call_wrapper(profile, suite, options, method)
      profile = check_if_profile_exist(profile)
      suite   = check_if_suite_exist(profile, suite)
      opts    = build_options_for_suite(profile, suite)
      opts    = opts.merge(options)
      check_return KitchenWrapper.send(method, suite, opts)
    end


    def check_if_profile_exist(profile)
      exist = KitchenToolkit.kitchen_profiles.detect { |k| k.name == profile }

      unless exist
        puts "Kitchen profile doesn't exist : #{profile}, exiting..."
        exit 1
      else
        exist
      end
    end


    def check_if_suite_exist(profile, suite)
      exist = profile.suites.detect { |s| s.name == suite }

      unless exist
        puts "Kitchen suite doesn't exist : #{suite}, exiting..."
        exit 1
      else
        exist
      end
    end


    def build_options_for_suite(profile, suite)
      minion_id = suite.attrs.dig(:provisioner).dig(:salt_minion_id)
      { profile: profile, minion_id: minion_id }
    end


    def check_return(ret)
      ret ? 0 : 1
    end

  end
end
