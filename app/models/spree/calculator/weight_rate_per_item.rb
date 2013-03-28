module Spree
  class Calculator::WeightRatePerItem < Calculator
    preference :apply_to_individual_items, :boolean
    preference :weight_cost_values, :text, :default => "1:5.00\n2:7.00\n5:10.00\n10:15.00\n100:50.00"
    preference :default_weight, :decimal, :default => 1

    attr_accessible :preferred_apply_to_individual_items,
                    :preferred_default_weight,
                    :preferred_weight_cost_values

    def self.description
      I18n.t :weight_rate_per_item
    end

    def self.register
      super
    end

    def available?(order)
      true
    end

    
    def compute(object)
      return 0 if object.nil?
      case object
        when Spree::Order
          compute_order(object)
        when Spree::Shipment
          compute_order(object.order)
      end
    end

    private

    def compute_order(order)
      shipping_costs = 0
      
      weight_cost_table = weight_cost_to_hash(self.preferred_weight_cost_values)
      
      puts "=================== computer_order : weight_rate_per_item ================="
      puts "order_id: #{order.id}"
      
      if self.preferred_apply_to_individual_items
        order.line_items.each do |item|
          item_weight = item.variant.weight || self.preferred_default_weight
          weight_class = weight_cost_table.keys.select { |w| item_weight <= w }.min
          weight_class = weight_cost_table.keys.max if weight_class.nil?
          puts "--------------"
          puts "item_weight = #{item_weight}"
          puts "item.quantity: #{item.quantity}"
          puts "weight_class: #{weight_class}"
          puts "weight_cost_table[weight_class]: #{weight_cost_table[weight_class]}"
          puts "#{weight_cost_table.inspect}"
          shipping_costs += item.quantity * weight_cost_table[weight_class] 
          puts "shipping costs: #{shipping_costs}"
        end
      else
        order.line_items.each do |item|
          item_weight = item.quantity * (item.variant.weight || self.preferred_default_weight)
          weight_class = weight_cost_table.keys.select { |w| item_weight <= w }.min
          weight_class = weight_cost_table.keys.max if weight_class.nil?
          puts "--------------"
          puts "item_weight = #{item_weight}"
          puts "item.quantity: #{item.quantity}"
          puts "weight_class: #{weight_class}"
          puts "weight_cost_table[weight_class]: #{weight_cost_table[weight_class]}"
          puts "#{weight_cost_table.inspect}"
          shipping_costs += weight_cost_table[weight_class]
          puts "shipping costs: #{shipping_costs}"
        end
      end

      shipping_costs
    end

    def weight_cost_to_hash(weight_cost_values)
      weight_cost_hash = {}
      weight_cost_values.split.each do |weight_cost_value|
        values = weight_cost_value.strip.split(':')
        weight_cost_hash[values[0].strip.to_f] = values[1].strip.to_f
      end
      weight_cost_hash
    end

  end
end
