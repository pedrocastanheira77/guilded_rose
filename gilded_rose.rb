class GildedRose
  attr_reader :items

  MAX_QUALITY = 50
  MIN_QUALITY = 0

  def initialize(items)
    @items = items
  end

  def products(item)
    [ {product: "Aged Brie",                                 switcher: -1},
      {product: "Conjured Mana Cake",                        switcher: 2},
      {product: "Backstage passes to a TAFKAL80ETC concert", switcher: backstage_switcher(item)},
      {product: "Sulfuras, Hand of Ragnaros",                switcher: 0}]
  end

  def backstage_switcher(item)
    return -1 if item.sell_in > 10
    return -2 if (item.sell_in > 5 && item.sell_in <= 10)
    return -3 if (item.sell_in > 0 && item.sell_in <= 5)
    return 0
  end

  def update_quality
    @items.each do |item|
      index = products(item).index { |element| element[:product] == item.name }
      return implement_rule(item) if !index
      implement_rule(item, products(item)[index][:switcher])
    end
  end

  private

  def is_quality_outside_limits?(item)
    item.quality < MIN_QUALITY || item.quality > MAX_QUALITY
  end

  def set_quality_to_limit(item)
    item.quality = MIN_QUALITY if item.quality < MIN_QUALITY
    item.quality = MAX_QUALITY if item.quality > MAX_QUALITY
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end

  def main_rule(item, switcher, flag = 0)
    item.quality = item.quality - (1*switcher) if !is_quality_outside_limits?(item)
    set_quality_to_limit(item)
    if (item.sell_in <= 0 && flag == 0)
      main_rule(item, switcher,flag = 1)
    end
  end

  def implement_rule(item, switcher = 1)
    return set_quality_to_zero(item) if (switcher == 0 && item.name.include?("Backstage passes"))
    return if switcher == 0
    main_rule(item, switcher)
    update_sell_in(item) if !item.name.include?("Sulfuras")
  end

  def set_quality_to_zero(item)
    item.quality = 0
    update_sell_in(item)
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
