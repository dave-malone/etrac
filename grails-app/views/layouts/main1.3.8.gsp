<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="eTrac Advantage - Task Order Management System" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:javascript library="jquery" plugin="jquery"/>
        <jqui:resources/> 
        <g:javascript library="application" />
        <g:layoutHead />        
    </head>
    <body>        
        <g:render template="/common/header" />
        <g:render template="/common/nav" />
        <g:layoutBody />
    </body>
</html>