package acme

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
}