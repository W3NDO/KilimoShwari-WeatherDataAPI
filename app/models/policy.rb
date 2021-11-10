class Policy < ApplicationRecord
    has_one :contracts, dependednt: :destroy
    belongs_to :User
end
