class Ipv6 < Ip
  
  #
  # Format string to pretty print IPv6 addresses
  #
  IN6FORMAT = ("%.4x:"*8).chop
  
  before_validation :address_to_integers
  before_validation :set_type_to_ipv6
  
  validates_presence_of :global_routing_prefix, :subnet_identifier, :interface_identifier
  
  def address=(str)
    @address = str if valid_ipv6?(str)
  end
  
  def address
    @address ||= integers_to_address
  end
  
  def address_as_integers=(integers)
    self.global_routing_prefix, self.subnet_identifier, self.interface_identifier = integers
  end
  
  def address_as_integers
    [
      hex2dec([hexs[0],hexs[1]].join("")),
      hex2dec([hexs[2],hexs[3]].join("")),
      hex2dec([hexs[4],hexs[5],hexs[6],hexs[7]].join(""))
    ]
  end
  
  def compressed
    @compressed ||= compress_address
  end
  
  #
  # Returns an array of the 16 bits groups in hexdecimal 
  # format:
  #
  #   ip6 = IPAddress "2001:db8::8:800:200c:417a/64"
  #
  #   ip6.hexs
  #     #=> ["2001", "0db8", "0000", "0000", "0008", "0800", "200c", "417a"]
  #
  # Not to be confused with the similar IPv6#to_hex method.
  #
  def hexs
    address.split(":")
  end
  
  # 
  # Returns a Base16 number representing the IPv6 
  # address
  #
  #   ip6 = IPAddress "2001:db8::8:800:200c:417a/64"
  #
  #   ip6.to_hex
  #     #=> "20010db80000000000080800200c417a"
  #
  def to_hex
    hexs.join("")
  end
  
  private
  
  def set_type_to_ipv6
    type = 'Ipv6'
  end
  
  def address_to_integers
    self.global_routing_prefix, self.subnet_identifier, self.interface_identifier = address_as_integers if @address
  end
  
  def hex2dec hex 
    "0x#{hex}".to_i(16)
  end
  
  def integers_to_address
    integers_to_hexs.join(":")
  end
  
  def integers_to_hexs
    [
      sprintf("%.8x",self.global_routing_prefix).scan(/.{4}/),
      sprintf("%.8x",self.subnet_identifier).scan(/.{4}/),
      sprintf("%.16x",self.interface_identifier).scan(/.{4}/)
    ].compact
  end
  
  #
  # Extract 16 bits groups from a string
  #
  def groups(str)
    l, r = if str =~ /^(.*)::(.*)$/
             [$1,$2].map {|i| i.split ":"}
           else
             [str.split(":"),[]]
           end
    (l + Array.new(8-l.size-r.size, '0') + r).map {|i| i.hex}
  end
  
  def compress_address
    str = groups(@address).map{|i| i.to_s 16}.join ":"
    loop do
      break if str.sub!(/\A0:0:0:0:0:0:0:0\Z/, '::')
      break if str.sub!(/\b0:0:0:0:0:0:0\b/, ':')
      break if str.sub!(/\b0:0:0:0:0:0\b/, ':')
      break if str.sub!(/\b0:0:0:0:0\b/, ':')
      break if str.sub!(/\b0:0:0:0\b/, ':')
      break if str.sub!(/\b0:0:0\b/, ':')
      break if str.sub!(/\b0:0\b/, ':')
      break
    end
    str.sub(/:{3,}/, '::')
  end
  
  #
  # Checks if the given string is a valid IPv6 address
  #
  # Example:
  #
  #   IPAddress::valid_ipv6? "2002::1"
  #     #=> true
  #
  #   IPAddress::valid_ipv6? "2002::DEAD::BEEF"
  #     #=> false
  #
  def valid_ipv6?(addr)
    # IPv6 (normal)
    return true if /\A[\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*\Z/ =~ addr
    return true if /\A[\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*::([\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*)?\Z/ =~ addr
    return true if /\A::([\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*)?\Z/ =~ addr
    # IPv6 (IPv4 compat)
    return true if /\A[\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*:/ =~ addr && valid_ipv4?($')
    return true if /\A[\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*::([\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*:)?/ =~ addr && valid_ipv4?($')
    return true if /\A::([\dA-Fa-f]{1,4}(:[\dA-Fa-f]{1,4})*:)?/ =~ addr && valid_ipv4?($')
    false
  end
end