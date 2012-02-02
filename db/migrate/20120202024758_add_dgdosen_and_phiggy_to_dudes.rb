class AddDgdosenAndPhiggyToDudes < ActiveRecord::Migration
  def change
      Dude.create!(name: "Daniel Dosen", email:  "daniel@danieldosen.org", bio: "Ex MSer focused on Ruby/Rails/Node/Backbone/iOS development in a lean way... ", website: "http://danieldosen.org", ruby_gems_id: "dgdosen")
      Dude.create!(name: "Pete Higgins", email:  "pete@peterhiggins.org", bio: "I'm a full-time professional ruby developer and a part-time amateur rubyist. I live in seattle and I like ruby, linux and lowercase.", website: "http://beginrescue.blogspot.com", ruby_gems_id: "phiggy")
  end
end
