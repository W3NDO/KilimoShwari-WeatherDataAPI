class Policy < ApplicationRecord
    has_one :contracts, dependent: :destroy
    belongs_to :User
end
