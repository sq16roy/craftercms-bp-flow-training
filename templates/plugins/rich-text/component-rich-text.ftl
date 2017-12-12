<#import "/templates/system/common/cstudio-support.ftl" as studio />
<#assign styles="body { margin: 10px; background: black !important; color: white !important; } h1 { color: 39b54a !important; } h2, h3, h4 { color: white !important; }" />
<div style="${styles}" <@studio.componentAttr path=model.storeUrl ice=true iceGroup="content" /> >  ${contentModel.content_html!''}</div>
