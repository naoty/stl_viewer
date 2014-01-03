require "sinatra"
require "slim"
require "coffee-script"

module STLViewer
  class Application < Sinatra::Base
    get "/" do
      slim :index
    end

    get "/main.js" do
      coffee :main
    end
  end
end
