require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include Asciidoctor

Asciidoctor::Extensions.register do
  if ENV['CI']
    if @document.basebackend? 'html'
      docinfo_processor do
        at_location :head
        process do |doc|
          '<script async src="https://stats.raden.solutions/script.js" data-website-id="e5a25886-8178-4d34-860f-f8cb9009a7e7"></script>'
        end
      end
    end
  end
end
