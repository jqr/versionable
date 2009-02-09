require File.join(File.dirname(__FILE__), 'spec_helper')

describe Versionable do
  describe "initializing" do
    it "should allow initializing without any options" do
      lambda { 
        class DefaultListy
          versionable
        end
      }.should_not raise_error
    end

    it "should store options in Class.versionable_options" do
      class TTLListy
        versionable :ttl => 60
      end
      
      TTLListy.versionable_options.should == { :ttl => 60 }
    end

  end

  describe "versioning" do
    before(:each) do
      class Listy
        versionable :cache => FakeCache.new, :ttl => 30
      end
      @cache = Listy.versionable_options[:cache]
      @ttl =  Listy.versionable_options[:ttl]
    end
    
    it "should start off with a nil version" do
      Listy.version.should == nil
    end

    it "should have a version after calling new_version" do
      Listy.new_version
      Listy.new_version.should_not be_nil
    end

    it "should set the version with the TTL from the options" do
      @cache.should_receive(:write).with(anything, anything, hash_including(:expires_in => 30))
      Listy.new_version
    end

  end

end
