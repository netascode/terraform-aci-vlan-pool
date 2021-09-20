output "dn" {
  value       = aci_rest.fvnsVlanInstP.id
  description = "Distinguished name of `fvnsVlanInstP` object."
}

output "name" {
  value       = aci_rest.fvnsVlanInstP.content.name
  description = "Vlan pool name."
}
