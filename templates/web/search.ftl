<#import "/templates/system/common/cstudio-support.ftl" as studio />
<!DOCTYPE html>
<!--[if lt IE 9 ]><html class="no-js oldie" lang="en"> <![endif]-->
<!--[if IE 9 ]><html class="no-js oldie ie9" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->

<head>
    <title>Dazzle</title>
	<#include "/templates/web/common/head.ftl" /></head>

<body id="top" style="background-color:white">

	<#include "/templates/web/common/header.ftl" />


   <section id="about">

        <div class="row about-intro">

            <div class="col-two">
                &nbsp;
            </div>

            <div class="col-eight">

                <div id="searchbox">
                    <form id="searchForm"> 
                        <input class="searchinput" type="input" name="keyword" id="keyword" value="${keyword}"> 
                        <button class="button button-primary large">Search</button>
                    </form>
                </div>

                <ul>
                    <#if err??>
                        Keyword is required
                    <#else>

                	<#if matches??>
                      <#list matches as match>
                        <li class="search-result">
                        
                            <h3>
                            	<a href="${urlTransformationService.transform('storeUrlToRenderUrl', match.localId)}">${match.title}</a>
                             </h3>
                             <#if highlighting[match.id].bodyContent??>
                                <p>${highlighting[match.id].bodyContent[0]}</p>
                            <#else>
                               <p>${match.bodyContent?substring(0, 200)}</p>
                            </#if>
                            
                        </li>
                      </#list>
                    <#else>
                     	<h1>No Results Found</h1>
                    </#if>
                    </#if>

                </ul>                
            </div>                       
            <div class="col-two">
                                &nbsp;

            </div>
            
        </div>

    </section> <!-- end about -->  



	<#include "/templates/web/common/footer.ftl" />
    
	<#include "/templates/web/common/common-scripts.ftl" />
	<@studio.toolSupport />
</body>

</html>