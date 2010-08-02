# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100802153048) do

  create_table "ips", :force => true do |t|
    t.integer  "ipv4_as_u32"
    t.string   "type"
    t.integer  "global_routing_prefix"
    t.integer  "subnet_identifier"
    t.integer  "interface_identifier",  :limit => 8
    t.string   "status"
    t.string   "hostname"
    t.string   "network_use"
    t.integer  "prefix",                :limit => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
