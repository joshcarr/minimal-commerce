class MinimalcommerceStructure < ActiveRecord::Migration
  def self.up

    # Table: Customers (Used from Minimal_Cart)
    create_table :customers do |t|
      t.column :first_name,  :string, :limit => 32, :null => false
      t.column :last_name,   :string, :limit => 32, :null => false
      t.column :gender,      :integer,:limit => 1,  :null => false
      t.column :password,    :string, :limit => 32
      t.column :address,     :string, :limit => 128, :null => false
      t.column :city,        :string, :limit => 32
      t.column :state,       :string, :limit => 32
      t.column :country,     :string, :limit => 32, :null => false
      t.column :postcode,    :string, :limit => 16
      t.column :email,       :string, :limit => 32, :null => false
      t.column :phone,       :string, :limit => 16    
      t.column :fax,         :string, :limit => 16
      t.column :create_date, :datetime, :null => false, :default => Time.now
      t.column :update_date, :datetime, :null => false, :default => Time.now
    end
    
    # Table: Product Model
    create_table :models do |t|
      t.column :name,  :string, :limit => 32, :null => false
    end
    
    # Table: Product Type
    create_table :types do |t|
      t.column :name,  :string, :limit => 32, :null => false
    end

    # Table: Product
    create_table :products do |t|
      t.column :sku,         :string, :limit => 8, :null => false
      t.column :name,        :string, :limit => 64, :null => false
      t.column :description, :text,   :null => false
      t.column :price,       :decimal, :precision => 8, :scale => 2, :default => 0
      t.column :quantity,    :integer, :default => 0
      t.column :image,       :string, :limit => 128
      t.column :model_id,    :integer, :null => false  
      t.column :type_id,     :integer, :null => false
      t.column :create_date, :datetime, :null => false, :default => Time.now
      t.column :update_date, :datetime, :null => false, :default => Time.now
    end

    # Indexing for searching performance
    add_index :products, :sku
    add_index :products, :name
    
    # Foreign key constrains.
    execute "alter table products add constraint fk_product_type  foreign key (type_id)  REFERENCES types(id)"
    execute "alter table products add constraint fk_product_model foreign key (model_id) REFERENCES models(id)"

    # Table: Order
    create_table :orders do |t|
       t.column :customer_id,      :integer, :null => false
       t.column :shipping_method,  :string, :limit => 32,  :null => false
       t.column :shipping_address, :string, :limit => 128, :null => false
       t.column :status,       :integer, :limit => 1, :null => false, :default => 0
    end
    
    # Foreign Key constrains for order table
    execute "alter table orders add constraint fk_order_customer  foreign key (customer_id)  REFERENCES customers(id)"

    # Table: Ordered Product
    create_table :orders_products do |t|
      t.column :order_id,   :integer, :null => false
      t.column :product_id, :integer, :null => false
      t.column :quantity,   :integer, :null => false
      t.column :price,      :decimal, :precision => 8, :scale => 2, :default => 0
    end

    # Foreign Key constrains for Ordered Product table
    execute "alter table orders_products add constraint fk_order_detail_order   foreign key (order_id)   REFERENCES orders(id)"
    execute "alter table orders_products add constraint fk_order_detail_product foreign key (product_id) REFERENCES products(id)"

  end

  def self.down
    
    # Remove constraints
    # Table: Orders_Products
    execute "alter table orders_products drop foreign key fk_order_detail_order"
    execute "alter table orders_products drop foreign key fk_order_detail_product"
    
    # Table: Orders_Products
    execute "alter table products drop foreign key fk_product_type"
    execute "alter table products drop foreign key fk_product_model"
    

    # Table: Orders_Products
    execute "alter table orders drop foreign key fk_order_customer"
    
    # Remove tables
    drop_table :orders_products
    drop_table :orders
    drop_table :products
    drop_table :customers
    drop_table :types
    drop_table :models


  end
end
