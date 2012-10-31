# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121031200532) do

  create_table "advances", :force => true do |t|
    t.date     "charged_at",                                :null => false
    t.text     "detail",                                    :null => false
    t.decimal  "amount",     :precision => 15, :scale => 2, :null => false
    t.boolean  "state",                                     :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "bank_accounts", :force => true do |t|
    t.string   "number",                                      :null => false
    t.integer  "office_number",                               :null => false
    t.string   "kind",          :limit => 1,                  :null => false
    t.string   "currency",      :limit => 1,                  :null => false
    t.decimal  "amount",                     :default => 0.0
    t.integer  "bank_id",                                     :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "bank_accounts", ["bank_id"], :name => "index_bank_accounts_on_bank_id"
  add_index "bank_accounts", ["number"], :name => "index_bank_accounts_on_number", :unique => true

  create_table "banks", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "website"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "phone"
    t.string   "address"
    t.string   "contact_name"
  end

  create_table "cards", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "expire_at"
    t.integer  "bank_id"
  end

  add_index "cards", ["bank_id"], :name => "index_cards_on_bank_id"
  add_index "cards", ["number"], :name => "index_cards_on_number", :unique => true

  create_table "cashes", :force => true do |t|
    t.decimal  "amount",     :precision => 15, :scale => 2, :default => 0.0, :null => false
    t.string   "detail",                                                     :null => false
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.integer  "flow_id"
  end

  add_index "cashes", ["detail"], :name => "index_cashes_on_detail"
  add_index "cashes", ["flow_id"], :name => "index_cashes_on_flow_id"

  create_table "clients", :force => true do |t|
    t.string   "name",                        :null => false
    t.string   "phone"
    t.string   "email"
    t.string   "ident",                       :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "firm_name",                   :null => false
    t.string   "address"
    t.string   "iva_responsive", :limit => 1, :null => false
  end

  add_index "clients", ["firm_name"], :name => "index_clients_on_firm_name"
  add_index "clients", ["ident"], :name => "index_clients_on_ident", :unique => true
  add_index "clients", ["name"], :name => "index_clients_on_name", :unique => true

  create_table "codes", :force => true do |t|
    t.integer  "number",     :null => false
    t.text     "detail",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "flows", :force => true do |t|
    t.string   "code",                                                                        :null => false
    t.string   "subcode",                                                                     :null => false
    t.date     "charged_at",                                                                  :null => false
    t.string   "detail",                                                                      :null => false
    t.integer  "receipt",      :limit => 8
    t.integer  "register",     :limit => 8
    t.decimal  "total_amount",              :precision => 15, :scale => 2, :default => 0.0,   :null => false
    t.boolean  "in",                                                       :default => false, :null => false
    t.datetime "created_at",                                                                  :null => false
    t.datetime "updated_at",                                                                  :null => false
  end

  add_index "flows", ["code"], :name => "index_flows_on_code"
  add_index "flows", ["subcode"], :name => "index_flows_on_subcode"

  create_table "job_areas", :force => true do |t|
    t.string   "job_area"
    t.integer  "provider_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "job_areas", ["provider_id"], :name => "index_job_areas_on_provider_id"

  create_table "movements", :force => true do |t|
    t.date     "charged_at",                                  :null => false
    t.string   "mov_number",                                  :null => false
    t.decimal  "amount",       :precision => 15, :scale => 2, :null => false
    t.decimal  "total_amount", :precision => 15, :scale => 2
    t.text     "comment"
    t.string   "devoted"
    t.string   "deposited_in"
    t.date     "devoted_at"
    t.integer  "code_id",                                     :null => false
    t.integer  "bank_id",                                     :null => false
    t.integer  "client_id",                                   :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "places", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "places", ["name"], :name => "index_places_on_name", :unique => true

  create_table "providers", :force => true do |t|
    t.string   "name",                        :null => false
    t.string   "firm_name",                   :null => false
    t.string   "ident",                       :null => false
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.string   "iva_responsive", :limit => 1, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "providers", ["firm_name"], :name => "index_providers_on_firm_name"
  add_index "providers", ["ident"], :name => "index_providers_on_ident", :unique => true
  add_index "providers", ["name"], :name => "index_providers_on_name", :unique => true

  create_table "transactions", :force => true do |t|
    t.date     "charged_at",                                :null => false
    t.decimal  "amount",     :precision => 15, :scale => 2, :null => false
    t.integer  "batch"
    t.date     "expiration",                                :null => false
    t.integer  "place_id",                                  :null => false
    t.integer  "card_id",                                   :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",                                   :null => false
    t.string   "lastname"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "roles_mask",             :default => 0,  :null => false
    t.integer  "lock_version",           :default => 0,  :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["lastname"], :name => "index_users_on_lastname"
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.integer  "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"
  add_index "versions", ["whodunnit"], :name => "index_versions_on_whodunnit"

  create_table "workplaces", :force => true do |t|
    t.string   "address",                             :null => false
    t.string   "city"
    t.string   "state",      :default => "Mendoza",   :null => false
    t.string   "country",    :default => "Argentina", :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

end
