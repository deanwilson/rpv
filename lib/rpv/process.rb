module Rpv
  class Process

    @debug = false

    attr_accessor :pid, :ppid, :uname, :command
  
    def initialize( pid, ppid, uname, command )
      @pid     = pid
      @ppid    = ppid
      @uname   = uname
      @command = command
      @matched = []
    end

    def matches?( filter)

      filter.filters.each do | criteria, wanted |
        puts " - matching on #{criteria.inspect} -- #{wanted.inspect}" if @debug

        if criteria == 'command'
          # TODO - make it do regexs
          return false unless @command.include?( wanted )
        else
          return false unless self.send( criteria ) == wanted
        end
      end

      true
    end

    def matched=( match )
      @matched << match
    end

    def matched
      @matched
    end

    def to_s
      "pid => #{@pid}, ppid => #{@ppid}, uname => #{@uname}, command => #{@command}"
    end

  end
end
