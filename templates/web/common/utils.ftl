<#function add a, b>
	<#return a+b />
</#function>

<#macro makePretty color>
	<div style="border: 10px solid ${color};">
      <#nested />
    </div>
</#macro>

<#macro mapSupport>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false&libraries=places"></script>

    <script type="text/javascript"> 
          function initializeMap(elId, address) { 
            var geocoder = new google.maps.Geocoder();
    
            
            geocoder.geocode({'address': address}, 
              function(results, status) {
                 var location = results[0].geometry.location;
    
                 var mapOptions = {
                    zoom: 12,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                 };
    
                 var map = new google.maps.Map(document.getElementById(elId), mapOptions);
                 map.setCenter(location);
                 
                 var marker = new google.maps.Marker({
                    map: map,
                    position: location
                 });
              });
          }  
         </script>
</#macro>


<#macro map id address>
	<div id="${id}" style='border:1px solid black; width: 300px; height: 200px;'></div>
    	<script>
          google.maps.event.addDomListener(window, 'load', function() { 
          initializeMap("${id}", "${address}"); });
        </script>
</#macro>