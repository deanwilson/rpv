require 'rpv/filter'

describe 'Rpv::Filter' do
  it 'splits a line in to filters' do
    line = 'uname => root, command => /usr/bin/bash'

    f = Rpv::Filter.new line
    expect(f.split(line).length).to eq 2
  end

  # TODO: add broken cases
  context 'when provided multiple correct pairs' do
    line = 'uname => root, command => /usr/bin/bash'

    f = Rpv::Filter.new line

    [%w[uname root], ['command', '  /usr/bin/bash arg ']].each do |pair|
      extracted = f.extract_pair("#{pair[0]} => #{pair[1]}")

      it "extracts a single #{pair[0]} key" do
        expect(extracted.keys.length).to eq 1
      end

      it "extracts a single #{pair[1]} value" do
        expect(extracted.values.length).to eq 1
      end

      it "matches [#{pair[0]}] as the key name" do
        expect(extracted.keys[0]).to eq pair[0].strip
      end

      it "matches [#{pair[1]}] as the key value" do
        expect(extracted.values[0]).to eq pair[1].strip
      end
    end
  end
  # TODO: implement this test
  #  it 'extracts fields' do
  #    filter = 'uname => root, command =>    /usr/bin/bash arg'
  #  end
end
