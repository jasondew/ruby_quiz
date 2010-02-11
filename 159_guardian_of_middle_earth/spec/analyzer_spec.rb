require 'lib/analyzer.rb'

require 'spec/spec_helper' and include SpecHelper

describe Analyzer do

  before(:each) do
    @log = Log.new File.new('guardian.txt')
    @analyzer = Analyzer.new @log
  end

  it "should compute the sum" do
#    @analyzer.sum.should == 
  end

end
