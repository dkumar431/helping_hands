class Relationship < ActiveRecord::Base
  belongs_to :manager, class_name: "User"
  belongs_to :agent, class_name: "User"
end
