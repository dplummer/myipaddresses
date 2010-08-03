Feature: IP Addresses

	So that I can store IP addresses
	That are both IPv4 and IPv6
	
	Scenario: Show a list of IPv4 and IPv6 addresses
		Given the following IP addresses:
		  | address     | type | prefix | status    | network_use | hostname    |
		  | 172.16.10.4 | Ipv4 | 24     | Available | Unicast     | test4.local |
		  | 24B8::6FF0  | Ipv6 | 128    | Available | Unicast     | test6.local |
		When I go to list ips
		Then I should see "172.16.10.4/24"
		And I should see "24b8::6ff0/128"