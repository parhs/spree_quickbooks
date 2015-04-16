module SpreeQuickbooks
  class Engine < Rails::Engine
    require 'spree/core'
    require 'quickbooks-ruby'
    isolate_namespace Spree
    engine_name 'spree_quickbooks'

    initializer "spree_quickbooks.preferences", before: :load_config_initializers do |app|
      SpreeQuickbooks::Config = Spree::QuickbooksConfiguration.new
    end
    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
