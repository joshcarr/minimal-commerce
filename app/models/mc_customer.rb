class McCustomer < Customer
  has_many :mc_orders, :foreign_key => 'customer_id', :dependent => :destroy
  
  def fullname
    self.first_name + ' ' + self.last_name
  end
end
