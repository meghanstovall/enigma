class Key
  
  def self.create_key
    rand.to_s[2..6]
  end
end
