require 'rpv/process'
require 'rpv/filter'

describe 'Rpv::Process' do
  it 'returnd the pid value used in the constructor' do
    p = Rpv::Process.new(30, 1, 'root', '/usr/sbin/testy')

    expect(p.pid).to eq(30)
    expect(p.ppid).to eq(1)

    p.uname.should == 'root'
    p.command.should == '/usr/sbin/testy'
  end

  it 'returns a string representation' do
    p = Rpv::Process.new(30, 1, 'root', '/usr/sbin/testy')
    p.to_s.should == 'Pid: 30, ppid: 1, uname: root command: /usr/sbin/testy'
  end

  it 'matches on a correct filter' do
    p = Rpv::Process.new(30, 1, 'root', '/usr/sbin/testy')
    f = Rpv::Filter.new 'uname => root, command => /usr/sbin/testy'
    p.matches?(f).should be_true
  end

  it 'does not match on an incorrect filter' do
    p = Rpv::Process.new(30, 1, 'root', '/usr/sbin/testy')
    f = Rpv::Filter.new 'uname => testy, command => /usr/local/bin/testy'
    p.matches?(f).should be_false
  end
end
