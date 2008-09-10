# See LICENSE file in the root for details
class CreateMinimalCarts < ActiveRecord::Migration
  def self.up
    # customers
    #create_table :customers do |table|
    #  table.column :first_name, :string
    #  table.column :last_name, :string
    #  table.column :email, :string
    #  table.column :phone, :string
    #   table.column :street_address, :string
    #   table.column :zip_code, :string
    #  table.column :state, :string
    #  table.column :country, :string
    #  table.column :city, :string
    #   table.column :shipping_method, :string
    #end
    add_column :customers, :street_address,   :string
    add_column :customers, :zip_code,         :string
    add_column :customers, :shipping_method,  :string
    
    # orders 
    #create_table :orders do |table|
    #  table.column :transaction_id, :integer
    #  table.column :product_id, :integer
    #  table.column :quantity, :integer
    #end
    add_column :orders, :transaction_id,  :integer
    add_column :orders, :product_id,      :integer
    add_column :orders, :quantity,        :integer
    
    # products
    #create_table :products do |table|
    #  table.column :name, :string
    #   table.column :byline, :string
    #  table.column :description, :text
    #  table.column :price, :integer
    #   table.column :weight, :integer
    #end
    add_column :products, :byline, :string
    add_column :products, :weight, :integer, :default => 0
    
    # shopping transactions
    create_table :shopping_transactions do |table|
      table.column :date, :datetime
      table.column :status_transaction_id, :integer
      table.column :total, :integer
      table.column :customer_id, :integer
    end
    
    
    # shopping transaction statuses
    create_table :shopping_transaction_statuses do |table|
      table.column :status, :string
      table.column :description, :string
    end
    
    
    # country groups
    create_table :country_groups do |table|
      table.column :country, :string
      table.column :group_id, :integer
    end
    
    
    # shipping rates 
    create_table :shipping_rates do |table|
      table.column :from_weight, :float
      table.column :to_weight, :float
      table.column :method, :string
      table.column :rate, :float
      table.column :country_group, :integer
    end
    
    
    # tax rates
    create_table :tax_rates do |table|
      table.column :rate, :float
      table.column :state, :string
      table.column :country, :string
    end
  end
  
  def self.down
    drop_table :shopping_transactions
    drop_table :shopping_transaction_statuses
    drop_table :country_groups
    drop_table :shipping_rates
    drop_table :tax_rates
    
    remove_column :customers, :street_address
    remove_column :customers, :zip_code
    remove_column :customers, :shipping_method
    remove_column :products,  :byline
    remove_column :products,  :weight
    remove_column :orders,    :transaction_id
    remove_column :orders,    :product_id
    remove_column :orders,    :quantity
  end
end
