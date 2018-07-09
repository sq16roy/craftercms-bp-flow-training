<#import "/templates/system/common/cstudio-support.ftl" as studio />
<html lang="en">
<head>
	</head>
	<body>
		<h1>${contentModel.title}</h1>
        
        <p>
        ${contentModel.body}
        <p>
        
        <ul>
        	<#list contentModel.locations.item as row>
            
				<li>${row.name} | ${row.address}</li>
			</#list>
        <ul>
	<@studio.toolSupport/>
	</body>
</html>