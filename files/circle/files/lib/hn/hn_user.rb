module HN
  class User
    class << self
      include HN::Builder

      def user_info(id, &block)
        bget('user', user_builder, id: id, &block)
      end

      def user_builder
        {
          uname:
          {
            sel: [[:query, 'a.hnuser'], [:firstObject]],
            val: [:text]
          }
        }
      end
    end # self
  end # Profile
end # HN
