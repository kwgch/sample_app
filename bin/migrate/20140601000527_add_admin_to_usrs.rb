class AddAdminToUsrs < ActiveRecord::Migration
  def change
    add_column :usrs, :admin, :boolean
  end
end
