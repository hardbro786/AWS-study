## AWS NLB

| **Feature**         | **NLB (Network Load Balancer)** | **ALB (Application Load Balancer)** |
|----------------------|----------------------------------|--------------------------------------|
| **Layer**            | 4 (Transport)                   | 7 (Application)                     |
| **Protocols**        | TCP, UDP, TLS                   | HTTP, HTTPS, gRPC                   |
| **Static IPs**       | Yes                             | No                                  |
| **Latency**          | Ultra-low                       | Sufficient for web apps             |
| **Routing Logic**    | IP-based, flow hash             | Path, host, header, method-based    |
| **Advanced Features**| AWS PrivateLink, static IP      | SSL offload, WAF, HTTP(S) redirects |



<img width="1920" height="1080" alt="Screenshot from 2025-10-28 14-41-36" src="https://github.com/user-attachments/assets/ac40b6c5-7b2f-419d-8f7c-f8601daffe95" />## 

---
aws nlb - 
AWS Network Load Balancer (NLB) is an Amazon Web Services tool that distributes high-performance traffic across multiple cloud instances and provides automatic scaling of resources to ensure low latency and high throughput for applications. 


## What are the features and benefits of using an NLB?
The following are popular features and advantages of using AWS NLB:

1. Connection-based layer 4 load balancing. The AWS NLB enables load balancing of both TCP and UDP traffic and routes connections to targets, such as EC2 instances, microservices and containers.
2. High availability. A network load balancer provides high availability of resources, as it distributes incoming traffic across targets within the same AZ and monitors the health of registered targets to ensure traffic is only routed to the healthy ones. If the NLB is configured for cross-zone load balancing or multiple AZs and sees a failed target, it routes traffic to healthy targets in the other AZs.

3. High throughput. The NLB is designed to handle extreme amounts of traffic and can load balance millions of requests per second. It's also capable of handling sudden volatile traffic peaks.

4. Low latency. The NLB provides little to no latency for highly critical and latency-sensitive applications.

5. Cross-zone load balancing. Cross-zone load balancing is disabled by default in AWS and can only be enabled after creating the NLB. Certain charges are applied for traffic distributed between different zones.

6. Sticky sessions. Also known as source IP affinity, this mechanism routes requests from the same client to the same target. The stickiness of a session is typically configured at the target group level.

7. Preserves source IP address. The NLB preserves the client-side source IP address to prevent the backend from seeing the client's IP address. This is helpful during application processing.

8. Static IP support. The NLB automatically provides a static IP address for an AZ. This is the application's front-end IP on the load balancer.

9. Elastic IP support. Through a fixed IP, the NLB provides the option of an elastic IP per AZ.

10. Integration with AWS services. The NLB is integrated with a variety of AWS services, including Auto Scaling, EC2 Container Service (ECS), CloudFormation, CodeDeploy and AWS Config.

11. DNS failover. If there are no healthy targets with the NLB, or the NLB itself is unhealthy, then the NLB integrates with Amazon Route 53, which directs traffic load balancer nodes in other AZs.


12. Central API support. The NLB uses the same API as the application load balancer. This supports containerized applications as it lets admins work with target groups, health checks and load balancing across multiple ports on the same EC2 instance.

13. Long-lived TCP connections. These support long-lived TCP connections, making it ideal for WebSocket-type applications.

14. Powerful monitoring and auditing. NLB is integrated with both CloudWatch and CloudTrail, which helps with monitoring and auditing of resources. CloudTrail provides metrics such as active flow count, healthy host count, new flow count and processed bytes. CloudTrail tracks API calls to the NLB.

---
# Main content starts here -> 
## how to create it - 
### 1. in load balancer category, select network load balancer.
<img width="444" height="750" alt="Screenshot from 2025-10-28 14-25-01" src="https://github.com/user-attachments/assets/d36e2b02-2ba6-4ad5-b165-5fefccfa358b" />


---

### 2. give load balancer name, select internet facing or internal according to your need.
<img width="1920" height="1080" alt="Screenshot from 2025-10-28 14-27-11" src="https://github.com/user-attachments/assets/2366ba0b-84b5-4bf8-9c72-77249417dd1e" />



---
### 3. select vpc, availibility zones and security groups to attach.
<img width="1920" height="1080" alt="Screenshot from 2025-10-28 14-28-03" src="https://github.com/user-attachments/assets/201254f9-8bd8-4fc0-810b-9004ee5fa9fc" />


#### vpc selection - 
<img width="1920" height="1080" alt="Screenshot from 2025-10-28 14-36-02" src="https://github.com/user-attachments/assets/e5a84183-96d4-4dcd-896b-714fd24588b0" />

---

### 4. select listeners and routing. you have to first create target groups here
<img width="1920" height="1080" alt="Screenshot from 2025-10-28 14-30-00" src="https://github.com/user-attachments/assets/5ac59153-0bce-48ce-9090-89f0ca9abc2f" />


#### target group creation - 
<img width="1920" height="1080" alt="Screenshot from 2025-10-28 14-33-55" src="https://github.com/user-attachments/assets/eaf987eb-8ef9-4460-bb9d-61acbef06933" />
<img width="1920" height="1080" alt="Screenshot from 2025-10-28 14-33-59" src="https://github.com/user-attachments/assets/2738f867-9d2f-4204-a2a4-8f0c9a32d2d6" />
<img width="1920" height="1080" alt="Screenshot from 2025-10-28 14-34-02" src="https://github.com/user-attachments/assets/46d3358c-ff39-4cd6-bb81-b2386a1bff9d" />
<img width="1920" height="1080" alt="Screenshot from 2025-10-28 14-37-19" src="https://github.com/user-attachments/assets/aac43076-b89a-4142-8f49-5f350ae1bc0a" />


---

### 5.after target group creation, target group page will look like this
<img width="1920" height="1080" alt="Screenshot from 2025-10-28 14-38-11" src="https://github.com/user-attachments/assets/b790aadb-0341-410a-99b7-9b2b6121342e" />

---


### 6. now click on create load balancer.
and wallah your network load balancer is created!!!

<img width="1920" height="1080" alt="Screenshot from 2025-10-28 14-41-33" src="https://github.com/user-attachments/assets/29641a50-4fe5-4646-b57b-a7944e096a54" />

<img width="1920" height="1080" alt="Screenshot from 2025-10-28 14-41-36" src="https://github.com/user-attachments/assets/887d14d5-c550-469c-9ab2-9f40b39a4c3a" />
