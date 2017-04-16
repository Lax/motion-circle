module HN
  module Client

    def client
      @client = AFMotion::SessionClient.build('HNH_Base'.info_plist) do
        session_configuration :default
        header "Accept", "text/html"
        response_serializer :http
      end
    end

    private

    def hn_cookies
      NSHTTPCookieStorage.sharedHTTPCookieStorage.cookiesForURL("HNH_Base".info_plist.nsurl)
    end

    def cookies
      Hash[hn_cookies.map {|c| [c.name, c.value]}]
    end

  end # Client
end # HN
