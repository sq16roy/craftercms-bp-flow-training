package services

/**
 * Event service
 */
public class EventService {

    private searchService
    public getSearchService() { return searchService }
    public setSearchService(service) { searchService = service }

    /**
     * Get Events for date range
     * @return returns Events
     */
    public getEvents(startDate, endDate) {

        def results = null
        def queryStatement = "content-type:\"/page/events\""

        def query = searchService.createQuery()
        query.setQuery(queryStatement)

        def executedQuery = searchService.search(query)

        def matches = [:]
        matches.found = executedQuery.response.numFound
        matches.events = executedQuery.response.documents
        matches.query = queryStatement

        results = matches.events

        return results
    }


}