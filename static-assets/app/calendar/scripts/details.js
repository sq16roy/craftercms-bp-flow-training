
(function (angular) {
    'use strict';

    // no states (url routing)
    var app = angular.module('details', [
        'MACControllers', 'ui.router'
    ]);

    // routing
    app.config(function($urlRouterProvider, $stateProvider){
        $urlRouterProvider.otherwise('/');
        $stateProvider
            .state('details',{
                url:'/?id',
                templateUrl:'assetTemplate',
                controller:'detailsCtrl'
            });
    });

})(angular);