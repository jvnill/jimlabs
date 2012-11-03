module SkillSet
  def skills
    {
      seo:                 true,
      rails:               %w[2.xx 3.xx],
      testing:             %w[rspec test/unit factory_girl],
      frontend:            %w[css sass jquery],
      templates:           %w[erb haml],
      deployment:          %w[nginx passenger apache],
      geolocation:         %w[geokit],
      index_search:        { sphinx: 'thinking_sphinx' },
      data_modeling:       true,
      authorization:       :cancan,
      authentication:      %w[devise clearance omniauth],
      background_jobs:     %w[delayed_job resque sidekiq],
      version_control:     :git,
      payment_gateways:    :active_merchant,
      scaling_and_caching: true,
      database_management: true
    }
  end

  def coding_environment
    {
      editor:           'vim',
      operating_system: 'Ubuntu'
    }
  end
end
