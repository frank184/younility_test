class UserLabel < ActiveRecord::Base
  belongs_to :user
  belongs_to :label

  validates_uniqueness_of :label, scope: :user
  validates_uniqueness_of :user, scope: :label
end
