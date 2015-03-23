class Article < ActiveRecord::Base
	# makes sure all the associated comments get destroyed too
	has_many(:comments, :dependent => :destroy)
	validates_length_of(:content, :minimum => 5)
	validates(:author, :presence => true)
	validates(:title, :presence => true, :length => {:minimum => 4, :maximum => 30})
end
