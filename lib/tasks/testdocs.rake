require 'rdoc/markup/to_html'

namespace :test do
  desc "Test the rdoc documentation before putting it up on github"
  task :docs do
    h = RDoc::Markup::ToHtml.new
    File.open('testdocs.html', 'w') {|f| f.write(h.convert(File.read('README.rdoc'))) }
    `firefox ./testdocs.html`
    File.delete("testdocs.html")
  end
end
