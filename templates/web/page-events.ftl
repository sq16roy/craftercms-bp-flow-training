<#include "/templates/system/common/cstudio-support.ftl" />

<!DOCTYPE html>
<html class="no-js">
    <head>
        <title>Dazzle</title>
        <#include "/templates/web/common/head.ftl" />
        <link rel="stylesheet" href="/static-assets/app/calendar/css/calendar.css" />
    </head>

    <body ng-app="mac.calendar">

        <#include "/templates/web/common/header.ftl" />

        <section class="main">
            <div ui-view />
        </section>

        <#include "/templates/web/common/footer.ftl" />  


        <!-- build:js(.) scripts/oldieshim.js -->
        <!--[if lt IE 9]>
        <script src="/static-assets/app/calendar/libs/es5-shim/es5-shim.js"></script>
        <script src="/static-assets/app/calendar//libs/json3/lib/json3.js"></script>
        <![endif]-->

        <!-- bower:js -->
        <script src="/static-assets/app/calendar/libs/jquery/jquery.js"></script>
        <script src="/static-assets/app/calendar/libs/angular/angular.js"></script>
        <script src="/static-assets/app/calendar/libs/angular-resource/angular-resource.js"></script>
        <script src="/static-assets/app/calendar/libs/angular-cookies/angular-cookies.js"></script>
        <script src="/static-assets/app/calendar/libs/angular-sanitize/angular-sanitize.js"></script>
        <script src="/static-assets/app/calendar/libs/angular-animate/angular-animate.js"></script>
        <script src="/static-assets/app/calendar/libs/angular-touch/angular-touch.js"></script>
        <script src="/static-assets/app/calendar/libs/angular-route/angular-route.js"></script>
        <script src="/static-assets/app/calendar/libs/angular-sanitize/angular-sanitize.js"></script>
        <script src="/static-assets/app/calendar/libs/angular-ui-router/release/angular-ui-router.js"></script>
        <script src="/static-assets/app/calendar/libs/angular-bootstrap/ui-bootstrap-tpls.js"></script>
        <script src="/static-assets/app/calendar/libs/jquery-ui/ui/jquery-ui.js"></script>
        <script src="/static-assets/app/calendar/libs/fullcalendar/fullcalendar.js"></script>
        <#--  <script src="/static-assets/app/calendar/libs/angular-fullcalendar/angular-fullcalendar.js"></script>  -->
        <script src="/static-assets/app/calendar/libs/angular-ui-calendar/src/calendar.js"></script>
        <script src="/static-assets/app/calendar/libs/moment/moment.js"></script>

        <script src="/static-assets/app/js/plugins.js"></script>
        <script src="/static-assets/app/js/jquery.easy-autocomplete.js"></script>
        <script src="/static-assets/app/js/main.js"></script>
        <!-- endbower -->
        <!-- endbuild -->

        <!-- build:js({.tmp,app}) static-assets/script/main.js -->
        <script src="/static-assets/app/calendar/scripts/controllers.js"></script>
        <script src="/static-assets/app/calendar/scripts/services.js"></script>
        <script src="/static-assets/app/calendar/scripts/calendar.js"></script>
        <!-- endbuild -->

        <@cstudioOverlaySupport/>
    </body>
</html>




