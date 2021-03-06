# Module 3:

## Restricting access by applying Rate Limits on API

Once the APIs start becoming feature rich, the next aspect that you need to focus on is how to secure these APIs. The most comman way of restricting your APIs from getting a flood of request is to enable rate limiting. With NGINX Plus Ingress Controller(NIC) you can enable rate limiting by creating a custom policy and then applying the policy to the custom Virtual Server resource that was discussed in previous section.   

In this module you will learn:

1. Creating a custom rate limiting policy. 
2. How to modify the VirtualServer object to enable rate limiting on your set of APIs
 
## 1. Creating a custom rate limiting policy

In this step you will look into a custom policy that enables rate limiting for the colors API.

Inspect the `module3/rate-limit.yaml` file. This policy limits all subsequent requests coming from a single IP address once a rate of 1 request per second is exceeded. 

![rate limit policy](media/module3_rate-limit-policy.png)

The `rate` field defines the rate of requests permitted. The rate can be specified in requests per second(r/s) or requests per minute (r/m).

The `key` field defines the key to which rate limit is applied. In the example above, you are making use of `binary_remote_addr` which represents the IP of the client requesting the API.

The `zoneSize` field defines the size of the shared memory zone that maintains the state of defined keys.

Run the following command to create the custom policy within your existing setup

```bash
kubectl apply -f module3/rate-limit.yaml
```

![Apply policy](media/module3_apply-policy.png)

Run the following command to view all the custom policies within a particular namespace

```bash
kubectl get policy -n api
```

## 2. How to modify the VirtualServer object to enable rate limiting on your set of APIs

Once the rate limit policy has been created the next part would be to enable this policy to APIs by modifying the VirtualServer object. You can perform this task two ways.

1. Apply policy to all routes. (spec policies)
2. Apply policy to a specific route. (route policies)

As part of this workshop, you will apply the policy to a specific route (Colors API). For more information on how to apply policies to all routes look into the link in the References section.

Inspect the `module3/api-runtimes-vs-with-ratelimit.yaml` file. This file modifies the `apis` VirtualServer object from module 1 and applies the rate limit policy to restrict the usage of Colors API. (See highlighted section in the screenshot below)

![API VS ratelimit](media/module3_api_vs_ratelimit.png)

Run the following command to update the existing `apis` VirtualServer object with the new changes

```bash
kubectl apply -f module3/api-runtimes-vs-with-ratelimit.yaml
```

![API VS apply](media/module3_api_vs_apply.png)

Now lets test the APIs and see if the rate limit is restricting traffic based on the policy that you applied.

As part of testing you would run a series of curl commands that are placed within a for loop and iterated 20 times.

Copy the below command and paste in terminal:

```bash
for i in {1..20}; do curl -Is http://api.example.com/api/v1/locations | grep "HTTP"; done
```

![for loop for locations](media/module3_test_locations.png)

Also run below command:

```bash
for i in {1..20}; do curl -Is http://api.example.com/api/v1/colors | grep "HTTP"; done
```

![for loop for colors](media/module3_test_colors.png)

What do you notice in the output of the two commands? 

For the first command you get all `200` response status codes whereas for the second command you get a mix of `200` and `503` response status codes. This is because you are calling the colors API in the second command for which you have applied the rate limit policy.

**Note:** `503` response status code is the default reject code within rate limit policy.

Next you would change the default reject code to `429` which is more specific reject code than the default one.

Open `module3/rate-limit.yaml` file in vscode and then add the `rejectCode` field as shown below and then save the file:

![rate limit with reject code yaml](media/module3_add_rejectcode.png)

Run the following command to update the existing `rate-limit-policy` policy object with the new changes

```bash
kubectl apply -f module3/rate-limit.yaml
```

![Reapply policy](media/module3_reapply_policy.png)

Once the policy is configured, run the below command to see the change.

```bash
for i in {1..20}; do curl -Is http://api.example.com/api/v1/colors | grep "HTTP"; done
```

![for loop for colors](media/module3_test_colors.png)

You will notice that the output now is a mix of `200` and `429` response status code. You successfully updated the rate-limit policy to return `429` reject code instead of the default generic `503` reject code.

Please look into the References section for more information on additional fields that can be used with rate limit custom policy.

## References

- [Rate Limit Policy Doc](https://docs.nginx.com/nginx-ingress-controller/configuration/policy-resource/#ratelimit)
- [Various Ways of applying policies](https://docs.nginx.com/nginx-ingress-controller/configuration/policy-resource/#applying-policies)


-------------

Navigate to ([Module4](../module4/readme.md) | [Main Menu](../README.md))
