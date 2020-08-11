require 'rpv/processes'

describe 'Rpv::Processes' do
  context 'with the default constructor' do
    p = Rpv::Processes.new

    it 'returns the fields to use in ps' do
      expect(p.fields.length).to eq 4
    end

    it 'contains command' do
      expect(p.fields.include?('command')).to be true
    end

    it 'contains uname' do
      expect(p.fields.include?('uname')).to be true
    end
  end

  context 'with a sample ps structure' do
    process = 'root      2898     1 syslogd -m 0'

    p = Rpv::Processes.new
    ds = p.extract(p.fields, process)

    it 'extracts a the correct number of keys' do
      expect(ds.keys.length).to eq 4
    end

    it 'extracts a the correct number pid' do
      expect(ds['pid']).to eq 2898
    end

    it 'extracts a the correct number ppid' do
      expect(ds['ppid']).to eq 1
    end

    it 'extracts a the correct number command' do
      expect(ds['command']).to eq 'syslogd -m 0'
    end

    it 'extracts a the correct number uname' do
      expect(ds['uname']).to eq 'root'
    end
  end

  # it 'contains processes' do
  #   # TODO: stub this - currently looks at the running system
  #   p = Rpv::Processes.new
  #   expect(p.count).to eq 100
  # end

  it 'returns an array of process objects when asked' do
    p = Rpv::Processes.new
    expect(p.processes.class).to be Array
  end
end
