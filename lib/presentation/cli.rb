require 'thor'
require_relative '../presentation'

class Presentation

  class CLI < Thor
    include Thor::Actions
    
    desc "new NAME", "Generate a new presentation"
    def new(name)
      create_file "#{name}/presentation.rb" do
        File.read File.expand_path("../../../examples/presentation.rb", __FILE__)
      end
    end

    desc "start [presentation.rb]", "Start a full screen presentation"
    # method_option %w(theme -t) => 'theme.rb'
    def start(name = nil)
      name ||= 'presentation.rb'
      p = Presentation.new
      p.load_slides_from_file File.expand_path(name)
      # TODO: p.load_theme File.expand_path(options[:theme])
      p.start
    end
  end

end