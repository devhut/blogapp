class AddAuthorColumnToArticles < ActiveRecord::Migration
  
  def change
  	add_column(:articles, :author, :string, :limit => 30, :default => "Joe")
  end

end
