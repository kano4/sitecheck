class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :user_id
      t.string :name
      t.string :host
      t.string :email
      t.boolean :summary_mail
      t.text :note
      t.string :password
      t.string :persistence_token
      t.string :persistence_field
      t.string :crypted_password
      t.string :usertype

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
