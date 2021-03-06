terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
}

module "main" {
  source = "../.."

  name       = "VP1"
  allocation = "dynamic"
  ranges = [{
    from       = 2
    to         = 3
    allocation = "static"
    role       = "internal"
  }]
}

data "aci_rest_managed" "fvnsVlanInstP" {
  dn = "uni/infra/vlanns-[${module.main.name}]-dynamic"

  depends_on = [module.main]
}

resource "test_assertions" "fvnsVlanInstP" {
  component = "fvnsVlanInstP"

  equal "name" {
    description = "name"
    got         = data.aci_rest_managed.fvnsVlanInstP.content.name
    want        = module.main.name
  }

  equal "allocMode" {
    description = "allocMode"
    got         = data.aci_rest_managed.fvnsVlanInstP.content.allocMode
    want        = "dynamic"
  }
}

data "aci_rest_managed" "fvnsEncapBlk" {
  dn = "${data.aci_rest_managed.fvnsVlanInstP.id}/from-[vlan-2]-to-[vlan-3]"

  depends_on = [module.main]
}

resource "test_assertions" "fvnsEncapBlk" {
  component = "fvnsEncapBlk"

  equal "from" {
    description = "from"
    got         = data.aci_rest_managed.fvnsEncapBlk.content.from
    want        = "vlan-2"
  }

  equal "to" {
    description = "to"
    got         = data.aci_rest_managed.fvnsEncapBlk.content.to
    want        = "vlan-3"
  }

  equal "allocMode" {
    description = "allocMode"
    got         = data.aci_rest_managed.fvnsEncapBlk.content.allocMode
    want        = "static"
  }

  equal "role" {
    description = "role"
    got         = data.aci_rest_managed.fvnsEncapBlk.content.role
    want        = "internal"
  }
}
