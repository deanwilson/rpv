module Rpv
  class Filter
    attr_accessor :filters

    def initialize(line)
      @filters = {}
      @matched = []

      split(line).each do |pair|
        @filters.merge!(extract_pair(pair))
      end
    end

    def split(line)
      delim = ',' # csv will bite us. eventually
      line.split(delim.to_s)
    end

    def extract_pair(pair)
      filter, criteria = pair.split(/\s*=>\s*/)

      # unless fields.include?(filter) # put fields in util class? TODO
      #   raise "Unknown filter option: [#{filter}] in #{file}"
      # end

      filter.strip!
      criteria.strip!

      # rubocop:disable Style/MultipleComparison, Style/IfUnlessModifier
      if filter == 'pid' || filter == 'ppid'
        criteria = criteria.to_i
      end
      # rubocop:enable Style/MultipleComparison, Style/IfUnlessModifier

      { filter => criteria }
    end

    def matched=(match)
      @matched << match
    end

    def matched
      @matched
    end

    def to_s
      "Filter #{@filters.inspect}"
    end
  end
end
