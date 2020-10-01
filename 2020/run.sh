#!/bin/bash
openstack stack create -t autoscaling.yaml --parameter image=CentOS_7_7_final_raw \
    --parameter flavor=m1.medium \
    --parameter lb_network=xxxx \
    --parameter asg_network=xxxx \
    --parameter lb_subnet_id=xxxxx
    --parameter asg_subnet_id=xxxxx \
    test-autoscaling
