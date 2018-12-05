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

# def apply_coupons(cart, coupons)
#   the_discount = {}
  
#   cart.each do |item, info|
#     coupons.each do |coupon|
      
    
#       if coupon[:item] == item && !the_discount.key?("#{coupon[:item]} W/COUPON") && info[:count] >= coupon[:num]
#         the_discount["#{coupon[:item]} W/COUPON"] = {:price => coupon[:cost], :count => 1, :clearance => info[:clearance]}
        
#         if coupon[:num] >= info[:count]
#         qty = coupon[:num] - info[:count]
#         cart[item][:count] = qty
#       else
#         qty = info[:count] - coupon[:num]
#         cart[item][:count] = qty
#       end
        
        
#       elsif coupon[:item] == item && the_discount.key?("#{coupon[:item]} W/COUPON") && info[:count] >= coupon[:num]
        
#         the_discount["#{coupon[:item]} W/COUPON"][:count] += 1
#         binding.pry
#         if coupon[:num] >= info[:count]
#         qty = coupon[:num] - info[:count]
#         cart[item][:count] = qty
#       else
#         qty = info[:count] - coupon[:num]
#         cart[item][:count] = qty
#       end
      

#       else  
#         return cart
#       end
      
#     end
#   end
#   cart.merge(the_discount)
# end

def apply_coupons(cart, coupons)
  reduced = cart.dup
  coupon_name = nil
  
  cart.each do |item, info|
    coupons.each do |coupon|
      
      if coupon[:item] == item  && reduced[item][:count] >= coupon[:num]
        
        coupon_name = "#{item} W/COUPON"
        reduced[item][:count] -= coupon[:num]
        
        if reduced.key?(coupon_name)
          reduced[coupon_name][:count] += 1
        else
          reduced[coupon_name] = {price: coupon[:cost], :clearance => info[:clearance], count: 1 }
        
        end
      end
    end
  end
  reduced
end



def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance] == true
      cart[item][:price] = cart[item][:price] - (cart[item][:price] * 0.2)
    end
  end
end


def checkout(cart, coupons)
  prices = []
  total = 0
  cart = consolidate_cart(cart)
  
    if cart.keys.size == 1 
      cart = apply_coupons(cart, coupons)
      if coupons.size == 0 
        cart = apply_clearance(cart)
      end
    end
    
    if cart.keys.size > 1 && coupons.size == 1
      cart = apply_coupons(cart, coupons)
      cart = apply_clearance(cart)
      
    end
    
    

  cart.each do |item, info|
    prices << info[:price]
    prices.each { |price| total += price }
    
  end
   if total > 100.0
     total -= (total * 0.1) 
   end
   total
end









# def checkout(cart, coupons)
#   prices = []
  
  
#   cart = consolidate_cart(cart)
#   cart.each do |hash|
#     hash.each do |item, info|
#       if coupons.empty? && info[:clearance] == false
#         prices << info[:price]
#         total = 0
#         prices.each { |price| total += price }
        
#         return total
#       end
#     end
#   end
#   # cart = 
#   # cart = apply_coupons(cart, coupons)
#   # apply_clearance(cart)
  
  
# end
