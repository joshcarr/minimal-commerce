class OrdersProducts < ActiveRecord::Base
    
    belongs_to   :mc_product, :foreign_key => 'product_id'
    belongs_to   :mc_order,   :foreign_key => 'order_id'

end
