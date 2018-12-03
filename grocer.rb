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
  reduced = cart.dup
  coupon_name = nil
  
  
  cart.each do |item, info|
    coupons.each do |coupon|
      
      cost = coupon[:cost] 
      number = coupon[:num]
        
      if coupon[:item] == item    
        coupon_name = "#{item} W/COUPON"
        reduced[item][:count] -= coupon[:num] 
      end
      
      if reduced.key?(coupon_name)
        reduced[coupon_name][:count] +=1
      else
        reduced[coupon_name] = {price: cost, :clearance => info[:clearance], count: 1 }
      end
    end
  end
  reduced
end


def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
