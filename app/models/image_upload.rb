class ImageUpload < ActiveRecord::Base
  belongs_to :mc_product, :foreign_key => 'product_id'
  
  has_attachment :content_type => :image,
                 :resize_to => '100x100',
                 :storage => :file_system, 
                 :path_prefix => 'public/files/products',
                 :max_size => 3.megabytes,
                 :thumbnails => { :thumb => '60x76>',
                                  :large => '100x100>',
                                  :medium => '64x64>',
                                  :small => '48x48>'}
  
  validates_presence_of :filename
  validates_as_attachment
end
