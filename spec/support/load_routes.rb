 RSpec.configure do |c|
          c.include Monologue::Engine.routes.url_helpers,
            :example_group => {
              :file_path => /\bspec\/integration\//
} end