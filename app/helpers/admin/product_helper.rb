module Admin::ProductHelper

  # Return 4 lastest products of a specified type and model
  def getSampleProducts(type, model)
     McProduct.find_all_by_type_id_and_model_id type, model, :limit => 4, :order => 'create_date desc'
  end

  # Return the image tag for a product
  def image_for(product, size = :thumb)

   if product.image_upload
      product_image = product.image_upload.public_filename(size)
      image_tag(product_image, :style => 'border:0')
   elsif (!product.image.blank?)
      image_tag(product.image, :width => '100', :height => '100', :style => 'border:0')
   else
      image_tag('/files/products/blank.png' , :style => 'border:0')
   end

  end

end
