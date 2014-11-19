module Spree
  class Calculator::SingleRate < Calculator
    preference :amount, :decimal, :default => 0
    preference :currency, :string, :default => Spree::Config[:currency]

    attr_accessible :preferred_amount, :preferred_currency

    def self.description
      I18n.t :single_rate
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
      self.preferred_amount / order.suppliers.count
    end
  end
end