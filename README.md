# oci_nva_ha

The following document will guide you through the configuration of HA scenarios for generic Network Virtual Appliances. (NAT Instance on Oracle Linux as an example here) 
 Oracle's managed components to monitor and failover a VIP between Compute instance nodes when required.  

- API Gateway 
- Health Checks
- Fn

- Compute instances (x2) 

1.1- Provision NAT instances on Oracle linux (for the purpose of the demonstration)

      Collect required OCID (Nodes's Vnics + private VIP OCID) 
      
2.1- Create your Fn HC App

3.1- Create Dynamic Group + IAM Policies.

4.1- Create an API Gateway instance to expose your Fn App. 

5.1- Create an Health Check instance to trigger regular execution of Fn App.

6.1- Verify Failover.  
