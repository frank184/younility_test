class Label < ActiveRecord::Base
  # has_and_belongs_to_many :users
  has_many :user_labels
  has_many :users, through: :user_labels

  validates_uniqueness_of :name, scope: :colour
  validates_presence_of :name, :colour
  validates :colour,
    length: { is: 7 },
    format: {
      with:  /\A#/,
      message: 'Must start with #'
    }, if: :colour?
end
