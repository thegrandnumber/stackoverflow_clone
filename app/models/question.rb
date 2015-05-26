class Question < ActiveRecord::Base
  has_many :answers
  validates :title, :content, presence: true, length: {minimum: 6}
  validates_uniqueness_of :title
end
