# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  start_date :date             not null
#  end_date   :date             not null
#  cat_id     :integer
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  VALID_STATUSES = ["PENDING", "APPROVED", "DENIED"]

  validates :start_date, :end_date, :cat_id, presence: true
  validates :status, inclusion: { in: VALID_STATUSES }
  validate  :validate_overlapping_requests

  belongs_to :cat

  def self.show_columns
    ["start_date","end_date", "status"]
  end

  def approve!
    self.status = 'APPROVED'
    transaction do
      save!
      requests_to_deny = overlapping_pending_requests
      requests_to_deny.each { |request| request.deny! }
    end
  end

  def deny!
    self.status = 'DENIED'
    save!
  end

  def pending?
    status == "PENDING"
  end

  private

  def all_overlapping_requests
    overlapping_requests_query = <<-SQL
      ((:id IS NULL OR id != :id))
      AND ((:start_date BETWEEN start_date AND end_date)
      OR (:end_date BETWEEN start_date AND end_date)
      OR (start_date BETWEEN :start_date AND :end_date)
      OR (end_date BETWEEN :start_date AND :end_date))
    SQL

    date_params = {id: id, start_date: start_date, end_date: end_date }

    cat
      .rental_requests
      .where(overlapping_requests_query, date_params)
  end

  def overlapping_approved_requests
    all_overlapping_requests.where("status = 'APPROVED'")
  end

  def overlapping_pending_requests
    all_overlapping_requests.where("status = 'PENDING'")
  end

  def validate_overlapping_requests
    if status == 'APPROVED' && overlapping_approved_requests.any?
      errors[:base] << "There is an overlapping rental."
    end
  end

end
