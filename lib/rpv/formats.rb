module Rpv
  class Formats

    # basic human readable summary
    def self.summary( processes, filters, verbose )
      puts <<-eos
        Processes
         * matched #{processes.matched.length} of #{processes.count}
         * unmatched #{processes.unmatched.length} of #{processes.count}

        Filters
         * matched #{filters.matched.length} of #{filters.count}
         * unmatched #{filters.unmatched.length} of #{filters.count}
      eos
    end

    # suitable for use as a nagios check - check processes are known
    def self.nagios_processes( processes, filters, verbose )
      if processes.unmatched.empty?
        puts "OK: all #{processes.count} processes were matched"
        exit 0
      else
        puts "CRITICAL: #{processes.unmatched.length} of #{processes.count} processes are unmatched"
        puts processes.unmatched.join("\n") if verbose
        exit 2
      end
    end

    # suitable for use as a nagios check - check filters are used.
    # any unused filters mean we're missing processes we expect to find
    def self.nagios_filters( processes, filters, verbose )
      if filters.unmatched.empty?
        puts "OK: all #{filters.count} filters were matched"
        exit 0
      else
        puts "CRITICAL: #{filters.unmatched.length} of #{processes.count} filters are unmatched"
        puts filters.unmatched.join("\n") if verbose
        exit 2
      end
    end

    # show unused filters - means we're expecting processes that are not present
    def self.unmatched_filters( processes, filters, verbose )
      filters.unmatched.each do | filter |
        puts filter
      end
    end

    # show proceeses that we're not matching
    def self.unmatched_processes( processes, filters, verbose )
       processes.unmatched.each do | process |
         puts process
       end
    end

  end
end
