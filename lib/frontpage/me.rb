class Me < Developer
  # I'm Jim Ruther Nill
  #   - a full time Ruby on Rails Developer
  #   - currently staying in Pasig City, Philippines
  #   - proud husband to a great children's book illustrator
  include SkillSet

  belongs_to :mhs_real_pty_ltd, :as => :current_employer

  def ruby_on_rails_experience
    working_with_rails.since '2008-05-01'
  end
end
