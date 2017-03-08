require './gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    context 'when Normal Items' do
      it "sell_in > 0, sell_in -= 1 => decreases quality by 1" do
        items = [Item.new("some product", 5, 5)]
        gilded_rose = GildedRose.new(items)
        2.times {gilded_rose.update_quality}
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,3,3]
      end

      it "sell_in > 0, sell_in -= 1 => decreases quality by 1 BUT min=0" do
        items = [Item.new("some product", 5, 1)]
        gilded_rose = GildedRose.new(items)
        2.times {gilded_rose.update_quality}
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,3,0]
      end

      it "sell_in < 0, sell_in -= 1 => increases quality by 2" do
        items = [Item.new("some product", 0, 5)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,-1,3]
      end
    end

    context 'when "Aged brie"' do
      it "sell_in > 0, sell_in -= 1 => increases quality by 1" do
        items = [Item.new("Aged Brie", 5, 5)]
        gilded_rose = GildedRose.new(items)
        2.times {gilded_rose.update_quality}
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,3,7]
      end

      it "sell_in > 0, sell_in -= 1 => increases quality by 1 but max = 50" do
        items = [Item.new("Aged Brie", 5, 49)]
        gilded_rose = GildedRose.new(items)
        5.times {gilded_rose.update_quality}
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,0,50]
      end

      it "sell_in < 0, sell_in -= 1 => increases quality by 2" do
        items = [Item.new("Aged Brie", 0, 5)]
        gilded_rose = GildedRose.new(items)
        1.times {gilded_rose.update_quality}
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,-1,7]
      end
    end

    context 'when "Sulfuras"' do
      it "quality doesn't change with sell in date" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 2, 5)]
        gilded_rose = GildedRose.new(items)
        2.times {gilded_rose.update_quality}
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,2,5]
      end
    end

    context 'when "Backstage Passes"' do
      it "sell_in > 10, sell_in -= 1 => increases quality by 1" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 0)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,10,1]
      end

      it "sell_in > 10, sell_in -= 1 => increases quality by 1 BUT max=50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 50)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,10,50]
      end

      it "sell_in > 5 and <= 10, sell_in -= 1 => increases quality by 2" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 0)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,9,2]
      end

      it "sell_in > 5 and <= 10, sell_in -= 1 => increases quality by 2 BUT max=50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 49)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,9,50]
      end

      it "sell_in >= 0 and <= 5, sell_in -= 1 => increases quality by 3" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 0)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,4,3]
      end

      it "sell_in >= 0 and <= 5, sell_in -= 1 => increases quality by 3 BUT max=50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 49)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,4,50]
      end

      it "sell_in < 0 => quality is 0" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 5)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,-1,0]
      end
    end

    context 'when "Conjured Items"' do
      it "sell_in > 0, sell_in -= 1 => decreases quality by 2" do
        items = [Item.new("Conjured Mana Cake", 5, 5)]
        gilded_rose = GildedRose.new(items)
        2.times {gilded_rose.update_quality}
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,3,1]
      end

      it "sell_in > 0, sell_in -= 1 => decreases quality by 2 BUT min=0" do
        items = [Item.new("Conjured Mana Cake", 5, 1)]
        gilded_rose = GildedRose.new(items)
        2.times {gilded_rose.update_quality}
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,3,0]
      end

      it "sell_in < 0, sell_in -= 1 => increases quality by 4" do
        items = [Item.new("Conjured Mana Cake", 0, 5)]
        gilded_rose = GildedRose.new(items)
        gilded_rose.update_quality
        result = [gilded_rose.items[0].name,
                  gilded_rose.items[0].sell_in,
                  gilded_rose.items[0].quality]
        expect(result).to eq [items[0].name,-1,1]
      end
    end
  end
end
