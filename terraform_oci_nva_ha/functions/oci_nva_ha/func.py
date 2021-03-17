import io
import json
import logging
import time
import requests
import oci
import os

from fdk import response

vnic_id_node1 = os.getenv("node01_vnic_ocid")
vnic_id_node2 = os.getenv("node02_vnic_ocid")
private_ip_id = os.getenv("vip_ocid")

update_private_ip_node1_details=oci.core.models.UpdatePrivateIpDetails(vnic_id=vnic_id_node1)
update_private_ip_node2_details=oci.core.models.UpdatePrivateIpDetails(vnic_id=vnic_id_node2)

def instance_status(compute_client, instance_id):
    return compute_client.get_instance(instance_id).data.lifecycle_state

def update_ip_node1(network_client, vnic_id, private_ip_id):
    update_ip_node1_response = network_client.update_private_ip(private_ip_id, update_private_ip_node1_details).data
    return update_ip_node1_response

def update_ip_node2(network_client, vnic_id, private_ip_id):
    update_ip_node2_response = network_client.update_private_ip(private_ip_id, update_private_ip_node2_details).data
    return update_ip_node2_response

def whos_primary(network_client, private_ip_id):
    whos_primary_response = network_client.get_private_ip(private_ip_id).data
    return whos_primary_response

def handler(ctx, data: io.BytesIO=None):

    signer = oci.auth.signers.get_resource_principals_signer()
    network_client = oci.core.VirtualNetworkClient(config={}, signer=signer)
    
    probe_url = os.getenv("probe_url")    
    probe_timeout = int(os.getenv("probe_timeout"))

    i=0
    failcount=0
    
    update_private_ip_node1_details=oci.core.models.UpdatePrivateIpDetails(vnic_id=vnic_id_node1)
    update_private_ip_node2_details=oci.core.models.UpdatePrivateIpDetails(vnic_id=vnic_id_node2)
    
    while i < 9:
        try:
            probe = requests.get(probe_url, timeout=probe_timeout)
            logging.getLogger().info('\nHTTP code:', probe.status_code)
            keyword = 'buttonv2.jpg'
            probedata = probe.text
            result = probedata.find(keyword)
            if result > 0:
                     #print ('Keyword found !')
                     logging.getLogger().info('Keyword found !')
            else:
                     failcount += 1
                     logging.getLogger().info('Keyword NOT found !')
        except:
            failcount += 1
            logging.getLogger().info('HTTP ERROR')
        time.sleep(1)
        i += 1
        failresult=("RAS")
        fail_limit = os.getenv("fail_limit")
        if failcount >= (int(fail_limit)):
              logging.getLogger().info("Target Unreachable - Failing over VIP")
              primary = whos_primary(network_client, private_ip_id)
              logging.getLogger().info(primary.vnic_id)
              if (primary.vnic_id) == (vnic_id_node1):
                  failto2 = update_ip_node2(network_client, vnic_id_node2, private_ip_id)
                  failresult=(failto2.vnic_id)
                  logging.getLogger().info(failto2.vnic_id)
                  time.sleep(1)
                  failcount = 0
              elif (primary.vnic_id) == (vnic_id_node2):
                  failto1 = update_ip_node1(network_client, vnic_id_node1, private_ip_id)
                  failresult=(failto1.vnic_id)
                  logging.getLogger().info(failto1.vnic_id)
                  time.sleep(1)
                  failcount = 0
              else:
                  failresult=('Failed to match Node VNIC OCID')
                  logging.getLogger().info('Failed to match Node VNIC OCID')
                  raise

    return response.Response(
                    ctx,
                    response_data=json.dumps({"status": "{0}".format(failresult)}),
                    headers={"Content-Type": "application/json"}
              )
              
