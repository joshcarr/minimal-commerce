class McProduct < Product

  # Relationships to other Entities
  belongs_to :type
  belongs_to :model

 
  has_many :orders_products
  has_and_belongs_to_many :mc_order, :foreign_key => 'order_id'

  has_one :image_upload, :foreign_key => 'product_id', :dependent => :destroy

  # Validation
  validates_presence_of :sku, :name
  validates_length_of   :name, :within => 2..64
  validates_numericality_of :quantity, :only_integer => true

end

