<#import "/templates/system/common/cstudio-support.ftl" as studio />
	
	
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
    
   <!-- home
   ================================================== -->
   <section id="home" 
            data-parallax="scroll" 
            data-image-src="${contentModel.bckgroundImage}" 
            data-natural-width=3000 
            data-natural-height=2000 
            <@studio.iceAttr iceGroup="background"/>>

        <div class="overlay"></div>
        <div class="home-content">        

            <div class="row contents">                     
                <div class="home-content-left">

                    <h3 data-aos="fade-up" <@studio.iceAttr iceGroup="headlines"/>>${contentModel.headline}</h3>

                    <h1 data-aos="fade-up">
                        ${contentModel.subHeadline}
                    </h1>

                    <div class="buttons" <@studio.iceAttr iceGroup="ctas"/>>
                       <#if contentModel.ctas?? &&  contentModel.ctas.item??>
                         <#list contentModel.ctas.item as cta>
                            <a href="${cta.link}" class="smoothscroll button stroke">
                                <span class="icon-circle-down" aria-hidden="true"></span>
                                ${cta.label}
                            </a>
                          </#list>
                      </#if>
                    </div>                                         

                </div>

                <div class="home-image-right" <@studio.iceAttr iceGroup="hover"/>>
                    <img src="${contentModel.hoverImageSmall}" 
                        srcset="${contentModel.hoverImageSmall} 1x, ${contentModel.hoverImageLarge} 2x" >
                </div>
            </div>

        </div> <!-- end home-content -->

        
        <ul class="home-social-list">
            <li>
                <a href="#"><i class="fa fa-facebook-square"></i></a>
            </li>
            <li>
                <a href="#"><i class="fa fa-twitter"></i></a>
            </li>
            <li>
                <a href="#"><i class="fa fa-instagram"></i></a>
            </li>
            <li>
                <a href="#"><i class="fa fa-youtube-play"></i></a>
            </li>
        </ul>


			<div class="home-scrolldown">
            <a href="#about" class="scroll-icon smoothscroll">
                <span>Scroll Down</span>
                <i class="icon-arrow-right" aria-hidden="true"></i>
            </a>
        </div>
      </section>
      
          <section id="about" style="min-height:100px !important; "  >

          <div class="row about-intro clearfix" <@studio.componentContainerAttr target="col1" objectId=contentModel.objectId />>
              <#if contentModel.col1?? && contentModel.col1.item??>
                  <#list contentModel.col1.item as module>
                      <@renderComponent component=module />
                  </#list>
              </#if>
          </div>
		</section>  
    
    <#include "/templates/web/common/footer.ftl" />
    <#include "/templates/web/common/common-scripts.ftl" />
    
	<@studio.toolSupport />
</body>

</html>