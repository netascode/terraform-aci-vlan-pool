module "aci_vlan_pool" {
  source  = "netascode/vlan-pool/aci"
  version = ">= 0.1.0"

  name       = "VP1"
  allocation = "dynamic"
  ranges = [{
    from       = 2
    to         = 3
    allocation = "static"
    role       = "internal"
  }]
}
