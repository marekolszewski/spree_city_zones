module Spree
  TaxRate.class_eval do
    # Gets the array of TaxRates appropriate for the specified order
    def self.match(order)
      return [] unless order.tax_zone
      [where(:zone_id => order.tax_zone.id).first].compact
      # all.select do |rate|
      #   rate.zone == order.tax_zone || rate.zone.contains?(order.tax_zone) || rate.zone.default_tax
      # end
    end

    #def self.match(address)
    #  rates = TaxRate.all.select { |rate| rate.zone.include? address }
    #  if rates.length > 1
    #    zone_kinds = rates.map { |rate| rate.zone.kind }.uniq
    #    if zone_kinds.include?('city')
    #      rates = rates.select { |rate| rate.zone.kind == 'city' }
    #    end
    #  end
    #  rates
    #end

    def adjust(order)
      label = "#{tax_category.name} #{"%.2f" % (amount * 100)}%"
      if included_in_price
        if Zone.default_tax.contains? order.tax_zone
          order.line_items.each { |line_item| create_adjustment(label, line_item, line_item) }
        else
          amount = -1 * calculator.compute(order)
          label = I18n.t(:refund) + label
          order.adjustments.create({ :amount => amount,
                                   :source => order,
                                   :originator => self,
                                   :locked => true,
                                   :label => label }, :without_protection => true)
        end
      else
        create_adjustment(label, order, order)
      end
    end
  end
end
