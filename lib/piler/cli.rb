require 'slop'

module Piler
  class CLI
    def initialize
      @options = {}
    end

    def run(args = ARGV)
      setup(args)
      if help?
        puts help
      else
        @mover.move
      end
    end

    def setup(args)
      @options = parse_options(args)
      if %i(repository from to).all? { |key| options[key] }
        @mover = Mover.new(options[:repository], options[:from].to_i, options[:to].to_i)
      else
        puts help
        exit 1
      end
    end

    def parse_options(args)
      Slop.parse!(args) do |o|
        o.banner 'Usage: piler [options]'

        o.on('-h', '--help')
        o.on('-r', '--repository=', 'owner/repo')
        o.on('-f', '--from=', 'Source GitHub Project number')
        o.on('-t', '--to=', 'Destination GitHub Project number')
      end
    end

    attr_reader :options
    alias_method :help, :options

    def help?
      @options[:help]
    end
  end
end
