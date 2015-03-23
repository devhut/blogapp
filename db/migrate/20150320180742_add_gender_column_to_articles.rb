class AddGenderColumnToArticles < ActiveRecord::Migration
  def change
  	add_column(:articles, :gender, :string)
  end
end
