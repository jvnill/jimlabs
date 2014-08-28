class Enquiry < ActiveRecord::Base
  validates :name, :email, :message, presence: true
  validates :email, format: {
    with: /\A[A-Z0-9._%\-+]+@([A-Z0-9\-]+\.)+[A-Z]{2,4}\z/i,
    message: 'is not a valid email format',
    if: :email?
  }

  validate :name_format

  private

  def name_format
    errors.add :name, 'must only contain letters and spaces' if name.match /[^A-Za-z ]+/
  end
end
