
def articleService = applicationContext.get("articleService")

def keyword = params.keyword

if(!keyword) {
	response.setStatus(500)
	templateModel.err = "Keyword is Reuqired"
}

def results = articleService.performArticleSearch(keyword)

templateModel.matches = results.matches
templateModel.keyword = results.keyword
templateModel.highlighting = results.highlighting