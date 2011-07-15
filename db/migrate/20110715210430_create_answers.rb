class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text        :problem, :null => false
      t.text        :quote, :null => false
      t.integer     :raiting, :default => 0
      t.string      :token
      t.timestamps
    end
  end
end
