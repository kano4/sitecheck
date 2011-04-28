class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      t.datetime :date
      t.string :status
      t.string :site_name
      t.string :site_url
      t.string :diff
      t.string :webimage

      t.timestamps
    end
  end

  def self.down
    drop_table :logs
  end
end
