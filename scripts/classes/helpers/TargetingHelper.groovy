package helpers

/**
 * Targeting rules helper
 */
public class TargetingHelper {

    /**
     * get the homepage scenario with the best fit for the given profile
     * @param Profile of the current user
     */
    public determineSeason(profile) {
        return profile.attributes.season
    }
}