module HN
  module Builder
    include HN::Client

    def bget(url="", builder=stories_builder, attrs={}, &block)
      client.get(url, attrs) do |result|
        if result.success?
          doc = Motion::HTML.parse(result.object.to_s)

          build(doc, builder).tap {|tar| block.call tar if block }
        end
      end
    end

    private

    def build(node, sels)
      tar = {}
      sels.each do |name, sel|
        if sel[:sel]
          tar[name] = node.psend sel[:sel]
        else
          tar[name] = node
        end

        if sel[:collection] and sel[:collection].size > 0
          tar[name] = tar[name].map do |item_node|
            build(item_node, sel[:collection])
          end if tar[name]
        elsif sel[:child] and sel[:child].size > 0
          tar[name] = build(tar[name], sel[:child])
        end

        if sel[:val]
          tar[name] = tar[name].psend sel[:val] if tar[name]
        end

      end

      tar
    end

  end # Builder
end
