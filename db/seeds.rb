require "./models"


 t.string "title"
    t.string "author"
    t.string "content"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "images"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "birthday"
    t.string "first_name"
    t.string "last_name"
    t.string "email"

# in this file we can make use of our ActiveRecord models to create starter data
User.create(username: "catperry", password: "12345", )
Post.create(title: "The 10 Best Places to Mountain Bike", author: "Cat Perry", content: "Excursion travelblogger colorful pretty organized organized Travel. Whimsical simple cute darn, fun design adventure travelblogger clean simple webdesign clean. Website clean design Travel theme, website wanderlust simple design blogger fun theme. Theme colorful modern website fun excursion fun. Modern organized wanderlust, fun expedition Travel excursion clean website traveling.", user_id: 1, images: "<iframe width="1280" height="720" src="https://www.redbullcontentpool.com/embed/video/5aedac7a9d5ae70098a8b621?_=1525525635266" frameborder="0" allowfullscreen></iframe>")
Post.create(title: "Journey to the Center of the Earth", author: "Cat Perry", content: "Excursion design travelblogger website fun cute, modern whimsical blogger design blogger webdesign. Clean wanderlust cute organized travelblogger organized webdesign, excursion traveler Travel expedition. Adventure darn design design wanderlust blogger, clean theme adventure pretty. Simple travelblogger traveler darn simple design pretty. Blogger design design wanderlust fun wanderlust wanderlust design excursion whimsical, blogger wanderlust design Travel.", user_id: 1)
Post.create(title: "Tips for a Solo Female Traveler", author: "Cat Perry", content: "Design clean websites for the  expedition and wanderlusters within, organized design clean simple theme. Simple Travel adventure design expedition whimsical adventure, website website traveling clean design. Fun adventure adventure theme, modern fun website Travel design theme organized. Webdesign WordPress colorful expedition, Travel colorful darn design traveler darn organized darn fun theme. Organized organized website colorful colorful, traveler webdesign darn pretty fun colorful. Organized whimsical theme simple modern webdesign, clean webdesign design cute adventure colorful traveler. Darn WordPress whimsical traveler clean website, theme modern pretty clean traveling adventure. Simple theme Travel colorful, traveling clean design adventure colorful traveler traveler expedition. Colorful adventure modern, excursion design modern modern website whimsical wanderlust.", user_id: 1)
Post.create(title: "When the Earth Was Not Enough", author: "Cat Perry", content: "Dirty travelblogger wanderlust expedition blogger WordPress traveling. Whimsical pretty modern pretty expedition webdesign, simple fun blogger clean expedition traveling. Simple whimsical adventure clean cute adventure Travel cute, Travel blogger webdesign pretty webdesign colorful. Traveler clean clean theme expedition, traveling simple traveler website design travelblogger design webdesign travelblogger. Travelblogger expedition expedition clean darn, pretty pretty cute colorful design.", user_id: 1)
Post.create(title: "Travel Blog", author: "Cat Perry", content: "Excursion travelblogger colorful pretty organized organized Travel. Whimsical simple cute darn, fun design adventure travelblogger clean simple webdesign clean. Website clean design Travel theme, website wanderlust simple design blogger fun theme. Theme colorful modern website fun excursion fun. Modern organized wanderlust, fun expedition Travel excursion clean website traveling.", user_id: 1)


User.create(username: "lauren", password: "12345")
Post.create(title: "Look At Me I Travel", author: "Lauren", content: "Design clean website expedition wanderlust, organized design clean simple theme. Simple Travel adventure design expedition whimsical adventure, website website traveling clean design. Fun adventure adventure theme, modern fun website Travel design theme organized. Webdesign WordPress colorful expedition, Travel colorful darn design traveler darn organized darn fun theme. Organized organized website colorful colorful, traveler webdesign darn pretty fun colorful. Organized whimsical theme simple modern webdesign, clean webdesign design cute adventure colorful traveler. Darn WordPress whimsical traveler clean website, theme modern pretty clean traveling adventure. Simple theme Travel colorful, traveling clean design adventure colorful traveler traveler expedition. Colorful adventure modern, excursion design modern modern website whimsical wanderlust.

Traveling cute webdesign, design expedition simple webdesign traveler blogger cute Travel. Traveling colorful whimsical colorful, wanderlust colorful clean simple blogger website. Traveler design theme, traveler website theme organized modern clean excursion blogger colorful. Website fun fun cute theme WordPress excursion theme. Wanderlust simple traveling traveler adventure WordPress pretty, expedition organized fun colorful whimsical whimsical design. Adventure WordPress organized design modern whimsical whimsical pretty cute, theme webdesign adventure excursion. Expedition darn wanderlust simple design website, traveling website whimsical website Travel whimsical. Organized WordPress modern clean simple wanderlust organized simple. Expedition travelblogger Travel darn fun design website.", user_id: 5)
Post.create(title: "Make It So, Now Please", author: "Lauren", content: "Design clean website expedition wanderlust, organized design clean simple theme. Simple Travel adventure design expedition whimsical adventure, website website traveling clean design. Fun adventure adventure theme, modern fun website Travel design theme organized. Webdesign WordPress colorful expedition, Travel colorful darn design traveler darn organized darn fun theme. Organized organized website colorful colorful, traveler webdesign darn pretty fun colorful. Organized whimsical theme simple modern webdesign, clean webdesign design cute adventure colorful traveler. Darn WordPress whimsical traveler clean website, theme modern pretty clean traveling adventure. Simple theme Travel colorful, traveling clean design adventure colorful traveler traveler expedition. Colorful adventure modern, excursion design modern modern website whimsical wanderlust.", user_id: 5)

