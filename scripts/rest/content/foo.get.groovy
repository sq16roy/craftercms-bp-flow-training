import acme.Fox

def cart = [:]
cart.name = (params.name) ? params.name : "default"
cart.itemCount = 100 + 50

cart.goods =  [ "Grapes 2", "Oranges", "Grapes", "Peaches", "Plums", "Apples" ]

cart.myContent = siteItemService.getSiteItem("/site/website/en/index.xml")



return cart