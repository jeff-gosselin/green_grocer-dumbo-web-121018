require 'pry'

# "AVOCADO W/COUPON" => {:price => 5.0, :clearance => true, :count => 1}

def consolidate_cart(cart)
  new_cart = {}

  cart.each do |sku|
    sku.each do |item, data|
      new_cart[item] = data

      if new_cart[item].has_key?(:count)
        new_cart[item][:count] += 1 
      else
        new_cart[item][:count] = 1
      end
  
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  coupon_name = nil
  cart.each do |item, info|
    coupons.each do |coupon|
        
      if coupon[:item] == item    
        coupon_name = "#{item} W/ COUPON"
      end
      
      
      unless cart.has_key?(coupon_name)
        cart[coupon_name] = {}
      end
      
    end
    
  end
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
