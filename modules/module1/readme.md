# Module 1

The purpose of the first module is to give you an overview of the lab environment.  

By the end of this module you will:
1. Understand the overall architecture of this lab
2. Become familiar with the tools on the Windows Jumphost
3. Understand how to run commands to both view and make changes to the lab environment
4. Understand how to verify your work by sending traffic to the Kubernetes cluster


## Step 1

Let's begin by taking a look at the overall architecture of the lab environment.  Please review the following diagram:

![Environment Overview](media/Agility%20UDF%20Environment.jpeg)

As per the diagram, you will be working with a three node cluster with one control-plane node and two workers.  The NGINX Ingress Controller (NIC) is deployed into the nginx-ingress namespace.  The NIC deployment is exposed with a NodePort service to make it accessible from outside of the cluster.  There are two application namespaces:  a) API and b) Webapp.  The API namespace contains a number of deployments corresponding to the the API runtimes/endpoints that you will access throughout the lab modules.  The webapp namespace contains a single application called frontend.  It's purpose is to generate a browser application that uses the API's to create a sentence to display on the web page.    

The cluster has an external NGINX+ load balancer.  Its purpose is to load balance requests across all of the nodes of the cluster.  You can generate API requests from the PostMan application installed on the Windows Jump Host.  
## Step 2


## Step 3
-------------

Navigate to ([Module2](../module2/readme.md) | [Main Menu](../README.md))
