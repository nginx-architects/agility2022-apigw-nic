# Module 2: 

## Layer 7 Request Routing and API Versioning

As API's mature and developers continue to add features and functionality, it is oftentimes necessary to create new versions of those API's.  API versioning is accomplished in various ways.  Most commonly it is achieved by modifying the URL path so that /api/v1/colors becomes /api/v2/colors.  Alternative approaches include using a header value, e.g. Version=1.0 or by using query parameters, e.g. /api/colors?version=1.0.  This module will implement all three of these options.  

Access to these new versions is normally implemented by modifying the path (i.e. URL) of the API.  So you would see a path like /myapi/v1/colors for the original API and /myapi/v2/colors for the new, v2 version of the API.  While the path changes for the two versions, the FQDN would normally remain the same. With the NIC you will need to use "path-based" routing.  This is core functionality for all Ingress Controllers but it is easy to implement with NGINX custom resources VirtualServer.   

In this module you will learn:
1. Path based routing
2. Cookie based routing - https://docs.nginx.com/nginx-ingress-controller/configuration/virtualserver-and-virtualserverroute-resources/#match
3. Parameter based routing

## Step 1

## Step 2


## Step 3


-------------

Navigate to ([Module3](../module3/readme.md) | [Main Menu](../README.md))
