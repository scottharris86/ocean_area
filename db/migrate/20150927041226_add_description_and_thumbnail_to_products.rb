class AddDescriptionAndThumbnailToProducts < ActiveRecord::Migration
  def change
    add_column :products, :thumbnail, :string, default: 'Ticket.jpg'
    add_column :products, :description, :text
    images = ['bogo.jpg', 'Ticket.jpg', 'gameNight.jpg', 'murderMystery.jpg', 'Ticket.jpg', 'comedyShow.jpg', 'Ticket.jpg']
    descriptions = ['this is your general admission for the weekend *sale 2 for $20',
                    'this is your general admission for the weekend',
                    'have clean fun with your friends by playing some popular games',
                    'have dinner and a murder, each table will have a chance to figure out who the murderer is',
                    'live dj, dance all night to music from today and yesterday',
                    'this is an amazing recovery comedy show by 3 comedians including mike d',
                    'wind down the weekend with a late breakfast, each table will receive a gift'
                  ]
    @products = Product.all.order(id: :asc)
    @products.each_with_index do |p, index|
      p.thumbnail = images[index]
      p.description = descriptions[index]
      p.save
    end
  end
end
