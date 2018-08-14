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
        //SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
        //def startDate = formatDateAsIso(formatter.parse(startDateStr))

        def queryStatement = "content-type:\"/component/event-component\""
        //def queryStatement = "content-type:\"/page/events\" AND startDate:[${startDateStr} TO *] AND endDate:[${endDateStr} TO *]"
        println queryStatement

        def query = searchService.createQuery()
        query.setQuery(queryStatement)

        def executedQuery = searchService.search(query)

        results = executedQuery.response.documents
        def modifiedResults = []
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.S'Z'");

        for (result in results){
            if(result.startDate != null){
                result.start = dateFormat.parse(result.startDate).getTime();
            }
            if(result.endDate != null) {
                result.end = dateFormat.parse(result.endDate).getTime();
            }
            modifiedResults.add(result)
        }

        return modifiedResults
    }

}