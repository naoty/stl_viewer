require "sinatra"
require "slim"

module STLPreviewer
  class Application < Sinatra::Base
    get "/" do
      slim :index
    end

    get "/style.css" do
      sass :style
    end
  end
end
