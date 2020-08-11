require 'rpv/process'
require 'rpv/filter'

describe 'Rpv::Process' do
  context 'when passed a valid constructor' do
    p = Rpv::Process.new(30, 1, 'root', '/usr/sbin/testy')

    it 'returns the pid used in the constructor' do
      expect(p.pid).to eq(30)
    end

    it 'returns the ppid used in the constructor' do
      expect(p.ppid).to eq(1)
    end

    it 'returns the uname used in the constructor' do
      expect(p.uname).to eq 'root'
    end

    it 'returns the command value used in the constructor' do
      expect(p.command).to eq '/usr/sbin/testy'
    end
  end

  it 'returns a string representation' do
    p = Rpv::Process.new(30, 1, 'root', '/usr/sbin/testy')
    expect(p.to_s).to eq 'pid: 30, ppid: 1, uname: root, command: /usr/sbin/testy'
  end

  it 'matches on a correct filter' do
    p = Rpv::Process.new(30, 1, 'root', '/usr/sbin/testy')
    f = Rpv::Filter.new 'uname => root, command => /usr/sbin/testy'
    expect(p.matches?(f)).to be true
  end

  it 'does not match on an incorrect filter' do
    p = Rpv::Process.new(30, 1, 'root', '/usr/sbin/testy')
    f = Rpv::Filter.new 'uname => testy, command => /usr/local/bin/testy'
    expect(p.matches?(f)).to be false
  end
end
