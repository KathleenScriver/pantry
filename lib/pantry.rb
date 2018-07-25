class Pantry
  attr_reader :stock,
              :shopping_list,
              :cookbook

  def initialize
    @stock = {}
    @shopping_list = {}
    @cookbook = []
  end

  def stock_check(item)
    if @stock[item]
      @stock[item]
    else
      0
    end
  end

  def restock(item, quantity)
    if @stock[item]
      @stock[item] += quantity
    else
      @stock[item] = quantity
    end
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each do |item, quantity|
      if @shopping_list[item]
        @shopping_list[item] += quantity
      else
        @shopping_list[item] = quantity
      end
    end
  end

  def print_shopping_list
    list = @shopping_list.inject("") do |memo, item_quantity|
      memo += "* #{item_quantity[0]}: #{item_quantity[1]}\n"
    end.strip
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    possible_recipes.map do |recipe|
      recipe.name
    end
  end

  def possible_recipes
  @cookbook.find_all do |recipe|
    recipe.ingredients.all? do |item, quantity|
      @stock[item] >= quantity
      end
    end
  end

  def how_many_can_i_make
    # don't know...
    can_make = possible_recipes.map do |recipe|
      recipe.ingredients.map do |item, quantity|
        @stock[item] / quantity
      end.min
    end

  end
end
