class Task < ApplicationRecord
	validates :title, :description, :status, presence: true
	validates :title,  uniqueness: true
	enum status: {"To Do": 0, "In Progress": 1, "Done": 2}
end
