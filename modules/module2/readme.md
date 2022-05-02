# Module 2: 

## Layer 7 Request Routing and API Versioning

As API's mature and developers continue to add features and functionality, it is oftentimes necessary to create new versions of those API's.  API versioning is accomplished in various ways.  Most commonly it is achieved by modifying the URL path so that /api/v1/colors becomes /api/v2/colors.  Alternative approaches include using a header value, e.g. Version=1.0 or by using query parameters, e.g. /api/colors?version=1.0.  This module will implement all three of these options.  

Access to these new versions is normally implemented by modifying the path (i.e. URL) of the API.  So you would see a path like /myapi/v1/colors for the original API and /myapi/v2/colors for the new, v2 version of the API.  While the path changes for the two versions, the FQDN would normally remain the same. With the NIC you will need to use "path-based" routing.  This is core functionality for all Ingress Controllers but it is easy to implement with NGINX custom resources VirtualServer.   

In this module you will learn:
1. The VirtualServerRoute custom resource 
2. Cross namespace Path-Based Routing Using VirtualServerRoute

In the previous module we enabled traffic routing from outside the cluster to the API runtimes inside the cluster running in the api namespace.  In this module we will enable access to new versions of the API endpoints, v2, running in the apiv2 namespace.  Separating development efforts into dedicated namespaces is a good way to prevent accidental modifications to existing code.  It can also be used to enable RBAC or even Network Policy constraints.  
## Step 1

Background on VirtualServerRoute (VSR).  

In Module 1 we used the VirtualServer (VS) resource to configure the NGINX load balancer in the Ingress pods to proxy requests to API runtimes.  The VS includes the vs.spec.upstreams and vs.spec.routes objects.  The routes contained a path and an action.  The VSR resource lets you further define vs.spec.routes.  This is done by replacing vs.spec.routes.action with vs.spec.routes.route.  The "route" string references a VSR object along with the namespace it is in.  Here is what it looks like:

![VSR Reference](media/vs-to-vsr.png)

Where the format of vs.spec.routes.route is namespace/vsr-name

One of the main reasons for doing this is that the VSR can exists in a separate namespace than the VS that references it.  This means that, for our example lab environment, the same team that manages the apiv2 API runtimes can also manage the logic that routes traffic to it in their own VSR configuration.  And RBAC can be applied so that the apiv2 team can't modify the routing logic of api v1.

The VSR looks very much like the VS that we saw in Module 1.  One difference you will notice is that where we had vs.spec.route, we now have vsr.spec.subroute.  Note that there are two requirements in creating the VSR.  

1. Both the VS and VSR must have the same spec.host values and 
2. The vsr.subroute.path must be an extension of the vs.spec.routes.path.  As an example, in our case we have:

vs.spec.routes.path = /api/v1

and

vsr.subroute.path = /api/v1/locations

This is what it looks like in the manifest files: 

![VSR Reference](media/vs-2-vsr-2.png)

## Step 2

In this step we will now apply a new VirtualServer manifest and create two VirtualServerRoute resources with new manifests, one for each version of our API.  

Begin by applying the new VS manifest with:

```bash
kubectl apply -f module2/api-runtimes-vs-v2.yaml
```

Note that this will overwrite the VS configuration you created in Module 1.  If you list this new version of the VS you will note that it is in a warning state:

```bash
kubectl get vs -n api
```

This is because it is referencing VSR's that don't exist yet.  Let's fix that by creating the VSR's with:

```bash
kubectl apply -f module2/api-runtime-vsr-v1.yaml
```

```bash
kubectl apply -f module2/api-runtime-vsr-v2.yaml
```

Here is a look at the (truncated) manifest for the VSR you just created:

![VSR Reference](media/vsr-v2.png)

Notice the namespace, apiv2, and path for the v2 API's.  
## Step 3

Test new configuration.  

-------------

Navigate to ([Module3](../module3/readme.md) | [Main Menu](../README.md))
