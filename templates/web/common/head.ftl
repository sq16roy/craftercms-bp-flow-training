  <!--- basic page needs
 ================================================== -->
  <meta charset="utf-8">
  <meta name="description" content="">
  <meta name="author" content="">

  <!-- mobile specific metas
 ================================================== -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- CSS
 ================================================== -->
  <link rel="stylesheet" href="/static-assets/app/css/base.css">
  <link rel="stylesheet" href="/static-assets/app/css/vendor.css">
  <link rel="stylesheet" href="/static-assets/app/css/main.css">

  <!-- script
 ================================================== -->
  <script src="/static-assets/app/js/modernizr.js"></script>
  <script src="/static-assets/app/js/pace.min.js"></script>

  <!-- favicons
  ================================================== -->
  <link rel="shortcut icon" href="/static-assets/app/favicon.ico" type="image/x-icon">
  <link rel="icon" href="/static-assets/app/favicon.ico" type="image/x-icon">

  <#if RequestParameters["c1v1"]??>
    <#assign bgColorLite = "#003F87" />
    <#assign bgColor = "#3B6AA0" />
  <#else>
    <#assign bgColorLite = "grey" />
    <#assign bgColorDark = "black" />
  </#if>
  <style>
    #header {
      background-color: ${bgColorDark};
    }
    body {
      background-color: ${bgColorDark};
    }

    #about {
      background-color: ${bgColorDark};
    }

    #go-top a, #go-top a:visited {
      background-color: ${bgColorLite}
    }
  </style>