module Analytics
  class Screenr

    def initialize(endpoint=nil)
      @endpoint = endpoint || Figaro.env.screenr_endpoint
    end

    def publish(collection, **data)
      send "publish_#{collection}", data
    end

    def publish_event(event)
      post '/api/event', event
    end

    private
    def post(path, data)
      RestClient.post "#{@endpoint}#{path}", data
    end
  end
end