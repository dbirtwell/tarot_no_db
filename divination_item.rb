# dinination_item.rb 

class DivinationItem

  attr_reader :id, :name, :meaning, :image

  def initialize(id, name, meaning, image)
    @id = id
    @name = name
    @meaning = meaning
    @image = image    
  end
  
  def to_s
    "#{@id} - #{@name} - #{@meaning}"
  end

end