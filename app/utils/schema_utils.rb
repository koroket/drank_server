# encoding: utf-8
module SchemaUtils
  require 'nokogiri'

  # Get drinks
  def self.create_drinks
    doc = Nokogiri::HTML(open('http://www.in-the-spirit.co.uk/cocktails/browse_cocktails.php?type=thb'))
    drinks = doc.css("#all").last.css('.show_drink').each do |drink|
      id = drink.css('.text').last.at('a')[:href].split('?').last.split('id=').last
      name = drink.at('.text').text().gsub("\n",'')
      drink = Drink.find_or_create_by(site_id: id, name: name, img_url: 'http://www.in-the-spirit.co.uk/cocktails/images/cocktails/full/' + id)

      drink_doc = Nokogiri::HTML(open('http://www.in-the-spirit.co.uk/cocktails/view_cocktail.php?id=' + id))
      ingredients = drink_doc.css('.ingredients').css('tr').drop(1).each do |i|
        amount = i.at('td').text()
        iname = i.at('a').text()
        ingredient = Ingredient.find_or_create_by(name: iname)
        DrinkIngredient.find_or_create_by(ingredient_id: ingredient.id, drink_id: drink.id, amount: amount)
      end
      # drink_doc.css('.ingredients').css('tr').drop(1).first.at('td').text() #amount
      # drink_doc.css('.ingredients').css('tr').drop(1).first.at('a').text() #ingedient
    end
  end

  # remove drinks
  def self.remove
    Drink.all.each do |drink|
      drink.destroy
    end
  end
end

# drink
# img, name, site_id
# ingedient
# name
# drinkIngredient - discription

#      SchemaUtils.create_drinks
#      SchemaUtils.remove