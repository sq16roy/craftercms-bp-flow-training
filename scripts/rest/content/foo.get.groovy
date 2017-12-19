import acme.Fox

def cart = [:]
cart.name = (params.name) ? params.name : "default"
cart.itemCount = 4
cart.goods =  [ "Apples", "Oranges", "Grapes", "Peaches" ]

cart.message = new Fox().speak()
<<<<<<< HEAD
cart.sum = 50 + 50 + 50
=======
cart.sum = 30 + 30 + 40
>>>>>>> d6eff240d253546b78a15ef39c10ca0930b479a9

return cart