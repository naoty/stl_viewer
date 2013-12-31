require "sinatra"
require "slim"

module STLViewer
  class Application < Sinatra::Base
    get "/" do
      slim :index
    end
  end
end
