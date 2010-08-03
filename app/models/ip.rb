# +-----------------------+---------------------+------+-----+---------+----------------+
# | Field                 | Type                | Null | Key | Default | Extra          |
# +-----------------------+---------------------+------+-----+---------+----------------+
# | id                    | int(11)             | NO   | PRI | NULL    | auto_increment | 
# | ipv4_as_u32           | int(10) unsigned    | YES  |     | NULL    |                | 
# | type                  | varchar(255)        | YES  |     | NULL    |                | 
# | global_routing_prefix | int(10) unsigned    | YES  |     | NULL    |                | 
# | subnet_identifier     | int(10) unsigned    | YES  |     | NULL    |                | 
# | interface_identifier  | bigint(20) unsigned | YES  |     | NULL    |                | 
# | status                | varchar(255)        | YES  |     | NULL    |                | 
# | hostname              | varchar(255)        | YES  |     | NULL    |                | 
# | network_use           | varchar(255)        | YES  |     | NULL    |                | 
# | prefix                | tinyint(3) unsigned | YES  |     | NULL    |                | 
# | created_at            | datetime            | YES  |     | NULL    |                | 
# | updated_at            | datetime            | YES  |     | NULL    |                | 
# +-----------------------+---------------------+------+-----+---------+----------------+
class Ip < ActiveRecord::Base
  
  TYPES = ['Ipv4', 'Ipv6']
  STATUSES = ['Not Assigned', 'Assigned', 'Pending Return', 'Reserved']
  NETWORK_USES = ['Unicast', 'Broadcast', 'Gateway', 'Network', 'Multicast', 'Anycast']
  
  validates_inclusion_of :type, :in => TYPES
  
  before_validation :remove_please_select
  
  def remove_please_select
    self.status       = '' if status == 'Please select'
    self.network_use  = '' if network_use == 'Please select'
    self.type         = '' if type == 'Please select'
  end
  
  def full_address
    prefix ? "#{address}/#{prefix}" : address
  end
  
  def address
  end
  
  def hexs
    []
  end
  
  def hexs=(nothing)
  end
  
  def chunks
    []
  end
  
  def chunks=(nothing)
  end
end
