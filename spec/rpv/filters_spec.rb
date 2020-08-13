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
  files = %w[ssh cobbler ntp]

  f = Rpv::Filters.new '/tmp', temp_roles.path

  present = f.role_filters(roles, files)

  it 'find the correct number of allowed role files' do
    expect(present.length).to eq 2
  end

  it 'finds the correct files' do
    # checks the intersection of present and the array - which should be 2.
    expect((present & %w[ntp ssh]).length).to eq 2
  end
end
