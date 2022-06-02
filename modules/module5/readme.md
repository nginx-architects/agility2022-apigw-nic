# Module 5: 

## Protecting APIs by using NGINX APP Protect 

In the last module you protected your API from unwanted actors by enabling JWT authentication to your APIs. In this module you will protect your API against L7 attacks by enabling NGINX APP Protect WAF. With NGINX Plus Ingress Controller(NIC) you can enable NGINX APP Protect by creating a custom policy and then applying the policy to the custom Virtual Server resource that you worked on in previous modules.  

In this module you will learn:

1. How to create a custom NGINX APP Protect policy. 
2. How to modify the VirtualServer object to enable NGINX APP Protect policy on your set of APIs

## 1. Create an App Protect Policy

In this step you will look into a custom policy that enables APP Protect Policy for the colors API.

Inspect the module5/ap-policy.yaml file.
This is where we define our App Protect policy.

Inspect the module5/ap-logconf.yaml file.
This is where we define our App Protect logging.

Inspect the module5/waf.yaml file.
This is where we specify the above files.

Inspect the module5/ap-uds.yaml file.
This is where we define our App Protect User Defined Signatures.


## 2. How to modify the VirtualServer object to enable NGINX APP Protect policy on your set of APIs

Once the App Protect policy has been created the next step is to enable this policy to the APIs by modifying the VirtualServer object. This process is the same as applying the JWT policy that you saw in the last section. You can perform this task two ways.

1. Apply policy to all routes. (spec policies)
2. Apply policy to a specific route. (route policies)

As part of this workshop, you will apply the policy to a specific route (Colors API). For more information on how to apply policies to all routes look into the link in the References section.

Inspect the `module5/api-runtimes-vs-with-waf.yaml` file. This file modifies the `apis` VirtualServer object from module 1 and applies the App Protect policy to restrict the usage of Colors API. 

Run the following command to update the existing `apis` VirtualServer object with the new changes

```bash
    kubectl apply -f module5/api-runtimes-vs-with-waf.yaml
```

Now lets test the API and see what responses you get when you access the Colors API with/without App Protect Policy.

As part of testing, based on your preference, you can either use postman tool or you can run curl commands to make calls to the Colors API endpoint.


### Testing via Postman
To test apply the App Protect and assosicated manifests. 

```bash
    kubectl apply -f module5/waf.yaml
    kubectl apply -f module5/ap-policy.yaml
    kubectl apply -f module5/ap-logconf.yaml
    kubectl apply -f module5/ap-uds.yaml
    kubectl apply -f module5/syslog.yaml
    kubectl apply -f module5/webapp-secret.yaml
    kubectl apply -f module5/webapp.yaml
```

![Module5 Postman Collection](media/postman.png)

Switch to the Postman application in the Jumphost. In the "Collection" on the left navigate to module 5, select the POST call. 


click Send, You should see a 403 Unauthorized response code with the relevant response body and a support ID.


### Testing via cURL 

Run the below curl command. You should see a `200 OK` response code and the response body should contain a listing of colors and associated ID's.

```bash
curl -iX POST --insecure -d 'apple' api.example.com/api/v1/colors
```

You are receiving this response because the App Protect Policy has not been applied to the colors API and you are allowed to access this API endpoint without violating the policy.

To test apply the App Protect and assosicated manifests. 

```bash
    kubectl apply -f module5/waf.yaml
    kubectl apply -f module5/ap-policy.yaml
    kubectl apply -f module5/ap-logconf.yaml
    kubectl apply -f module5/ap-uds.yaml
    kubectl apply -f module5/syslog.yaml
    kubectl apply -f module5/webapp-secret.yaml
    kubectl apply -f module5/webapp.yaml
```

Within the vscode terminal, run the below curl command to send a request to Animals API. On running the curl command, you should see a 403 Unauthorized response code with the relevant response body and a support ID.

```bash
curl -iX POST --insecure -d 'apple' api.example.com/api/v1/colors
```
![curl request2](media/curl.png)


Please look into the [References](#references) section for more information on JWT custom policy. 

## References:
https://docs.nginx.com/nginx-ingress-controller/configuration/policy-resource/#applying-policies

https://docs.nginx.com/nginx-ingress-controller/app-protect/configuration/#app-protect-policies 


-------------

Navigate to ([Module6](../module6/readme.md) | [Main Menu](../README.md))
