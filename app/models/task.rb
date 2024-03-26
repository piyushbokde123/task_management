class Task < ApplicationRecord
	validates :title, :description, :status, presence: true
	enum status: {"To Do": 0, "In Progress": 1, "Done": 2}
end
