module SkillSet
  def self.skills
    {
      :scaling_and_caching => true,
      :database_management => true,
      :data_modeling       => true,
      :rails               => ['2.xx', '3.xx'],
      :templates           => ['erb', 'js', 'haml'],
      :payment_gateways    => 'Active Merchant',
      :authentication      => ['Devise', 'Restful Authentication', 'Omniauth'],
      :authorization       => ['CanCan'],
      :background_jobs     => ['Delayed Job', 'Resque', 'Rufus Scheduler'],
      :version_control     => ['git', 'svn'],
      :frontend            => ['css/sass', {'javascript' => 'jquery'}],
      :index_search        => [{'sphinx' => 'thinking_sphinx'}],
      :geolocation         => 'Geokit',
      :workflow_engine     => 'ruote_rest',
      :testing             => ['cucumber', 'capybara', 'rspec', 'steak', 'selenium'],
      :seo                 => true,
      :deployment          => ['Nginx', 'Passenger', 'Apache']
    }
  end

  def self.coding_environment
    {
      'OS'    => ['Ubuntu', {'Windows' => 'Cygwin'}],
      :editor => 'vim'
    }
  end
end
