class CreateIps < ActiveRecord::Migration
  def self.up
    create_table :ips do |t|
      t.column :ipv4_as_u32, :"int(11) unsigned"
      t.string :type
      t.column :global_routing_prefix, :"int(11) unsigned"
      t.column :subnet_identifier, :"int(11) unsigned"
      t.column :interface_identifier, :"bigint unsigned"
      t.string :status
      t.string :hostname
      t.string :network_use
      t.column :prefix, :"tinyint unsigned"

      t.timestamps
    end
  end

  def self.down
    drop_table :ips
  end
end
