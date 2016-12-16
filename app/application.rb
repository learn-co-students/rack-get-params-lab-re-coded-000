class Application
@@cart = []
@@items = ["Apples","Carrots","Pears"]
def call(env)
resp = Rack::Response.new
req = Rack::Request.new(env)

if req.path.match(/items/)
      @@items.each do |item|
      resp.write "#{item}\n"
      end
elsif req.path.match(/search/)
      search_item = req.params["q"]
      resp.write search_method(search_item)
      elsif req.path.match(/cart/) then
      if @@cart.empty? then
      resp.write "Your cart is empty"
      else
      @@cart.each do |item|
      resp.write "#{item}\n"
      end
      end
elsif req.path.match(/add/)
      item_to_add = req.params["item"]
      if @@items.include? item_to_add
      @@cart << item_to_add
      resp.write "added #{item_to_add}"
      else
      resp.write "We don't have that item!"
      end
else
resp.write "Path Not Found"
end
resp.finish
end
# ****************************************************
def search_method(search_item)
if @@items.include?(search_item)
return "#{search_item} is one of our items"
else
return "Couldn't find #{search_item}"
end
end
end
