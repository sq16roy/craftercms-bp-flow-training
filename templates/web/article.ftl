<#import "/templates/system/common/cstudio-support.ftl" as studio />
<#import "/templates/web/common/utils.ftl" as utils />


<!DOCTYPE html>
<!--[if lt IE 9 ]><html class="no-js oldie" lang="en"> <![endif]-->
<!--[if IE 9 ]><html class="no-js oldie ie9" lang="en"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->

<head>
    <title>Dazzle</title>
    <#include "/templates/web/common/head.ftl" />
</head>

<body id="top">

    <#include "/templates/web/common/header.ftl" />


   <section id="about">

        <div class="row about-intro">

            <div class="col-eight">
                <h1 class="intro-header">${contentModel.title}</h1>                
                <p>${contentModel.summary}</p>
                ${contentModel.bodyContent}
            </div>                       
            <div class="col-four">
                <div class="testimonial-author">
                    <img class="img-circle" src="${contentModel.authorImage}" alt="Author image">
                    <div class="author">
                        ${contentModel.authorName}
                        <span class="position">${contentModel.authorPosition!""}</span>
                    </div>
                </div>                            
            </div>
            
        </div>

    </section> <!-- end about -->  

    <#include "/templates/web/common/footer.ftl" />  

    <#include "/templates/web/common/common-scripts.ftl" />
	<@studio.toolSupport />
</body>

</html>