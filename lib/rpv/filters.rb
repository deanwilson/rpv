require 'rpv/filter'

module Rpv
  # Class for managing the filters that can be applied to the processes
  class Filters
    attr_accessor :filters, :present

    def initialize(allowed_directory, rolesfile = '/var/lib/puppet/classes.txt')
      raise IOError, "#{allowed_directory} doesn't exist" unless File.exist? allowed_directory
      raise IOError, "#{rolesfile} doesn't exist"         unless File.exist? rolesfile

      @allowed_directory = allowed_directory
      @roles_file = rolesfile
      @roles = roles
      @filters = []

      role_filters
      load_filters
    end

    def roles
      # these are the roles this machine fulfills - one to a line
      IO.read(@roles_file).split.sort.uniq
    end

    def role_filters(roles = self.roles, files = nil)
      files ||= Dir["#{@allowed_directory}/*"]
      files.collect! { |f| File.basename f }

      @present = files & roles
    end

    def load_filters
      @present.each do |file|
        path = "#{@allowed_directory}/#{file}"

        File.open(path).each do |line|
          @filters << Rpv::Filter.new(line)
        end
      end
    end

    def count
      @filters.length
    end

    def matched
      @filters.reject { |filter| filter.matched.empty? }
    end

    def unmatched
      @filters.select { |filter| filter.matched.empty? }
    end
  end
end
