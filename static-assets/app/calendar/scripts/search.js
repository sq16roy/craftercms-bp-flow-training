(function (angular) {
    'use strict';

    angular.module('search', ['MACControllers']);

    var element = document.getElementById('searchApp');
    if (element) {
        angular.bootstrap(element, ['search']);
    }

}) (angular);