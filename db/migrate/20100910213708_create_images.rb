class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.text :description
      t.date :date
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
