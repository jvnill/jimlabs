class Enquiry < ActiveRecord::Base
  validates_presence_of :name, :email, :message
  validates_format_of :email,
                      :with => /^[A-Z0-9._%\-+]+@([A-Z0-9\-]+\.)+[A-Z]{2,4}$/i,
                      :message => 'is not a valid email format'

  validate :name_format

  def name_format
    errors.add :name, 'must only contain letters and spaces' if name.match /[^A-Za-z ]+/
  end
end
