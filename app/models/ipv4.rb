class Ipv4 < Ip
  
  #
  # Regular expression to match an IPv4 address
  #
  REGEXP = Regexp.new(/((25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)\.){3}(25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)/)
  
  before_validation :address_to_u32
  before_validation :set_type_to_ipv4
  
  validates_presence_of :ipv4_as_u32
  
  
  #
  # Sets the address portion of the Ipv4 object from a string
  #
  #   ip = Ipv4.new
  #
  #   ip.address = "172.16.100.3"
  #     #=> "172.16.100.3"
  #
  def address=(str)
    @address = str if str =~ REGEXP
  end
  
  #
  # Returns the address portion of the IPv4 object
  # as a string.
  #
  #   ip = Ipv4.new(:ipv4_as_u32 => "2886755332")
  #
  #   ip.address
  #     #=> "172.16.100.4"
  #
  def address
    @address ||= address_from_u32(ipv4_as_u32)
  end
  
  #
  # Returns the address as 32-bit integer
  #
  #    ip = Ipv4.new(:address => "172.16.100.4")
  #
  #    ip.address_as_u32
  #      #=> 2886755332
  #
  def address_as_u32
    ipv4_as_u32 || address_to_u32
  end
  
  private
  
  def set_type_to_ipv4
    type = 'Ipv4'
  end
  
  def address_to_u32
    self.ipv4_as_u32 = u32_from_address(@address) if @address
  end
  
  def address_from_u32(address_as_u32)
    [24, 16, 8, 0].map { |shift| (address_as_u32 >> shift) & 255 }.join(".")
  end
  
  def u32_from_address(ip)
    Integer("0b"+bits_from_address(ip))
  end
  
  def bits_from_address(ip)
    ip.split(".").map{|i| i.to_i}.pack("C4").unpack("B*").first
  end
end