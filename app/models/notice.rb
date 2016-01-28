class Notice < ActiveRecord::Base

  belongs_to :user
  belongs_to :noticeable, polymorphic: true

end