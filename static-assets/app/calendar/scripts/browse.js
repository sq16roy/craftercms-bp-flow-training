
(function (angular) {
    'use strict';

    // no states (url routing)
    var app = angular.module('browse', [
        'MACControllers', 'ui.router'
    ]);

    //routing
    app.config(function($urlRouterProvider, $stateProvider){

        $urlRouterProvider.otherwise('/');
        $stateProvider
            .state('browse',{
                url:'/?categories&q',
                templateUrl:'facetsTemplate',
                controller:'browseCtrl'
            });

    });

}) (angular);