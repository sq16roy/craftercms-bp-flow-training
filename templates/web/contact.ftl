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
	<@utils.mapSupport />
</head>

<body id="top">

    <#include "/templates/web/common/header.ftl" />

       <section id="about">

        <div class="row about-how">
          
            <h1 class="intro-header">Our Locations</h1>           

            <div class="about-how-content">
                <div class="about-how-steps block-1-2 block-tab-full group">

					<#list contentModel.locations.item as location>

                    <div class="bgrid step" data-item="${location_index+1}">
                        <h3>${location.title}</h3>
                        <p>${location.address}<p>
                        <p>${location.phoneNumber}<p>
                        
                        <@utils.map "map${location_index}" location.address />
                        
                    </div>
                    </#list>


                </div>           
           </div> <!-- end about-how-content -->
        </div>
                <div class="row about-how">
          
            <h1 class="intro-header">Get In Touch</h1>           

            <div class="about-how-content">


            <div class="subscribe-form col-two">            
                <!-- form -->
            <form name="contactForm" id="contactForm" method="post" action=""  >
                <fieldset>

                  <div class="group">
                           <input name="contactName" type="text" id="contactName" placeholder="Name" value="" minLength="2" required />
                  </div>
                  <div>
                       <input name="contactEmail" type="email" id="contactEmail" placeholder="Email" value="" required />
                   </div>
                  <div>
                           <input name="contactSubject" type="text" id="contactSubject" placeholder="Subject"  value="" />
                   </div>                       
                  <div>
                        <textarea name="contactMessage"  id="contactMessage" placeholder="message" rows="10" cols="50" required ></textarea>
                   </div>                      
                  <div>
                     <button class="submitform">Submit</button>
                </fieldset>
            </form> <!-- Form End -->

        </div> <!-- end about-how -->

       
        
    </section> <!-- end about --> 



    <#include "/templates/web/common/footer.ftl" />
    <#include "/templates/web/common/common-scripts.ftl" />
	<@studio.toolSupport />
</body>

</html>