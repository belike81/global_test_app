class CreateTokenizers < ActiveRecord::Migration
  def change
    create_table :tokenizers do |t|
      t.string :token
    end
  end
end
