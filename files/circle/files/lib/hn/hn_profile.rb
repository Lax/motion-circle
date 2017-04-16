module HN
  class Profile
    class << self
      include HN::Client
      include HN::Builder

      def login(username, password, &callback)
        client.post("HNH_Login".info_plist, acct: username, pw: password) do |result|
          if result.success? and profile
            profile_info(&callback) if callback
          else
            callback.call(false) if callback
          end
        end
      end

      def logout(&callback)
        hn_cookies.each do |c|
          NSHTTPCookieStorage.sharedHTTPCookieStorage.deleteCookie c
        end
        callback.call(true) if callback
      end

      def profile
        cookies['user'].split('&').first if cookies['user']
      end

      def profile_info(id=profile, &block)
        bget("HNH_Profile".info_plist, profile_builder, id: id, &block)
      end

      def profile_builder
        {
          user:
          {
            sel: [:query, 'form.profileform table'],
            collection:
            {
              uname:
              {
                sel: [[:query, 'tr > td > a.hnuser'], [:firstObject]],
                val: [:text]
              },
              uemail:
              {
                sel: [[:query, 'tr > td > input[name="uemail"]'], [:firstObject]],
                val: [:attribute, :value]
              }
            },
            # val: [:first]
          }
        }
      end

    end # self
  end # Profile
end # HN
