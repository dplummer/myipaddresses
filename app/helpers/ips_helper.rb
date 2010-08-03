module IpsHelper
  def text_fields_for_ipv6_address(model_name, ipv6_address)
    (0..7).collect do |i|
      text_field_tag "#{model_name}[hexs][]", ipv6_address.hexs[i], :maxlength => 4, :class => 'ipv6_block'
    end.join(":\n") + " / " + text_field_tag("#{model_name}[prefix]", ipv6_address.prefix, :maxlength => 3, :class => 'prefix_v6')
  end
  def text_fields_for_ipv4_address(model_name, ipv4_address)
    (0..3).collect do |i|
      text_field_tag "#{model_name}[chunks][]", ipv4_address.chunks[i], :maxlength => 3, :class => 'ipv4_block'
    end.join(".\n") + " / " + text_field_tag("#{model_name}[prefix]", ipv4_address.prefix, :maxlength => 2, :class => 'prefix_v4')
  end
end
