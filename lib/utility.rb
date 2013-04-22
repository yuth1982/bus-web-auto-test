module Utility
  def hash_to_object(hash, obj)
    hash.each do |k,v|
      obj.send("#{k}=", v)
    end
  end
end
