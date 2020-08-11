require 'rpv/filters'
require 'tempfile'

def create_temp_rolesfile(roles)
  temp_roles = Tempfile.new

  roles.each do |role|
    temp_roles.write("#{role}\n")
  end

  temp_roles.rewind
  temp_roles.flush

  temp_roles
end

describe 'Rpv::Filters' do
  roles = %w[ssh ntp web]

  temp_roles = create_temp_rolesfile(roles)

  it 'knows which allowed role files are available' do
    files = %w[ssh cobbler ntp]

    f = Rpv::Filters.new '/tmp', temp_roles.path

    present = f.role_filters(roles, files)
    expect(present.length).to eq 2

    expect(present.include?('ssh')).to be true
    expect(present.include?('ntp')).to be true
  end
end
