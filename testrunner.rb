watch( 'spec/(.*)_spec.rb' ) {|md| system("rspec spec/spec_helper.rb spec/#{md[1]}_spec.rb") }
watch( 'lib/(.*)\.rb' )      {|md| system("rspec spec/spec_helper.rb spec/#{md[1]}_spec.rb") }
