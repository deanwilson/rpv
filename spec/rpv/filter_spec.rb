require 'rpv/filter'

describe "Rpv::Filter" do

  it "should split a line in to filters" do
    line = "uname => root, command => /usr/bin/bash"

    f = Rpv::Filter.new line
    f.split( line ).length.should == 2
  end

  # todo add broken cases
  it "should extract pairs" do
    line = "uname => root, command => /usr/bin/bash"

    f = Rpv::Filter.new line

    [ [ "uname", "root" ], [ "command", "  /usr/bin/bash arg " ], ].each do | pair |
      extracted = f.extract_pair( "#{pair[0]} => #{pair[1]}" )

      extracted.keys.length.should   == 1
      extracted.values.length.should == 1

      extracted.keys[0].should   == pair[0].strip
      extracted.values[0].should == pair[1].strip
    end
  end

  it "should extract fields" do
    filter = 'uname => root, command =>    /usr/bin/bash arg'
  end

end
