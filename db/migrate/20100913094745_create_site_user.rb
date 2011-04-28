class CreateSiteUser < ActiveRecord::Migration
  def self.up
    create_table :site_users do |t|
      t.string :site_id
      t.string :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :site_users
  end
end
