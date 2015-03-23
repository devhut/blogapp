class ChangeGenderTypeInArticles < ActiveRecord::Migration
  def change
  	change_column(:articles, :gender, :boolean)
  end
end
