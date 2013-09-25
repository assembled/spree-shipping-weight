module Spree
  module Calculator::Shipping
    class WeightRatePerOrder < ShippingCalculator
      
      preference :weight_cost_values, :text, :default => "1:5.00\n2:7.00\n5:10.00\n10:15.00\n100:50.00"
      preference :default_weight, :decimal, :default => 1

      attr_accessible :preferred_default_weight,
                      :preferred_weight_cost_values

      def self.description
        Spree.t :weight_rate_per_order
      end

      def self.register
        super
      end

      def available?(package)
        true
      end
    
      # def compute(object)
      #   return 0 if object.nil?
      #   case object
      #     when Spree::Order
      #       compute_order(object)
      #     when Spree::Shipment
      #       compute_order(object.order)
      #   end
      # end



      def compute_package(package)
        total_weight = total_weight(package.contents)
        weight_cost_table = weight_cost_to_hash(self.preferred_weight_cost_values)
        weight_class = weight_cost_table.keys.select { |w| total_weight <= w }.min
        weight_class = weight_cost_table.keys.max if weight_class.nil?
        shipping_costs = weight_cost_table[weight_class]

        shipping_costs = 0 if shipping_costs.nil?

        shipping_costs
      end
      
      private
      
      def weight_cost_to_hash(weight_cost_values)
        weight_cost_hash = {}
        weight_cost_values.split.each do |weight_cost_value|
          values = weight_cost_value.strip.split(':')
          weight_cost_hash[values[0].strip.to_f] = values[1].strip.to_f
        end
        weight_cost_hash
      end

      def total_weight(package_contents)
        weight = 0
        package_contents.each do |item|
          weight += item.quantity * (item.variant.weight || self.preferred_default_weight)
        end
        weight
      end
    end
  end
end