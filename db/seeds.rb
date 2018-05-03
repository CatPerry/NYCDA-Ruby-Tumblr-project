require "./models"

# in this file we can make use of our ActiveRecord models to create starter data
User.create(username: "catperry", password: "12345")
Post.create(title: "Travel Blog", author: "Cat Perry", content: "Cfjksdjfkl vjdk jskdfjkasld")
