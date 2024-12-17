# A tester application for session replication in GlassFish

This application test the session replication works on a GlassFish cluster.

# Usage

In order to test session replication, you need to have one of the following setups:

* run all the GlassFish instances locally, on the same IP address, different ports, no load balancer needed
* run GlassFish insances on different IP addresses, with a load balancer, access the application using the load balancer

First, access instance A (here named `server1`) and store some data to the HTTP session (e.g. name=OmniFish). 

![image](https://github.com/user-attachments/assets/3207710c-1519-4d80-81e2-3ef95321920e)

Then access instance B (using the same IP address or domain as instance A). Instance B should report the same data stored in instance A - data is replicated.

![image](https://github.com/user-attachments/assets/d740b8e0-f377-40c4-ac79-fd7c09da7f3d)

If all instances run on the same IP, you can access the instance A and instance Bdirectly, using IP and port. 
The browser will send the session cookie to all instances.

If instances run behind a load balancer server, always access the application via the load balancer server. 
First, make the load balancer only work with instance A, then make it work with instance B.

# Build 

`mvn install`

# Run the application

## Create a cluster in GlassFish

![image](https://github.com/user-attachments/assets/70854ed1-faa1-411a-bbe9-9871fefa5843)

## Deploy the application

When deploying, enable availability and select the cluster as the target:

![image](https://github.com/user-attachments/assets/00ee3e47-8b2f-4cd8-9700-b46be3d4833c)

![image](https://github.com/user-attachments/assets/216d7440-8e16-4f56-a9e3-fd1966e9e44c)
