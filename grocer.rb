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
  the_discount = {}
  
  cart.each do |item, info|
    coupons.each do |coupon|
    
      binding.pry
      if coupon[:item] == item
        the_discount["#{coupons[0][:item]} W/COUPON"] = {:price => coupons[0][:cost], :count => 1, :clearance => info[:clearance]}
      else  
        return cart
      end
      
      if coupons[x.index][:num] >= info[:count]
        qty = coupons[0][:num] - info[:count]
        cart[item][:count] = qty
      else
        qty = info[:count] - coupons[0][:num]
        cart[item][:count] = qty
        
      end
    
    end
  end

  cart.merge(the_discount)
end

# def apply_coupons(cart, coupons)
#   reduced = cart.dup
#   coupon_name = nil
  
#   cart.each do |item, info|
#     coupons.each do |coupon|
      
#       if coupon[:item] == item  && reduced[item][:count] >= coupon[:num]
        
#         coupon_name = "#{item} W/COUPON"
#         reduced[item][:count] -= coupon[:num]
        
#       end
      
#       if reduced.key?(coupon_name) && reduced[item][:count] >= coupon[:num]
#         reduced[coupon_name][:count] += 1
#       else
#         reduced[coupon_name] = {price: coupon[:cost], :clearance => info[:clearance], count: 1 }
        
#       end
#     end
#   end
#   reduced
  

# end



def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
