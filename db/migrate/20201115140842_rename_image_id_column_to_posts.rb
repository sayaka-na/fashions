class RenameImageIdColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :image_id, :image
  end
end
