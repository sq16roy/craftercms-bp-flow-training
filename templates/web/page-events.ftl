<#include "/templates/system/common/cstudio-support.ftl" />
<#import "/templates/web/layouts/default.ftl" as layout/>

   <!DOCTYPE html>
    <!--[if lt IE 7]>
    <html class="no-js lt-ie10 lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
    <!--[if IE 7]>
    <html class="no-js lt-ie10 lt-ie9 lt-ie8"> <![endif]-->
    <!--[if IE 8]>
    <html class="no-js lt-ie10 lt-ie9"> <![endif]-->
    <!--[if IE 9]>
    <html class="no-js lt-ie10"> <![endif]-->
    <!--[if gt IE 9]><!-->
    <html class="no-js"> <!--<![endif]-->
    <head>

        <meta charset="utf-8">
        <title>${model.title!"Welcome ~ Marketing Asset Center"}</title>
        <meta name="description" content="${model.description!""}"/>
        <meta name="keywords" content="${model.keywords!""}"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link rel="shortcut icon" type="image/ico" href="/a/favicon.ico"/>

        <#if siteContext.overlayCallback??>
        <link rel="stylesheet" href="/static-assets/styles/studio.css">
        </#if>
        
        <!-- build:css(.) styles/vendor.css -->
        <!-- bower:css -->
        
        <!-- endbower -->
        <!-- endbuild -->

        <!-- build:css(.tmp) styles/main.css -->
        <link rel="stylesheet" href="/static-assets/libs/fullcalendar/fullcalendar.css" />
        <link rel="stylesheet" href="/static-assets/libs/fontawesome/css/font-awesome.css" />
        <link rel="stylesheet" href="/static-assets/styles/main.css">
        <link rel="stylesheet" href="/static-assets/styles/home.css" />
        <!-- endbuild -->

    </head>
    <#if ngApp = "">
    <body>
    <#else>
    <body ng-app="${ngApp}">
    </#if>

        <!--[if lt IE 7]>
        <p class="browsehappy">
            You are using an <strong>outdated</strong> browser.
            Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.
        </p>
        <![endif]-->
        <#if model.siteh?? && model.siteh.item?? >
           <@renderComponent component = model.siteh.item />
        <#else>
           <@renderComponent componentPath="/site/components/common/header.xml" />     
        </#if>

        <section class="main">


<script type="text/ng-template" id="templates/calendar-skeleton.html">
    <article ng-if="!multiMode && asset" class="asset-panel">
        <div class="container">
            <img ng-src="/api/1/services/rendition.json?id={{asset.id}}&resolution=300x150"
                 class="image"/>
            <div class="content">
                <hgroup class="title-section">
                    <h1 class="title">{{asset.title}}</h1>
                    <p>{{asset.rating}} {{formatDate(asset.releaseDateUS)}} | {{duration(asset.duration)}}</p>
                </hgroup>
                <section class="asset-metadata">
                    <div class="row">
                        <div class="col-sm-6">
                            <dl>

                                <dt>U.S. Release Date:</dt>
                                <dd>{{formatDate(asset.releaseDateUS)}}</dd>

                                <dt>In-Home Release:</dt>
                                <dd>{{formatDate(asset.releaseDateHome)}}</dd>

                                <dt>Director(s):</dt>
                                <dd>
                                        <span ng-repeat="i in asset.directors">
                                            <a href="/browse.html#/?categories={{i.id}}">{{i.label}}</a>
                                        </span>
                                </dd>

                                <dt>Producer(s):</dt>
                                <dd>
                                        <span ng-repeat="i in asset.producers">
                                            <a href="/browse.html#/?categories={{i.id}}">{{i.label}}</a>
                                        </span>
                                </dd>

                                <dt>Cast:</dt>
                                <dd>
                                        <span ng-repeat="i in asset.cast">
                                            <a href="/browse.html#/?categories={{i.id}}">{{i.label}}</a>
                                        </span>
                                </dd>

                                <dt>Genre:</dt>
                                <dd>
                                        <span ng-repeat="i in asset.genre">
                                            <a href="/browse.html#/?categories={{i.id}}">{{i.label}}</a>
                                        </span>
                                </dd>

                            </dl>
                        </div>
                        <div class="col-sm-3">
                            <h2>Marketing Campaign</h2>
                            <dropdown class="dropdown">
                                <dropdown-toggle class="dropdown-toggle btn btn-default">
                                    Overviews <b class="caret"></b>
                                </dropdown-toggle>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a>Calendar &amp; Milestones</a>
                                        <a>Living Doc</a>
                                    </li>
                                </ul>
                            </dropdown>
                        </div>
                        <div class="col-sm-3">
                            <h2>Links</h2>
                            <a href="javascript:">Offcial Website</a>
                            <div class="social">
                                <ul class="list-inline">
                                    <li class="fa fa-facebook-square"><a href="javascript:"></a></li>
                                    <li class="fa fa-twitter-square"><a href="javascript:"></a></li>
                                    <li class="fa fa-youtube-square"><a href="javascript:"></a></li>
                                    <li class="fa fa-tumblr-square"><a href="javascript:"></a></li>
                                    <li class="fa fa-pinterest-square"><a href="javascript:"></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <button class="toggle" onclick="$(this).parent().toggleClass('collapsed')">
            <span class="sr-only">Toggle Panel</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
    </article>
    <div class="container main-child">
        <div class="breadcrumbs">
            <ul>
                <li><a href="/">Home</a></li>
                <li ng-if="asset"><a href="/details/#/id={{asset.id}}">{{asset.title}}</a></li>
                <li><a href="javascript:">Calendar &amp; Milestones</a></li>
            </ul>
        </div>
        <div class="calendar-container">
            <header>
                <h2 class="title">Calendar &amp; Milestones</h2>
                <div class="view-switcher">
                    <dropdown class="dropdown">
                        <dropdown-toggle class="dropdown-toggle btn btn-default">
                            {{view.label}} <b class="caret"></b>
                        </dropdown-toggle>
                        <ul class="dropdown-menu">
                            <li ng-repeat="choice in views"
                                ui-sref-active="active">
                                <a ui-sref="{{choice.sref}}">{{choice.label}}</a>
                            </li>
                        </ul>
                    </dropdown>
                </div>
                <div class="navigator">
                    <ul class="list-inline">
                        <li>
                            <a href="javascript:" class="btn btn-default" ng-click="prev()">
                                <i class="glyphicon glyphicon-chevron-left"></i>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:" class="btn btn-default" ng-click="today()">
                                Today
                            </a>
                        </li>
                        <li>
                            <a href="javascript:" class="btn btn-default" ng-click="next()">
                                <i class="glyphicon glyphicon-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </div>
            </header>
            <div ui-view></div>
        </div>
        <form id="eventForm" name="eventForm" class="popover bottom event-popover in fade"
              ng-submit="saveEvent()">
            <div class="arrow"></div>
            <div class="popover-inner">
                <h3 class="popover-title">
                    <input type="text" class="form-control" ng-model="event.title" name="title" required/>
                </h3>
                <div class="popover-content">

                    <input type="hidden" name="id" ng-model="event.id"/>
                    <input type="hidden" name="contentId" ng-value="event.contentId"/>
                    <input type="hidden" name="start" ng-model="event.start"/>
                    <input type="hidden" name="end" ng-model="event.end" />

                    <div class="form-group">
                        <label><input type="checkbox" ng-model="event.allDay"/> All Day</label>
                    </div>
                    <div class="form-group row" ng-hide="event.allDay">
                        <div class="col-sm-6">
                            <input type="text" class="form-control"
                                   ng-model="event.startDate"
                                   ng-change="event.start = dateFromString(event.startDate)"/>
                        </div>
                        <div class="col-sm-6">
                            <input type="text" class="form-control"
                                   ng-model="event.endDate"
                                   ng-change="event.end = dateFromString(event.endDate)"/>
                        </div>
                    </div>
                    <div class="form-group">
                    <textarea name="description"
                              class="form-control"
                              ng-model="event.description"
                              placeholder="e.g. Planning meeting for new movie."></textarea>
                    </div>

                    <div class="form-horizontal">
                        <div class="form-group" ng-if="multiMode">
                            <label for="fMovie" class="col-sm-3 control-label">Movie:</label>
                            <div class="col-sm-9">
                                <select required
                                        id="fMovie"
                                        name="contentId"
                                        class="form-control"
                                        ng-model="event.contentId"
                                        ng-options="title.id as title.title for title in titles">
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="fCalendar" class="col-sm-3 control-label">Calendar:</label>
                            <div class="col-sm-9">
                                <select required
                                        id="fCalendar"
                                        name="departmentId"
                                        class="form-control"
                                        ng-model="event.departmentId"
                                        ng-options="department.id as department.name for department in departments">
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Contact:</label>
                            <div class="col-sm-9">
                                <input type="email"
                                       name="contact"
                                       class="form-control"
                                       placeholder="e.g. sarah.berchild@disney.com"
                                       ng-model="event.contact"/>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="popover-footer">
                    <button class="btn btn-primary" type="submit">Save</button>
                    <button class="btn btn-default" type="button" ng-click="cancelEventForm()">Cancel</button>
                    <button class="btn btn-danger pull-right" type="button" ng-if="event.id" ng-click="deleteEvent()">Delete</button>
                </div>
            </div>
        </form>
    </div>
</script>
<script type="text/ng-template" id="templates/weekly-view.html">
    <div class="custom-calendar">
        <table>
            <thead>
            <tr>
                <th>
                    <dropdown class="cell-inner dropdown">
                        <dropdown-toggle class="dropdown-toggle">
                            Departments <b class="caret"></b>
                        </dropdown-toggle>
                        <ul class="dropdown-menu">
                            <li ng-repeat="department in departments">
                                <a>
                                    <div class="checkbox">
                                        <label ng-click="$event.stopPropagation()">
                                            <input type="checkbox"
                                                   ng-model="department.active"/>
                                            {{department.name}}
                                        </label>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </dropdown>
                </th>
                <th ng-repeat="week in weeks"
                    ng-class="{ highlight: week.active }"
                    data-week-start="{{week.start}}">
                    <div class="in">{{printWeekHeader(week)}}</div>
                </th>
            </tr>
            </thead>
            <tbody>

            <tr ng-repeat="department in departments | filter:{ active:true }"
                ng-style="getRowStyle(department)">
                <th data-department-id="{{department.id}}"><div class="in">{{department.name}}</div></th>
                <td ng-repeat="week in weeks" ng-click="dayClicked(week.start, false, $event)" ng-class="{ highlight: week.active }"></td>
            </tr>

            </tbody>
            <tfoot>
            <tr>
                <td colspan="{{weeks.length + 1}}">
                    <div class="in clearfix">
                        <div class="form-inline pull-right">
                            <div class="form-group">
                                <label class="sr-only" for="fromDate">From</label>
                                <input id="fromDate" type="date"
                                       class="form-control input-sm"
                                       ng-model="ui.fromDate"/>
                            </div>
                            <div class="form-group">
                                <label for="toDate">To</label>
                                <input id="toDate" type="date"
                                       class="form-control input-sm"
                                       ng-model="ui.toDate"/>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
            </tfoot>
        </table>
        <div class="event-container">
            <div ng-repeat="department in departments | filter:{ active:true }">
                <a href="javascript:"
                   data-event-id="{{event.id}}"
                   class="event {{department.id}}-department"
                   ng-click="eventClick(event, $event)"
                   ng-style="getEventStyle(event, $index, $parent.$index)"
                   ng-repeat="event in events | filter:{ departmentId:department.id } | contained:weeks ">
                    <div class="img" ng-if="multiMode">
                        <img ng-src="/api/1/services/rendition.json?id={{event.content.id}}&resolution=300x150"/>
                    </div>
                    <div class="in">
                        <span class="title" ng-class="{bold:multiMode}">{{event.title}}</span>
                        <div ng-if="multiMode">
                            ({{event.content.title}})
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</script>
<script type="text/ng-template" id="templates/agenda-view.html">
    <div class="custom-calendar">
        <table>
            <thead>
            <tr>
                <th>
                    <div class="in">
                        <dropdown class="dropdown">
                            <dropdown-toggle class="dropdown-toggle">
                                Departments <b class="caret"></b>
                            </dropdown-toggle>
                            <ul class="dropdown-menu">
                                <li ng-repeat="department in departments">
                                    <a href="javscript:" ng-click="$event.stopPropagation()">
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox"
                                                       ng-model="department.active"/>
                                                {{department.name}}
                                            </label>
                                        </div>
                                    </a>
                                </li>
                            </ul>
                        </dropdown>
                    </div>
                </th>
                <th>
                    <div class="in">
                        <dropdown class="pull-right dropdown">
                            <dropdown-toggle class="dropdown-toggle">
                                Show Updates and Files <b class="caret"></b>
                            </dropdown-toggle>
                            <div class="dropdown-menu">
                                <div class="updates-and-files">
                                    <h3>Activity</h3>
                                    <ul>
                                        <li>
                                            <div class="name">John Doe</div>
                                            <date>Oct 11, 3:14 pm</date>
                                            <div class="description">File updated with new version</div>
                                        </li>
                                        <li>
                                            <div class="name">Joe Smith</div>
                                            <date>Oct 15, 1:50 pm</date>
                                            <div class="description">Updated document</div>
                                        </li>
                                        <li>
                                            <div class="name">Susan Jones</div>
                                            <date>Oct 16, 8:14 am</date>
                                            <div class="description">Revised milestone end date</div>
                                        </li>
                                        <li>
                                            <div class="name">Fred Johnson</div>
                                            <date>Oct 21, 2:25 pm</date>
                                            <div class="description">Uploaded new file</div>
                                        </li>
                                    </ul>
                                    <div class="divide">
                                        <a href="javascript:" class="pull-right">Upload</a>
                                        <h3>Files</h3>
                                        <div class="empty">(no files added)</div>
                                    </div>
                                </div>
                            </div>
                        </dropdown>
                    </div>
                </th>
            </tr>
            </thead>
            <tbody>

            <tr ng-repeat="department in departments | filter: { active:true }">
                <th><div class="in">{{department.name}}</div></th>
                <td>
                    <div class="">
                        <div class="col-sm-4"
                             ng-repeat="event in events | filter: { departmentId:department.id }">
                            <div class="event-thumb">
                                <div class="title">{{event.title}}</div>
                                <date>{{prettyDate(event.start)}}</date>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>

            </tbody>
        </table>
    </div>
</script>
<script type="text/ng-template" id="templates/fc-view.html">
    <div class="calendar"
         calendar="milestones"
         ui-calendar="uiConfig.calendar"
         ng-model="eventSources"></div>
</script>

<div ui-view></div>





<style>
    .main, .main > .container { position: static !important; }
</style>


        </section>

        <footer class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-sm-2">
                        <h3>MPM</h3>
                        <a href="javascript:">Marketing Plan</a>
                        <a href="javascript:">Management</a>
                    </div>
                    <div class="col-sm-5">
                        <h3>Similar Titles</h3>
                        <div class="row">
                            <a class="col-sm-4" href="javascript:">
                                Toy Story of Terror
                            </a>
                            <a class="col-sm-4" href="javascript:">
                                Frozen
                            </a>
                            <a class="col-sm-4" href="javascript:">
                                Cars
                            </a>
                            <a class="col-sm-4" href="javascript:">
                                Muppets
                            </a>
                            <a class="col-sm-4" href="javascript:">
                                Pokahontas
                            </a>
                            <a class="col-sm-4" href="javascript:">
                                Mulan
                            </a>
                        </div>
                    </div>
                    <div class="col-sm-5">
                        <h3>Site Links</h3>
                        <div class="row">
                            <a class="col-sm-3" href="javascript:">
                                Site Map
                            </a>
                            <a class="col-sm-3" href="javascript:">
                                Support
                            </a>
                            <a class="col-sm-3" href="javascript:">
                                About
                            </a>
                            <a class="col-sm-3" href="javascript:">
                                Contact
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <!-- build:js(.) scripts/oldieshim.js -->
        <!--[if lt IE 9]>
        <script src="static-assets/libs/es5-shim/es5-shim.js"></script>
        <script src="static-assets/libs/json3/lib/json3.js"></script>
        <![endif]-->

        <!-- build:js(.) static-assets/scripts/vendor.js -->
        <!-- bower:js -->
        <script src="/static-assets/libs/jquery/jquery.js"></script>
        <script src="/static-assets/libs/angular/angular.js"></script>
        <script src="/static-assets/libs/angular-resource/angular-resource.js"></script>
        <script src="/static-assets/libs/angular-cookies/angular-cookies.js"></script>
        <script src="/static-assets/libs/angular-sanitize/angular-sanitize.js"></script>
        <script src="/static-assets/libs/angular-animate/angular-animate.js"></script>
        <script src="/static-assets/libs/angular-touch/angular-touch.js"></script>
        <script src="/static-assets/libs/angular-route/angular-route.js"></script>
        <script src="/static-assets/libs/angular-sanitize/angular-sanitize.js"></script>
        <script src="/static-assets/libs/angular-ui-router/release/angular-ui-router.js"></script>
        <script src="/static-assets/libs/angular-bootstrap/ui-bootstrap-tpls.js"></script>
        <script src="/static-assets/libs/jquery-ui/ui/jquery-ui.js"></script>
        <script src="/static-assets/libs/fullcalendar/fullcalendar.js"></script>
        <script src="/static-assets/libs/angular-ui-calendar/src/calendar.js"></script>
        <script src="/static-assets/libs/moment/moment.js"></script>
        <!-- endbower -->
        <!-- endbuild -->

        <!-- build:js({.tmp,app}) static-assets/script/main.js -->
        <script src="/static-assets/scripts/controllers.js"></script>
        <script src="/static-assets/scripts/services.js"></script>
        <script src="/static-assets/scripts/search.js"></script>
        <script src="/static-assets/scripts/browse.js"></script>
        <script src="/static-assets/scripts/details.js"></script>
        <script src="/static-assets/scripts/home.js"></script>
        <script src="/static-assets/scripts/calendar.js"></script>
        <!-- endbuild -->

        <#if RequestParameters["c"]?? == false>
          <@cstudioOverlaySupport/> 
        </#if>
    </body>
</html>




