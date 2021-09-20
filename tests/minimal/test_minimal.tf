terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  name = "VP1"
}

data "aci_rest" "fvnsVlanInstP" {
  dn = "uni/infra/vlanns-[${module.main.name}]-static"

  depends_on = [module.main]
}

resource "test_assertions" "fvnsVlanInstP" {
  component = "fvnsVlanInstP"

  equal "name" {
    description = "name"
    got         = data.aci_rest.fvnsVlanInstP.content.name
    want        = module.main.name
  }
}
