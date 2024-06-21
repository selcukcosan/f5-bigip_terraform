# f5-bigip_terraform


# terraform init

selcuk@linux:~/terraform/test1$ terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of f5networks/bigip from the dependency lock file
- Using previously-installed f5networks/bigip v1.16.2

Terraform has been successfully initialized!



# terraform plan

selcuk@linux:~/terraform/test1$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:
```
  # bigip_ltm_monitor.monitor will be created
  + resource "bigip_ltm_monitor" "monitor" {
      + adaptive       = (known after apply)
      + adaptive_limit = (known after apply)
      + compatibility  = "enabled"
      + destination    = (known after apply)
      + id             = (known after apply)
      + interval       = 5
      + ip_dscp        = (known after apply)
      + manual_resume  = (known after apply)
      + mode           = (known after apply)
      + name           = "/Common/terraform_monitor"
      + parent         = "/Common/http"
      + reverse        = (known after apply)
      + send           = "GET / HTTP/1.0\\r\\n\\r\\n"
      + time_until_up  = (known after apply)
      + timeout        = 16
      + transparent    = (known after apply)
      + up_interval    = (known after apply)
    }

  # bigip_ltm_node.node will be created
  + resource "bigip_ltm_node" "node" {
      + address          = "192.168.204.212"
      + connection_limit = (known after apply)
      + dynamic_ratio    = (known after apply)
      + id               = (known after apply)
      + monitor          = "/Common/gateway_icmp"
      + name             = "/Common/terraform_dvwa"
      + rate_limit       = (known after apply)
      + ratio            = (known after apply)
      + session          = (known after apply)
      + state            = (known after apply)
    }

  # bigip_ltm_pool.pool will be created
  + resource "bigip_ltm_pool" "pool" {
      + allow_nat              = "yes"
      + allow_snat             = "yes"
      + id                     = (known after apply)
      + load_balancing_mode    = "round-robin"
      + minimum_active_members = (known after apply)
      + monitors               = [
          + "/Common/terraform_monitor",
        ]
      + name                   = "/Common/terraform-pool"
      + reselect_tries         = (known after apply)
      + service_down_action    = (known after apply)
      + slow_ramp_time         = (known after apply)
    }

  # bigip_ltm_pool_attachment.attach_node1 will be created
  + resource "bigip_ltm_pool_attachment" "attach_node1" {
      + connection_limit      = (known after apply)
      + connection_rate_limit = (known after apply)
      + dynamic_ratio         = (known after apply)
      + id                    = (known after apply)
      + node                  = "/Common/terraform_dvwa:80"
      + pool                  = "/Common/terraform-pool"
      + priority_group        = (known after apply)
      + ratio                 = (known after apply)
    }

  # bigip_ltm_virtual_server.http will be created
  + resource "bigip_ltm_virtual_server" "http" {
      + default_persistence_profile    = (known after apply)
      + destination                    = "192.168.203.212"
      + fallback_persistence_profile   = (known after apply)
      + firewall_enforced_policy       = (known after apply)
      + id                             = (known after apply)
      + ip_protocol                    = "tcp"
      + mask                           = (known after apply)
      + name                           = "/Common/terraform_vs_http"
      + per_flow_request_access_policy = (known after apply)
      + pool                           = "/Common/terraform-pool"
      + port                           = 80
      + profiles                       = (known after apply)
      + snatpool                       = (known after apply)
      + source                         = (known after apply)
      + source_address_translation     = "automap"
      + source_port                    = (known after apply)
      + state                          = "enabled"
      + trafficmatching_criteria       = (known after apply)
      + translate_address              = "enabled"
      + translate_port                 = "enabled"
      + vlans_enabled                  = false
    }

Plan: 5 to add, 0 to change, 0 to destroy.
```

# terraform apply
