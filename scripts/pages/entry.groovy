if(request.requestURI.equals("/"))
	response.sendRedirect("/en")

def targetedContentService = applicationContext.get("targetedContentService")
def homepageScenarioItem = targetedContentService.getHomepageScenario(profile)

templateModel.homepageScenario = homepageScenarioItem

def mySum = 10 + 100 + 50
templateModel.mySum = mySum + 5
