package services
import java.text.SimpleDateFormat

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
    public getEvents(startDateStr, endDateStr) {

        def results = null
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
        //def startDate = formatDateAsIso(formatter.parse(startDateStr))

        //def queryStatement = "content-type:\"/page/events\""
        def queryStatement = "content-type:\"/page/events\" AND startDate:[${startDateStr} TO *] AND endDate:[${endDateStr} TO *]"
        println queryStatement

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