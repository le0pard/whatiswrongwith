class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer     :quote_id, :null => false
      t.text        :problem, :null => false
      t.integer     :raiting, :default => 0
      t.string      :token
      t.timestamps
    end
  end
end
