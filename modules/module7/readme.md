# Module 7

As companies begin to deploy more modern applications and where low latency is required, gRPC may be a good option.  gRPC is becoming a popular alternative to JSON RESTful API's in part because of a 7 to 10 times performance improvement over REST.  This is due in part to the use of HTTP2.  NGINX has gRPC proxy and load balancing capabilities built in.  Moreover, we can enable our Ingress Controller to route and load balance gRPC traffic with the VirtualServer custom resource.  

In this module you will learn:
1. Basic gRPC concepts
2. How our gRPC demonstration application works
3. How to configure the NIC to proxy and load balance gRPC traffic

More on gRPC from Google:

> gRPC is a high performance, open-source universal RPC framework, developed by Google. In gRPC, a client application can directly call methods on a server application on a different machine as if it was a local object, making it easier to create distributed applications and services.

Also from Google:

> gRPC is based on the idea of defining a service, specifying the methods that can be called remotely with their parameters and return types. By default, gRPC uses protocol buffers as the Interface Definition Language (IDL) for describing both the service interface and the structure of the payload messages.

For our simple demo application, we have two application services, namely, "echo" and "reverse".  In gRPC, the application service is defined using a ".proto" file.  For example, the .proto for the echo service is:

```json
service Echo {
  rpc Echo (EchoRequest) returns (EchoResponse) {}
}

message EchoRequest {
  string content = 1;
}

message EchoResponse {
  string content = 1;
}
```

This service definition along with the its associated code, language-specific runtime libraries and serialization format create what is known as the "protocol buffer".  

In this module we will be enable our Ingress Controller to proxy, route and load balance gRPC requests to our simple gRPC application.  

A quick look at the architecture:  

![Module 7 Architecture](./media/Agility%20Module%207%20-%20gRPC.jpeg)

The echo and reverse applications have been deployed in the api namespace with two pods for each.  Separate services have been created to expose those applications.  You will need to make those applications accessible from outside of the cluster by configuring the NIC.  

## Step 1

## Step 2


## Step 3

-------------

Navigate to ([Module8](../module8/readme.md) | [Main Menu](../README.md))
