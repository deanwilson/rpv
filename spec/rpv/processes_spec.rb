require 'rpv/processes'

describe "Rpv::Processes" do

  it "should return the fields to use in ps" do
    p = Rpv::Processes.new

    p.fields.length.should == 4
    p.fields.include?("command").should be_true
    p.fields.include?("uname").should be_true
  end

  it "should extract a simple ps structure" do
    process = 'root      2898     1 syslogd -m 0'

    p = Rpv::Processes.new
    ds = p.extract( p.fields, process)

    ds.keys.length.should == 4

    ds['pid'].should  == 2898
    ds['ppid'].should == 1

    ds['command'].should == 'syslogd -m 0'
    ds['uname'].should == 'root'
  end

  it "should load processes from the system" do

  end

  it "should contain processes" do
    # TODO stub this
    p = Rpv::Processes.new
    p.count.should >= 100
  end

  it "should return an array of process objects when asked" do
    p = Rpv::Processes.new
    p.processes.class.should == Array
  end

end
