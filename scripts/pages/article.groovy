//import groovy.json.JsonSlurper 


def foo = []

if(contentModel.arrayContent.text.equals("Cars")) {
	foo = [ "Ford", "Honda", "Chevy" ]
}
else {
	foo = [ "green", "brown", "black" ]
}






def storeMacros = siteItemService.getSiteItem("/site/components/macros/store-macros.xml")
logger.info("######" + storeMacros["internal-name"].text)


templateModel.body = contentModel.bodyContent.text.replace("[COMPANY_NAME]", contentModel.companyName.text)


templateModel.colors = foo
templateModel.stuff = new HashMap()

templateModel.stuff.body = ""

/*
foo[0] = foo[0] + " " + contentModel.title.text
foo[1] = foo[1] + "  " + params.count




def url = "https://jsonplaceholder.typicode.com/posts/1"
 
def apiResult = url.toURL().text
def jsonSlurper = new JsonSlurper()

templateModel.stuff = jsonSlurper.parseText(apiResult) 
      

logger.info(apiResult)
*/

templateModel.myDate = new Date()