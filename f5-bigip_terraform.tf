/*
Copyright 2019 F5 Networks Inc.
This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

terraform {
  required_providers {
    bigip = {
      source = "F5Networks/bigip"
      version = "1.16.2"
    }
  }
}

provider "bigip" {
  address  = "192.168.100.247"
  username = "admin"
  password = "xxxx"
}
resource "bigip_ltm_node" "node" {
  name             = "/Common/terraform_dvwa"
  address          = "192.168.204.212"
  monitor          = "/Common/gateway_icmp"
}
resource "bigip_ltm_monitor" "monitor" {
  name     = "/Common/terraform_monitor"
  parent   = "/Common/http"
  send     = "GET / HTTP/1.0\r\n\r\n"
  timeout  = "16"
  interval = "5"
}
resource "bigip_ltm_pool" "pool" {
  name                = "/Common/terraform-pool"
  load_balancing_mode = "round-robin"
  monitors            = ["/Common/terraform_monitor"]
  allow_snat          = "yes"
  allow_nat           = "yes"
  depends_on = [bigip_ltm_monitor.monitor, bigip_ltm_node.node] 
}
resource "bigip_ltm_pool_attachment" "attach_node1" {
  pool       = "/Common/terraform-pool"
  node       = "/Common/terraform_dvwa:80"
  depends_on = [bigip_ltm_pool.pool]
}
resource "bigip_ltm_virtual_server" "http" {
  pool                       = "/Common/terraform-pool"
  name                       = "/Common/terraform_vs_http"
  destination                = "192.168.203.212"
  port                       = 80
  source_address_translation = "automap"
  depends_on                 = [bigip_ltm_pool.pool]
}
