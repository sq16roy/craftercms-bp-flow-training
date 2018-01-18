import acme.Fox

def cart = [:]
cart.name = (params.name) ? params.name : "default"
cart.itemCount = 100 + 50

cart.goods =  [ "Apples", "Oranges", "Grapes", "Peaches", "Plums" ]



return cart