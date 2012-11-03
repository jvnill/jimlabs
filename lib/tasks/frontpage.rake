desc 'Generate the landing page html'
task :generate_frontpage_html do
  require 'coderay'

  %w[developer me skillset].each do |file|
    code = File.read Rails.root.join('lib', 'frontpage', "#{file}.rb")
    page = CodeRay.scan code, :ruby
    File.open(Rails.root.join('lib', 'frontpage', "#{file}.html"), 'w') do |f|
      f.puts page.html(wrap: :div)
    end
  end
end
