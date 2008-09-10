class McOrder < Order

  belongs_to :mc_customer, :foreign_key => 'customer_id'
  has_many   :details, :class_name => 'OrdersProducts', :foreign_key => 'order_id'

  has_and_belongs_to_many :products, :foreign_key => 'product_id'

end
