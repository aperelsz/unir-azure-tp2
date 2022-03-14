# PREPARAR EL AMBIENTE
</br>
</br>

## Configuraciones previas
---
</br>

Como KVM no se pudo ejecutar remoto, se agregaron dos llaves publicas, una la del equipo donde se ejecuta **Terraform** que debe ser el mismo equipo donde esta instalado **KVM**

La segunda, es para el equipo donde se ejecuta **Ansible** , esta se debe agregar a:
</br>

> ./kvm/terraform/ssh/id_rsa.pub
</br>

```

vi kvm/terraform/ssh/id_rsa.pub

```