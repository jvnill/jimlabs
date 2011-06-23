desc 'Generate the landing page html'
task :generate_frontpage_html do
  require 'coderay'

  ['developer', 'me', 'skillset'].each do |file|
    code = File.read File.join(Rails.root, 'lib', 'frontpage', "#{file}.rb")
    page = CodeRay.scan code, :ruby
    File.open(File.join(Rails.root, 'lib', 'frontpage', "#{file}.html"), 'w') {|f| f.puts page.html(:wrap => :div)}
  end
end
