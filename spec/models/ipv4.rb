require 'spec_helper'

describe Ipv4 do
  describe "validation" do
    it "is valid with valid attributes" do
      Ipv4.new(:address => '172.16.100.5').should be_valid
    end
  
    it "is not valid without an address" do
      Ipv4.new(:address => nil).should_not be_valid
    end
  end
  
  describe "conversion" do
    it "should convert from string to integer" do
      ip = Ipv4.new(:address => "172.16.100.5")
      ip.address_as_u32.should == 2886755333
    end
    
    it "should convert from integer to string" do
      ip = Ipv4.new(:ipv4_as_u32 => 2886755333)
      ip.address.should == "172.16.100.5"
    end
  end
end