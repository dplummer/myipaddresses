require 'spec_helper'

describe Ipv6 do
  describe "validation" do
    it "is valid with valid attributes" do
      Ipv6.new(:address => '1080:0000:0000:0000:0008:0800:200c:417a').should be_valid
    end
  
    it "is not valid without an address" do
      Ipv6.new(:address => nil).should_not be_valid
    end
  end
  
  describe "conversion" do
    it "should convert from string to integer" do
      ip = Ipv6.new(:address => "1080:0000:0000:0000:0008:0800:200c:417a")
      ip.address_as_integers.should == [276824064,0,2260596444381562]
    end
    
    it "should convert from integer to string" do
      ip = Ipv6.new(:address_as_integers => [276824064,0,2260596444381562])
      ip.address.should == "1080:0000:0000:0000:0008:0800:200c:417a"
    end
  end
  
  describe "reduction" do
    it "should reduce an ipv6 address" do
      ip = Ipv6.new(:address => "1080:0000:0000:0000:0008:0800:200c:417a")
      ip.compressed.should == "1080::8:800:200c:417a"
    end
  end
end