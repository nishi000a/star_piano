class Favorite < ApplicationRecord
  belongs_to :student
  belongs_to :post
  
  
end
