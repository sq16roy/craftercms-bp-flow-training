import acme.Fox

def cart = [:]
cart.name = (params.name) ? params.name : "default"
cart.itemCount = 4

cart.goods =  [ "Apples", "Oranges", "Grapes", "Peaches" ]

cart.message = new Fox().speak()

cart.sum = 50 + 50 + 50

cart.message2 = "Git is rad!"

cart.home = siteItemService.getSiteItem("/site/website/en/index.xml")


return cart