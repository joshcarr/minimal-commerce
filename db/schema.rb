# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 5) do

  create_table "country_groups", :force => true do |t|
    t.string  "country"
    t.integer "group_id"
  end

  create_table "customers", :force => true do |t|
    t.string   "first_name",      :limit => 32,  :default => "",                    :null => false
    t.string   "last_name",       :limit => 32,  :default => "",                    :null => false
    t.integer  "gender",          :limit => 1,                                      :null => false
    t.string   "password",        :limit => 32
    t.string   "address",         :limit => 128, :default => "",                    :null => false
    t.string   "city",            :limit => 32
    t.string   "state",           :limit => 32
    t.string   "country",         :limit => 32,  :default => "",                    :null => false
    t.string   "postcode",        :limit => 16
    t.string   "email",           :limit => 32,  :default => "",                    :null => false
    t.string   "phone",           :limit => 16
    t.string   "fax",             :limit => 16
    t.datetime "create_date",                    :default => '2008-06-27 03:06:41', :null => false
    t.datetime "update_date",                    :default => '2008-06-27 03:06:41', :null => false
    t.string   "street_address"
    t.string   "zip_code"
    t.string   "shipping_method"
  end

  create_table "image_uploads", :force => true do |t|
    t.integer "parent_id"
    t.integer "product_id"
    t.string  "content_type"
    t.string  "filename"
    t.string  "thumbnail"
    t.integer "size"
    t.integer "width"
    t.integer "height"
  end

  add_index "image_uploads", ["product_id"], :name => "fk_image_product"

  create_table "models", :force => true do |t|
    t.string "name", :limit => 32, :default => "", :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer "customer_id",                                     :null => false
    t.string  "shipping_method",  :limit => 32,  :default => "", :null => false
    t.string  "shipping_address", :limit => 128, :default => "", :null => false
    t.integer "status",           :limit => 1,   :default => 0,  :null => false
    t.integer "transaction_id"
    t.integer "product_id"
    t.integer "quantity"
  end

  add_index "orders", ["customer_id"], :name => "fk_order_customer"

  create_table "orders_products", :force => true do |t|
    t.integer "order_id",                                                  :null => false
    t.integer "product_id",                                                :null => false
    t.integer "quantity",                                                  :null => false
    t.decimal "price",      :precision => 8, :scale => 2, :default => 0.0
  end

  add_index "orders_products", ["order_id"], :name => "fk_order_detail_order"
  add_index "orders_products", ["product_id"], :name => "fk_order_detail_product"

  create_table "products", :force => true do |t|
    t.string   "sku",         :limit => 8,                                 :default => "",                    :null => false
    t.string   "name",        :limit => 64,                                :default => "",                    :null => false
    t.text     "description",                                              :default => "",                    :null => false
    t.decimal  "price",                      :precision => 8, :scale => 2, :default => 0.0
    t.integer  "quantity",                                                 :default => 0
    t.string   "image",       :limit => 128
    t.integer  "model_id",                                                                                    :null => false
    t.integer  "type_id",                                                                                     :null => false
    t.datetime "create_date",                                              :default => '2008-06-27 03:06:41', :null => false
    t.datetime "update_date",                                              :default => '2008-06-27 03:06:41', :null => false
    t.string   "byline"
    t.integer  "weight"
  end

  add_index "products", ["sku"], :name => "index_products_on_sku"
  add_index "products", ["name"], :name => "index_products_on_name"
  add_index "products", ["type_id"], :name => "fk_product_type"
  add_index "products", ["model_id"], :name => "fk_product_model"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shipping_rates", :force => true do |t|
    t.float   "from_weight"
    t.float   "to_weight"
    t.string  "method"
    t.float   "rate"
    t.integer "country_group"
  end

  create_table "shopping_transaction_statuses", :force => true do |t|
    t.string "status"
    t.string "description"
  end

  create_table "shopping_transactions", :force => true do |t|
    t.datetime "date"
    t.integer  "status_transaction_id"
    t.integer  "total"
    t.integer  "customer_id"
  end

  create_table "tax_rates", :force => true do |t|
    t.float  "rate"
    t.string "state"
    t.string "country"
  end

  create_table "types", :force => true do |t|
    t.string "name", :limit => 32, :default => "", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

end
