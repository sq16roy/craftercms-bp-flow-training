if(request.requestURI.equals("/"))
	response.sendRedirect("/en")

def targetedContentService = applicationContext.get("targetedContentService")
def homepageScenarioItem = targetedContentService.getHomepageScenario(profile)

templateModel.homepageScenario = homepageScenarioItem

def mySum = 10 + 100 + 50
templateModel.mySum = mySum + 5

def queryStatement = "content-type:\"/component/alerts\""
def searchService = targetedContentService.getSearchService()
def query = searchService.createQuery()
query.setQuery(queryStatement)

def executedQuery = searchService.search(query)

def matches = [:]
matches.found = executedQuery.response.numFound
matches.events = executedQuery.response.documents
matches.query = queryStatement

results = matches.events
