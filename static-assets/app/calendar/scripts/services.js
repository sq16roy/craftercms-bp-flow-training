(function (angular) {
    'use strict';

    var app = angular.module('MACServices', []);

	var mode = 'local';
  	app.value('Constants',
  		(mode === 'dev') ? {
  		BASE: 'http://mac.vm.rivetlogic.com',
        SERVICE: '/static-assets/fixtures/'
        } : (mode === 'vm') ? {
        BASE: 'http://mac.vm.rivetlogic.com',
        SERVICE: 'http://mac.vm.rivetlogic.com/proxy/authoring/proxy/alfresco/marketing-asset-center/'
        } : (mode === 'local') ? {
        BASE: 'http://localhost:9090',
        SERVICE: 'http://localhost:8080/api/1/services/'
        } : {
        BASE: '',
        SERVICE: 'http://447af73b.ngrok.com/proxy/authoring/proxy/alfresco/marketing-asset-center/'
        });
      
    app.factory('AssetService', [
        '$http', 'Constants',
        function ($http, Constants) {

            function url(path) {
                return (Constants.SERVICE + path);
            }

            return {

                getThumbnail: function (asset, options) {
                    return Constants.SERVICE + 'rendition?id='+asset.id+'&resolution=300x150';
                },

                getPath: function () {
                    return Constants.SERVICE;
                },

                getFeaturedAssets: function () {
                    return $http({
                        url: url('search.json'),
                        method: 'GET'
                    }).then(function (response) {
                        return response.data.items;
                    });
                },

                /* Typeahead query */
                query: function (value) {
                    return $http.get(url('autocomplete.json'), {
                        params: { q: value }
                    }).then(function (response) {
                        return response.data.items;
                    });
                },

                /* Search query */
                search: function (keywords, filters) {

                    var params = {};

                    if (keywords) {
                        params.q = keywords;
                    }

                    if (filters) {
                        params.categories = filters;
                    }

                    return $http({
                        url: url('search.json'),
                        method: 'GET',
                        params: params,
                    }).then(function (response) {
                        return response.data.items;
                    });
                },

                /* Get asset details */
                getAsset: function (id) {
                    (!id) && (id = '');
                    return $http({
                        url: url('metadata.json'),
                        method: 'GET',
                        params:{id:id}
                    }).then(function(response){
                        return response.data;
                    });
                },

                getFacets: function () {
                    return $http({
                        url: url('facets.json'),
                        method: 'GET'
                    });
                },

                /* On assets details page, related assets */
                getRelatedAssets: function (id) {
                    return $http({
                        url: url('assetsRelated.json'),
                        method: 'GET'
                    });
                },

                /* Add to Binder */
                addToBinder: function (user, name, contentId) {
                    var params = {};

                    if (user) {
                        params.user = user;
                    }

                    if (name) {
                        params.name = name;
                    }

                    if (contentId) {
                        params.id = contentId;
                    }
                    
                    return $http({
                        url: url('add-to-binder.json'),
                        method: 'GET',
                        params: params
                    }).then(function(response){
                        return response.data;
                    });
                },

                /* Get Binders */
                getBinder: function (user) {
                    (!user) && (user = '');
                    return $http({
                        url: url('get-binders.json'),
                        method: 'GET',
                        params:{user:user},
                    }).then(function(response){ 
                        return response.data;

                    });
//                    var data = [{"binder":"Binder1","items":[{"id":"/static-assets/images/carousel-img-2.png"},{"id":"/static-assets/images/digital-exp-gradient.jpg"},{"id":"/static-assets/images/RL-mac-logo.png"}]},{"binder":"Binder2","items":[{"id":"/static-assets/images/digital-exp-gradient.jpg"},{"id":"/static-assets/images/carousel-img-1.png"},{"id":"/static-assets/images/RL-mac-logo.png"}]},{"binder":"Binder3","items":[{"id":"/static-assets/images/desktop.jpg"},{"id":"/static-assets/images/carousel-img-1.png"},{"id":"/static-assets/images/RL-mac-logo.png"}]},{"binder":"Binder4","items":[{"id":"/static-assets/images/digital-exp-gradient.jpg"},{"id":"/static-assets/images/carousel-img-1.png"},{"id":"/static-assets/images/desktop.jpg"}]},{"binder":"Binder5","items":[{"id":"/static-assets/images/digital-exp-gradient.jpg"},{"id":"/static-assets/images/carousel-img-1.png"},{"id":"/static-assets/images/RL-mac-logo.png"}]},{"binder":"Watch List","items":[{"id":"/static-assets/images/carousel-img-2.png"},{"id":"/static-assets/images/carousel-img-1.png"},{"id":"/static-assets/images/RL-mac-logo.png"}]}];
//                    return data;

                },

                /* Add Watch */
                addWatch: function (user,contentId) {
                    var params = {};

                    if (user) {
                        params.user = user;
                    }

                    if (contentId) {
                        params.id = contentId;
                    }
                    
                    return $http({
                        url: url('watch.json'),
                        method: 'GET',
                        params: params,
                    }).then(function(response){
                        return response.data;
                    });
                },

                /* Get Watch */
                getWatch: function () {
                    //(!user) && (user = '');
                    return $http({
                        url: url('get-watches.json'),
                        method: 'GET',
                        params:{user:'JOE'},
                    }).then(function(response){
                        return response.data;
                    });
                    /*var data = [{"id":"/static-assets/images/carousel-img-2.png"},{"id":"/static-assets/images/carousel-img-1.png"},{"id":"/static-assets/images/RL-mac-logo.png"}];
                    return data;*/
                },

                /* Add Preferences */
                updatePreferences: function (user,categories) {
                    var params = {};

                    if (user) {
                        params.user = user;
                    }

                    if (categories) {
                        params.categories = categories;
                    }
                    
                    return $http({
                        url: url('update-preferences.json'),
                        method: 'GET',
                        params: params,
                    }).then(function(response){
                        return response.data;
                    });
                },

                /* Get Preferences */
                getPreferences: function () {
                    //(!user) && (user = '');
                    return $http({
                        url: url('get-preferences.json'),
                        method: 'GET',
                        params:{user:'JOE'},
                    }).then(function(response){
                        return response.data;
                    });
                },

                /* Save Search */
                saveSearch: function (user, name, keywords, categories) {
                    var params = {};

                    if (user) {
                        params.user = user;
                    }

                    if (name) {
                        params.name = name;
                    }

                    if (keywords) {
                        params.keywords = keywords;
                    }

                    if (categories) {
                        params.categories = categories;
                    }
                    
                    return $http({
                        url: url('save-search.json'),
                        method: 'GET',
                        params: params,
                    }).then(function(response){
                        return response.data;
                    });
                },

                /* Get Saved Searches */
                getSaveSearches: function () {
                    //(!user) && (user = '');
                    return $http({
                        url: url('get-saved-searches.json'),
                        method: 'GET',
                        params:{user:'JOE'},
                    }).then(function(response){
                        return response.data;
                    });
                }

            }

        }
    ]);

})(angular); 