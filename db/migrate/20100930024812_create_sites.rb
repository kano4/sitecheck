class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.string :site_name
      t.string :site_url
      t.string :check_url
      t.string :site_status
      t.string :domain_name
      t.date :domain_deadline
      t.boolean :ssl_valid
      t.date :ssl_deadline
      t.datetime :created_date
      t.datetime :updated_date
      t.datetime :last_check
      t.string :manager
      t.string :group
      t.text :note
      t.string :check_status
      t.mediumtext :check_html
      t.mediumtext :check_html2
      t.string :ssl_check_name
    end
  end

  def self.down
    drop_table :sites
  end
end
