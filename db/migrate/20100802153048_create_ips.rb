class CreateIps < ActiveRecord::Migration
  def self.up
    create_table :ips do |t|
      t.integer unsigned :ipv4_as_int
      t.string :type
      t.integer unsigned :global_routing_prefix
      t.integer unsigned :subnet_identifier
      t.bigint unsigned :interface_identifier
      t.string :status
      t.string :hostname
      t.string :network_use
      t.tinint unsigned :subnet

      t.timestamps
    end
  end

  def self.down
    drop_table :ips
  end
end
