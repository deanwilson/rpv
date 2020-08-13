require 'rpv/process'

module Rpv
  # Fetch the list of system processes and turn them into usable objects
  class Processes
    attr_reader :processes

    def initialize
      load_processes
    end

    def fields
      %w[uname pid ppid command]
    end

    def extract(fields, line)
      line.chomp!
      details = {}

      columns = line.split(/\s+/, fields.length)

      unless fields.length == columns.length
        # shouldn't ever get here...
        raise "Number of columns and fields don't match (#{columns.length} columns vs #{fields.length} fields)"
      end

      fields.each_index { |i| details[fields[i]] = columns[i] }

      details['pid']  = details['pid'].to_i
      details['ppid'] = details['ppid'].to_i

      details
    end

    def load_processes(ps_cmd = '/bin/ps')
      command = "#{ps_cmd} --no-headers -e -o #{fields.join(',')}"

      parsed = IO.popen(command).collect { |line| extract(fields, line) }

      @processes = []
      parsed.each do |p|
        @processes << Rpv::Process.new(p['pid'], p['ppid'], p['uname'], p['command'])
      end
    end

    def count
      @processes.length
    end

    def matched
      @processes.reject { |process| process.matched.empty? }
    end

    def unmatched
      @processes.select { |proc| proc.matched.empty? }
    end
  end
end
