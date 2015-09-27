class UpdateAllProductDescriptions < ActiveRecord::Migration
  def change
    descriptions = ['General admission for the weekend *sale 2 for $20',
                    'this is your general admission for the weekend',
                    'Have clean fun by playing some games',
                    'Dinner and a show!, Try to figure out who the murderer is',
                    'live dj, dance all night to music from today and yesterday',
                    'Recovery comedy show with 3 comedians including Mike D',
                    'Wind down with brunch, each table will receive a gift'
                  ]
    @products = Product.all.order(id: :asc)
    @products.each_with_index do |p, index|
      p.description = descriptions[index]
      p.save
    end
  end
end
