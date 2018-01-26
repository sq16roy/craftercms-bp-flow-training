package services

/**
 * Service contains simple targeting rules
 */
public class TargetedContentService {

    private searchService
    public getSearchService() { return searchService }
    public setSearchService(service) { searchService = service }

    private siteItemService
    public getSiteItemService() { return siteItemService }
    public setSiteItemService(service) { siteItemService = service }

    /**
     * get the homepage scenario with the best fit for the given profile
     * @param Profile of the current user
     */
    public getHomepageScenario(profile) {
        /* determine season for profile's locale */
        def season = "spring"
        def defaultScenarioId = "/site/components/homepage-scenarios/9df1c3bc-c7f8-71e2-8b28-aa5c55872dc5.xml"
        def queryStatement = 'content-type:"/component/home-page-scenario" ' +
                              'AND ((seasons.item.key:"'+ season + '") OR localId:"' + defaultScenarioId + '")'

        System.out.println(queryStatement)
        def query = searchService.createQuery()
        query.setQuery(queryStatement)
        query.setRows(1)

        // execute query
        def executedQuery = searchService.search(query)

        // get the result
        def result = executedQuery.response.documents[0]

        def homepageScenarioItem = siteItemService.getSiteItem(result.localId)

        return homepageScenarioItem
    }
}