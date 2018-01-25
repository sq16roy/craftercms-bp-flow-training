package services

/**
 * artticle service simplified access to Artilce queries
 */
public class ArticleService {

    private searchService
    public getSearchService() { return searchService }
    public setSearchService(service) { searchService = service }

    /**
     * Get suggestions for given keyword
     * @param keyword
     */
    public getSuggestedTerms(keyword) {
        def queryStatement = 'content-type:"/page/article"'

        def query = searchService.createQuery()
        query.setQuery(queryStatement)
        query.addParam("facet","on")
        query.addParam("facet.field","bodyContent")

        if(keyword) {
            query = query.addParam("facet.prefix", keyword.toLowerCase())
        }

        // execute query
        def executedQuery = searchService.search(query)

        // build suggestions
        def terms = executedQuery.facet_counts.facet_fields['bodyContent']

        def suggestions = []

        terms.each { term ->
            if(term.value > 0) {
                suggestions.add(term.key);
            }
        }

        return suggestions
    }

    /**
     * Run Article Seach
     * @param keyword
     */
    public performArticleSearch(keyword) {

        def result = [:]
        def queryStatement = 'content-type:"/page/article"'

        if(keyword) {
            queryStatement += " AND bodyContent:\"$keyword\""
        }

        def query = searchService.createQuery()
        query.setQuery(queryStatement)
        query.addParam("hl", "true")
        query.addParam("hl.fl", "bodyContent")
        query.addParam("hl.simple.pre", "<strong>")
        query.addParam("hl.simple.post", "</strong>")

        def executedQuery = searchService.search(query)
        def items = executedQuery.response.documents

        result.matches = items
        result.keyword = (keyword) ? keyword : ""
        result.highlighting = executedQuery.highlighting

        return result
    }

    /**
     * Get all articles for a given topic
     * @param topicId
     * @return return a list of folders or null if non found
     */
    public getArticlesForTopic(topicId) {

        def results = null
        def queryStatement = "content-type:\"/page/item-article\" AND topic:\"${topicId}\""

        def query = searchService.createQuery()
        query.setQuery(queryStatement)

        def executedQuery = searchService.search(query)

        def matches = [:]
        matches.found = executedQuery.response.numFound
        matches.articles = executedQuery.response.documents
        matches.query = queryStatement

        results = matches.articles

        return results
    }

    /**
     * Get the specific article for the given ID
     * @param articleId
     * @return return article or null if not found
     */
    public getArticleForId(articleId) {

        def results = null

        def queryStatement = "localId:\"" + articleId + "\""

        def query = searchService.createQuery()
        query.setQuery(queryStatement)

        def executedQuery = searchService.search(query)

        def matches = [:]
        matches.found = executedQuery.response.numFound
        matches.article = executedQuery.response.documents
        matches.query = queryStatement
        results = matches.article[0]

        return results
    }

}