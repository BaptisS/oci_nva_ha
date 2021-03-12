# oci_nva_ha

The following document will guide you through the configuration of HA scenarios for generic Network Virtual Appliances. (NAT Instance on Oracle Linux as an example here) 
 Oracle's managed components to monitor and failover a VIP between Compute instance nodes when required.  

- API Gateway 
- Health Checks
- Fn

- Compute instances (x2) 

1.1- Provision NAT instances on Oracle linux (for the purpose of the demonstration)

      Collect required OCID (Nodes's Vnics + private VIP OCID)
      - Nodes primary network interface OCID
      - Secondary private ip address OCID (known as 'private vip')
      
2.1- Create your Fn HC App

2.1.1- OCI Menu --> Developper Services --> Functions --> Create Application 

- Provide a Name (ie. 'nvahc')
- Choose a VCN and select up to 3 subnets to host your Fn instance. 

2.1.2- Follow the 'Getting started' (Cloud Shell Setup) Steps. [Step 1 -> Step 7]

2.1.3- Execute the following commands : 

      mkdir nvahc
      cd nvahc
      wget https://raw.githubusercontent.com/BaptisS/oci_nva_ha/main/requirements.txt
      wget https://raw.githubusercontent.com/BaptisS/oci_nva_ha/main/func.py
      wget https://raw.githubusercontent.com/BaptisS/oci_nva_ha/main/func.yaml
      fn -v deploy --app nvahc



2.2- Add Required Variables as shown below

![PMScreens](https://github.com/BaptisS/oci_nva_ha/blob/main/img/FnConf01.JPG)


3- Create Dynamic Group + IAM Policies.

3.1- Create Dynamic Group.

      ALL {resource.type = 'fnfunc', resource.compartment.id = 'ocid1.compartment.oc1..aaaaaxxxxxxxxxxxxxx'}

3.2- Create IAM Policies.

      Allow dynamic-group BSHA_GRP to use private-ips in compartment CSMs:Baptiste
      Allow dynamic-group BSHA_GRP to use vnics in compartment CSMs:Baptiste
      Allow dynamic-group BSHA_GRP to read instance-family in compartment CSMs:Baptiste
      Allow dynamic-group BSHA_GRP to read Virtual-network-family in compartment CSMs:Baptiste
      
      ALLOW any-user to use functions-family in compartment CSMs:Baptiste where ALL {request.principal.type= 'ApiGateway', request.resource.compartment.id = 'ocid1.compartment.oc1..aaaaaxxxxxxxxxxxxxx'}


4.1- Create an API Gateway instance to expose your Fn App. 

5.1- Create an Health Check instance to trigger regular execution of Fn App.


![PMScreens](https://github.com/BaptisS/oci_nva_ha/blob/main/img/FnHC00z.JPG)


6.1- Verify Failover.  
