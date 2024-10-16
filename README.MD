# Howdy

This repository contains all the materials, resources, and information related to my HashiConf 2024 presentation.

## Overview

Depending on the time and day you look at this, the information may be dated and/or will need to be modified to work on your own environments. 

### Packer 

All of my Packer builds are in the packer directory. All of my builds are in the builds directory and futher broken down. 

- github-actions-images  
    - Two Packer - Docker integration images. 
        - builder
            - This is the image which runs the Packer builds. 
        - listener
            - This is a unique image which listens to requests from GitHub actions and creates a unique Nomad job just for that run. 
- image-factory
    - There are base-images and app-images. 
        - Base images are built directly from the ISO and are general use. 
            - Ubuntu 24
            - RHEL 9
            - WIndows 202x
        - App images are a bit more specialized. 
            - Linux Docker Image
                - Nomad Images are from the Linux Docker Images.
            - Linux Nginx Image
            - Windows IIS Image

In the Packer directory, there are additional resources for common files, ansible-playbooks, manifests, and scripts. 

To help accelerate your onboarding, I recommend looking at what is already available in GitHub and other publicly available sources. 

For my presentation, I started with the [VMware Samples Packer Examples for vSphere](https://github.com/vmware-samples/packer-examples-for-vsphere) repository. Credit goes to the individuals who have maintained this repository and the vsphere plugins for Packer. 

### Terraform

The Terraform examples I have are relatively limited and mainly to test the integration between HCP Packer and HCP Terraform. There is not too much there to see. 

- workspaces

I've used this in the past to create workspaces, quick and easy way to get them set up. 

- image-test

Just a really quick thing I put together to test the provisioning the images after they had been created and stored in HCP Packer. 

### Nomad

So within the Nomad directory, there are mainly some job examples. 

The FDO directory I did not use during my presentation, but might have a use case for it in the future. Essentially was looking to run Terraform Enterprise on Nomad with all dependencies running on Nomad as well. If you are curious, you can see the storage requirements for FDO TFE : [Storage System Requirements](https://developer.hashicorp.com/terraform/enterprise/deploy/nomad#deploy-external-storage-systems).

