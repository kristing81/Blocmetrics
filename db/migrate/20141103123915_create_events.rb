class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.references :tracked_domain, index: true
      t.string :event_type
      t.string :url
      t.string :ip_address
      
      t.timestamps null: false
    end
  end
end
