class CreateEndorsements < ActiveRecord::Migration[5.1]
  def change
    create_table :endorsements do |t|
      t.belongs_to :review, foreign_key: true

      t.timestamps
    end
  end
end
