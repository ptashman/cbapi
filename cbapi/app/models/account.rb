class Account < ActiveRecord::Base
  has_many :comments
  validates :name, presence: true

  scope :top_performing, -> { where("total_spent > ?", 1000000) }
  scope :delinquent, -> { where("due_date < ?", DateTime.now) } do
    def send_to_collections
      each { |a| a.update_attribute(:in_collections, true) }
      puts "Sent to collections!"
    end
  end
end
