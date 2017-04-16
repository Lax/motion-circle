module HN
  class News
    class << self
      include HN::Builder

      def topstories(pager=nil, &block)
        bget(pager || 'news', stories_builder, &block)
      end

      def newstories(pager=nil, &block)
        bget(pager || 'newest', stories_builder, &block)
      end

      def beststories(pager=nil, &block)
        bget(pager || 'best', stories_builder, &block)
      end

      def askstories(pager=nil, &block)
        bget(pager || 'ask', stories_builder, &block)
      end

      def showstories(pager=nil, &block)
        bget(pager || 'show', stories_builder, &block)
      end

      def jobsstories(pager=nil, &block)
        bget(pager || 'jobs', stories_builder, &block)
      end

      def story(id, &block)
        bget('item', story_builder, id: id, &block)
      end

      def stories_builder
        {
          stories:
          {
            sel: [:query, '.itemlist .athing'],
            collection:
            {
              rank:
              {
                sel: [[:query, '.title .rank'], [:firstObject]],
                val: [[:text], [:chomp, '.']]
              },
              title:
              {
                sel: [[:query, '.title .storylink'], [:firstObject]],
                val: [:text]
              },
              url:
              {
                sel: [[:query, '.title .storylink'], [:firstObject]],
                val: [:attribute, :href]
              }
            }
          },
          more:
          {
            sel: [[:query, 'a.morelink'], [:firstObject]],
            val: [:attribute, :href]
          }
        }
      end

      def story_builder
        {
          title:
          {
            sel: [[:query, '.athing .title .storylink'], [:firstObject]],
            val: [:text]
          },
          from_site:
          {
            sel: [[:query, '.athing .title .sitebit.comhead a .sitestr'], [:firstObject]],
            val: [:text]
          },
          score:
          {
            sel: [[:query, '.subtext .score'], [:firstObject]],
            val: [[:text], [:chomp, ' points'], [:chomp, ' point']]
          },
          hnuser:
          {
            sel: [[:query, '.subtext .hnuser'], [:firstObject]],
            val: [:text]
          },
          comments:
          {
            sel: [[:query, '.subtext'], [:firstObject]],
            val: [[:text], [:strip], [:match, '[0-9]+ point[s].+ \| ([0-9]+) comment[s]'], [:to_a], [:fetch, 1]]
          }
        }
      end

    end # self
  end # Profile
end # HN
