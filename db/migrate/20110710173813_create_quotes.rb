class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text      :content
      t.string    :source
      t.decimal   :rating, :default => 0
      t.timestamps
    end
  end
end
