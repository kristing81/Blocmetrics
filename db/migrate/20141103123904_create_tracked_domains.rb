class CreateTrackedDomains < ActiveRecord::Migration
  def change
    create_table :tracked_domains do |t|

      t.references :user, index: true
      t.string :name
      t.string :description
      t.string :url
      t.string :verification_code
      t.boolean :verified, default: false


      t.timestamps null: false
    end
  end
end