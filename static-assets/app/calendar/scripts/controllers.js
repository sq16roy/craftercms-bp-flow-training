(function (angular) {
    'use strict';

    var app = angular.module('MACControllers', [
        'MACServices',
        'ui.bootstrap',
        'ui.router',
        'ngSanitize'
    ]);

    app.controller('searchCtrl', [
        '$scope', '$state', 'AssetService',
        function ($scope, $state, AssetService) {

            var Behaviours = {
                HOME    : 'home',
                BROWSE  : 'browse',
                DETAILS : 'details'
            };

            $scope.behaviour    = 'home';
            $scope.Behaviours   = Behaviours;
            $scope.notResults   = false;

            $scope.fetch = function(value) {
                return AssetService.query(value);
            };

            $scope.search = function () {

                var q = $scope.typeaheadSelection;

                if ($scope.behaviour === Behaviours.HOME || $scope.behaviour === Behaviours.DETAILS) {
                    window.location.href = '/browse#/?q=' + q;
                } else if ($scope.behaviour === Behaviours.BROWSE) {
                    $state.go('browse', { 'q': q }, { reload: true });
                }

            };

            $scope.typeaheadSearch = function ($item, $model, $label) {
                var model = $scope.typeaheadSelection;
                switch (model.type) {
                    case 'asset':
                        if ($scope.behaviour === Behaviours.HOME || $scope.behaviour === Behaviours.BROWSE) {
                            window.location.href = '/details.html#/?id=' + model.id;
                        } else if ($scope.behaviour === Behaviours.DETAILS) {
                            $state.go('details', { 'id': model.id }, { reload: false });
                        }
                        break;
                    case 'category':
                        if ($scope.behaviour === Behaviours.HOME || $scope.behaviour === Behaviours.DETAILS) {
                            window.location.href = '/browse#/?categories=' + model.id;
                        } else if ($scope.behaviour === Behaviours.BROWSE) {
                            $state.go('browse', { 'categories': model.id }, { reload: false });
                        }
                        break;
                }
            };

            setTimeout(function () {
                $scope.typeaheadSelection = ($state.params.q || '');
            }, 200);

            setTimeout(function () {
                $scope.typeaheadSelection = ($state.params.q || '');
            }, 600);

            setTimeout(function () {
                $scope.typeaheadSelection = ($state.params.q || '');
            }, 1000);

        }
    ]);

    app.controller('homeCtrl', [
        '$scope', '$state', 'AssetService',
        function ($scope, $state, AssetService) {

            AssetService.getFacets()
                .success(function (data) {

                    var categories = [];

                    for (var i = 0; i < data.length; i++) {
                        categories = categories.concat(data[i].children);
                    }

                    $scope.categories = categories;

                });

            AssetService.getFeaturedAssets()
                .then(function (data) {
                    $scope.featured = data;
                });

            $scope.thumbnail    = AssetService.getThumbnail;

        }
    ]);

    app.controller('detailsCtrl', [
        '$scope', '$state', '$stateParams', '$interpolate',
        'AssetService', 'Constants', '$window',
        function ($scope, $state, $stateParams, $interpolate,
                  AssetService, Constants, $window) {

            // It is the same for every asset rendered here
            // so it can be initialised once.
            var downloadLinkFn = null;
            var downloadLinkAb = null

            // View models
            $scope.options = {};

            // View actions
            $scope.getImageUrl  = getImageUrl;
            $scope.downloadUrl  = downloadUrl;
            $scope.shareUrl     = shareUrl;
            $scope.copyDownloadUrl = copyDownloadUrl;
            $scope.formatDate = formatDate;
            $scope.duration = duration;

            function duration(seconds) {
                return moment.duration(seconds, 'seconds').asMinutes() + ' minutes';
            }

            function url(asset, absolute) {

                if (!downloadLinkFn) {
                    downloadLinkFn = $interpolate(asset.downloadUrl || '');
                }

                var count = 0;
                angular.forEach($scope.options, function () {
                    count++;
                });

                return (count)
                    ? (absolute ? $window.location.origin : '') + downloadLinkFn($scope.options)
                    : '(share link not available)';

            }

            function shareUrl(asset) {
                return url(asset, true);
            }

            function copyDownloadUrl() {
                $('#downloadUrl').select();
            }

            function getImageUrl(asset) {
                return Constants.BASE + asset.imageUrl;
            }

            function downloadUrl(asset) {
                return url(asset);
            }

            function formatDate(date) {
                return moment(date).format('MMMM D, YYYY');
            }

            // services
            AssetService.getAsset($stateParams.id)
                .then(function (data) {

                    $scope.asset = data;

                    var options = $scope.asset.options;
                    angular.forEach(options, function (opt) {
                        if (!opt.values.length) {
                            opt.values.push({
                                "label" : "Original",
                                "value" : "original"
                            });
                        }
                        $scope.options[opt.code] = opt.values[0].value;
                    });

                });

        }
    ]);

    app.controller('relatedAssetsCtrl', [
        '$scope', '$state', '$location', '$http', '$stateParams', 'AssetService',
        function ($scope, $state, $location, $http, $stateParams, AssetService) {

            $scope.rate = 1;
            $scope.max = 5;
            $scope.isReadonly = false;
            $scope.searchValue = "";

            $scope.hoveringOver = function (value) {
                $scope.overStar = value;
                $scope.percent = 100 * (value / $scope.max);
            };

            AssetService.getRelatedAssets($stateParams.id).success(function (data) {
                $scope.assetRelatedList = data;
            });

        }
    ]);

    app.controller('browseCtrl', [
        '$scope', '$state', '$location', '$http', '$stateParams', 'AssetService', '$modal', '$log',
        function ($scope, $state, $location, $http, $stateParams, AssetService, $modal, $log) {

            // Asset Load
            AssetService.search(
                ($stateParams.q || ''),
                ($stateParams.categories || '')).then(function (data) {
                    assets = data;
                    findAllWatches();
                    paginate();
                });

            // Internal
            var assets = [];

            // View models
            $scope.max          = 5;
            $scope.isReadonly   = false;
            $scope.assets       = [];
            $scope.currentPage  = 1;
            $scope.itemsPerPage = 8;
            $scope.maxSize      = 5;

            // View actions
            $scope.thumbnail    = AssetService.getThumbnail;
            $scope.numPages     = getPageCount;
            $scope.totalItems   = totalItems;
            $scope.pageChanged  = paginate;
            $scope.pageStatus = getPageStatusText;

            function getPageStatusText(currentPage) {
                return ('Page ' + currentPage + ': Showing ' + $scope.assets.length + ' of ' + assets.length + ' items.');
            }

            function totalItems() {
                return assets ? assets.length : 0;
            }

            function getPageCount() {
                return assets ? Math.ceil(assets.length / $scope.itemsPerPage) : 0;
            }

            // TODO seding page from the view.
            // For what reason is the scope current page not getting updated?
            function paginate(page) {

                (!page) && (page = $scope.currentPage);
                if ($scope.currentPage !== page) {
                    console.log('$scope.currentPage ('+$scope.currentPage+') !== page ('+page+')');
                }

                if (assets) {

                    var begin = ((page - 1) * $scope.itemsPerPage),
                        end = begin + $scope.itemsPerPage;

                    $scope.assets = assets.slice(begin, end);

                }

            }

            $scope.addWatch = function(id, elt){

                $('#spinner').modal('show');

                AssetService.addWatch('JOE',id)
                    .then(function (data) {
                        //console.log('ready');   
                    });

                $('.'+elt).text("UNWATCH");

                $('#spinner').modal('hide');
            }

            AssetService.getWatch('JOE')
                .then(function (data) {
                    $scope.watches = data;
                });

            function findAllWatches(){
                //$scope.watch;
                /*AssetService.getWatch('JOE')
                 .then(function (data) {
                 $scope.watch = data;
                 });*/
                if($scope.watches) {
                    if($scope.watches[0] && $scope.watches[0].items) {
                        for(var i=0; i < $scope.watches[0].items.length; i++){
                            for(var j=0; j < assets.length; j++){
                                if($scope.watches[0].items[i].id == assets[j].id){
                                    assets[j].watch = true;
                                }
                            }
                        }
                    }
                }
            }

            $scope.openModal = function (contentId) {

                var modalInstance = $modal.open({
                    templateUrl: 'binder.html',
                    controller: 'binderCtrl',
                    size: 'sm',
                    resolve: {
                        contentId: contentId
                    }
                });

                modalInstance.result.then(function (selectedItem) {
                    $scope.selected = selectedItem;
                }, function () {
                    $log.info('Modal dismissed at: ' + new Date());
                });

            };

            $scope.openSaveSearchModal = function (contentId) {

                var modalInstance = $modal.open({
                    templateUrl: 'saveSearch.html',
                    controller: 'saveSearchCtrl',
                    size: 'sm',
                    resolve: {
                        contentId: function () {
                            return contentId;
                        }
                    }
                });

                modalInstance.result.then(function (selectedItem) {
                    $scope.selected = selectedItem;
                }, function () {
                    $log.info('Modal dismissed at: ' + new Date());
                });

            };

            $scope.viewOnCal = function () {
                var ids = [];
                angular.forEach(assets, function (asset) {
                    ids.push(encodeURIComponent(asset.id));
                });
                window.location.href = ('/calendar/#/weekly?id=' + ids.join(','));
            }

        }
    ]);

    app.controller('facetsCtrl', [
        '$scope', '$state', '$http', '$stateParams', 'AssetService',
        function ($scope, $state, $http, $stateParams, AssetService) {

            $scope.facetSelected = function () {

                var parents = $scope.facets;
                var selected = [];

                angular.forEach(parents, function (parent) {
                    angular.forEach(parent.children, function (item) {
                        (item.selected) && (selected.push(item.id));
                    });
                });

                $state.go('browse', {
                    categories: selected.join(',')
                }, {
                    reload: false
                });

            };

            AssetService.getFacets()
                .success(function (data) {

                    var ids = ($stateParams.categories || '').split(',');

                    angular.forEach(ids, function (id) {

                        for (var i = 0, j; i < data.length; i++) {

                            if (data[i].id === id) {

                                for (j = 0; j < data[i].children.length; j++) {
                                    data[i].children[j].selected = true;
                                }

                            } else {

                                for ( j = 0; j < data[i].children.length; j++) {
                                    if (data[i].children[j].id === id) {
                                        data[i].children[j].selected = true;
                                    }
                                }

                            }

                        }

                    });

                    $scope.facets = data;

                });

        }
    ]);

    app.controller('binderCtrl', [
        '$scope', '$modalInstance', 'AssetService', 'contentId',
        function ($scope, $modalInstance, AssetService, contentId) {

            resetBinder();
            fetchBinders();

            $scope.addToBinder = function (binder) {
                $scope.binder.name = binder.binder;
                addNewBinder();
            };

            $scope.addNewBinder = addNewBinder;

            function addNewBinder(){
                AssetService.addToBinder($scope.binder.userId, $scope.binder.name, $scope.binder.contentId)
                    .then(function (data) {
                        $modalInstance.close();
                    });
            }

            function fetchBinders() {
                AssetService.getBinder($scope.binder.userId)
                    .then(function (data) {
                        $scope.binders = data;
                    });
            }

            function resetBinder() {
                $scope.binder = {
                    name: '',
                    userId: 'Joe',
                    contentId: contentId
                };
            }

        }
    ]);

    app.controller('savedSearchesCtrl', function ($scope, AssetService) {

        $scope.selectedSearch = null;

        fetchStoredSearches();

        function fetchStoredSearches() {
            AssetService.getSaveSearches()
                .then(function (data) {
                    $scope.items = data;
                });
        }

        $scope.selectSaveSearch = function ($event) {

            var value = $('#savedSearchSelect').val();
            var item;

            for (var i = 0; i < $scope.items.length; ++i) {
                if (value === $scope.items[i].name) {
                    item = $scope.items[i];
                    break;
                }
            }

            var params = [];
            (item.keywords) && params.push('q=' + item.keywords);
            (item.categories) && params.push('categories=' + item.categories);

            window.location.href = (
                '/browse/#/' + (params.length ? '?' + params.join('&') : '')
            );
        };

    });

    app.controller('saveSearchCtrl', [
        '$scope', '$state', '$stateParams', 'AssetService', '$modalInstance',
        function ($scope, $state, $stateParams, AssetService, $modalInstance) {

            $scope.items = [];
            AssetService.getSaveSearches()
                .then(function (data) {
                    $scope.items = data;
                });

            function searchesTest(data) {
                $scope.items = data;
            }

            $scope.nameSaveSearch = '';
            $scope.saveSearch = function () {

                var name = $scope.nameSaveSearch;
                var keywords = ($stateParams.q || '');
                var categories = ($stateParams.categories || '');

                AssetService.saveSearch('JOE', name, keywords, categories)
                    .then(function (data) {
                        $modalInstance.close();
                    });

                AssetService.getSaveSearches()
                    .then(function (data) {
                        searchesTest(data);
                    });

            };

            $scope.selectSaveSearch = function (selectSearchLink) {
                var selectedearch = '';

                if(selectSearchLink){
                    selectedearch = selectSearchLink;
                }else{
                    selectedearch = $scope.selectSearch;
                }

                var aux = new Object();
                for(var i=0; i < $scope.items.length ; i++){
                    if(selectedearch == $scope.items[i].name){
                        aux.name= $scope.items[i].name;
                        aux.keywords= $scope.items[i].keywords;
                        aux.categories= $scope.items[i].categories;
                    }
                }

                console.log(window.location.protocol + "//" + window.location.host+'/browse#/?categories='+aux.categories+'&q='+aux.keywords);
                if(aux.keywords != null){
                    window.location = window.location.protocol + "//" + window.location.host+'/browse#/?categories='+aux.categories+'&q='+aux.keywords;
                }else{
                    window.location = window.location.protocol + "//" + window.location.host+'/browse#/?categories='+aux.categories;
                }
            };

        }
    ]);

    app.controller('DatepickerDemoCtrl', function($scope) {

        $scope.minDate = new Date();

        $scope.open = function($event) {
            $event.preventDefault();
            $event.stopPropagation();
            $scope.opened = true;
        };

        $scope.dateOptions = {
            formatYear: 'yy',
            startingDay: 1
        };

        $scope.format = 'MM/dd/yyyy';
    })

})(angular);