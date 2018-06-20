import acme.Fox

def cart = [:]
cart.name = (params.name) ? params.name : "default"
cart.itemCount = 100 + 50

cart.goods =  [ "Starfruit", "Oranges", "Grapes", "Peaches", "Plums", "Apples" ]

cart.myContent = [:]
cart.myContent.headline = siteItemService.getSiteItem("/site/website/en/index.xml").queryValue("headline")
cart.myContent.subheadline = siteItemService.getSiteItem("/site/website/en/index.xml").queryValue("subHeadline")
cart.myContent.dateline = siteItemService.getSiteItem("/site/website/en/services/index.xml").queryValue("dateline")



return cart