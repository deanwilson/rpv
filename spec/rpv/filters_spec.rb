require 'rpv/filters'

describe "Rpv::Filters" do

  it "should know which allowed role files to are available" do
    roles = %w[ ssh ntp web ]
    files = %w[ ssh cobbler ntp ]

    f = Rpv::Filters.new "/tmp"

    present = f.role_filters( roles, files)
    present.length.should == 2

    present.include?( "ssh" ).should be_true
    present.include?( "ntp" ).should be_true
  end

end
