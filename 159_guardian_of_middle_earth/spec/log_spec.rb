require 'lib/log'

require 'spec/spec_helper' and include SpecHelper

describe Log do

  before(:each) do
    @io = mock File
  end

  it "should read and parse the log file, ignoring comments" do
    @io.should_receive(:each_line).and_yield("#comment")
    Log.new(@io).entries.should be_empty
  end

  it "should not instantiate a log object for a defensive line" do
    @io.should_receive(:each_line).and_yield("The Gore-crow Watcher wounds you with Melee Common Min for 15 points of Common.\n")
    Log.new(@io).entries.should be_empty
  end

  it "should instantiate a log object for each offensive, non-comment line" do
    @io.should_receive(:each_line).and_yield("You wound the Gore-crow Watcher with Guardian's Ward for 33 points of Common damage.\n")
    Log.new(@io).entries.should_not be_empty
  end

end

describe Log, "given a specific, offensive entry" do

  before(:each) do
    @io = mock File
    @io.should_receive(:each_line).and_yield("You wound the Gore-crow Watcher with Guardian's Ward for 33 points of Common damage.\n")
    @log = Log.new @io
  end

  describe "should instantiate a LogEntry object" do

    it "with the correct class" do
      log_entry.class.should == Log::Entry
    end

    it "with the correct mob" do
      log_entry.mob.should == "Gore-crow Watcher"
    end

    it "with the correct style" do
      log_entry.style.should == "Guardian's Ward"
    end

    it "with the correct damage" do
      log_entry.damage.should == 33
    end

    it "with the correct type" do
      log_entry.type.should == 'Common'
    end

  end
end

describe Log, "given a nonspecific, offensive entry" do

  before(:each) do
    @io = mock File
    @io.should_receive(:each_line).and_yield("You wound the Brush Hunter for 41 points of Common damage.\n")  
    @log = Log.new @io
  end

  describe "should instantiate a LogEntry object" do

    it "with the correct class" do
      log_entry.class.should == Log::Entry
    end

    it "with the correct mob" do
      log_entry.mob.should == "Brush Hunter"
    end

    it "with the correct style" do
      log_entry.style.should be_nil
    end

    it "with the correct damage" do
      log_entry.damage.should == 41
    end

    it "with the correct type" do
      log_entry.type.should == 'Common'
    end

  end
end

describe Log, "given a nonoffensive entry" do

  before(:each) do
    @io = mock File

    @nonoffensive_entries = [ "The Brush Hunter wounds you with Melee Double for 33 points of Common.\n",
                              "Your mighty blow defeated the Gore-crow Watcher.\n",
                              "You have spotted a creature attempting to move stealthily about.\n",
                              "Hellsong defeated the White Hand Spear-thrower.\n" ]
  end

  it "should be ignored" do
    @nonoffensive_entries.inject(@io.should_receive(:each_line)) {|io, entry| io.and_yield entry }

    @log = Log.new @io
    @log.entries.should be_empty
  end

end
