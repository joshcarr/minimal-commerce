class CreateImageUploads < ActiveRecord::Migration
  def self.up
    create_table :image_uploads do |t|
      t.column :parent_id,    :integer
      t.column :product_id,   :integer
      t.column :content_type, :string
      t.column :filename,     :string    
      t.column :thumbnail,    :string 
      t.column :size,         :integer
      t.column :width,        :integer
      t.column :height,       :integer
    end
    
    # Constraints
    execute "alter table image_uploads add constraint fk_image_product  foreign key (product_id)  REFERENCES products(id)"

  end

  def self.down

    execute "alter table image_uploads drop foreign key fk_image_product"

    drop_table :image_uploads

  end
end
