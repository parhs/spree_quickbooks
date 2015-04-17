module SpreeQuickbooks
  module Sync
    class Variant
      attr_reader :variant_changes

      def initialize(variant_changes)
        @variant_changes = variant_changes
      end

      def perform
        service = SpreeQuickbooks::Services::Item.new
        sku_was, new_sku = variant_changes
        item = service.find_by_sku(sku_was)
        service.update(item, {name: new_sku})
      end

    end
  end
end