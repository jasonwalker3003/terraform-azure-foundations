resource "azurerm_public_ip" "vm" {
  name                = "pip-${var.prefix}"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.tags
}

resource "azurerm_network_interface" "vm" {
  name                = "nic-${var.prefix}"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  tags                = local.tags

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "vm-${var.prefix}"
  location              = azurerm_resource_group.lab.location
  resource_group_name   = azurerm_resource_group.lab.name
  size                  = var.vm_size
  admin_username        = "jason"
  network_interface_ids = [azurerm_network_interface.vm.id]
  tags                  = local.tags

  admin_ssh_key {
    username   = "jason"
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "vm" {
  virtual_machine_id    = azurerm_linux_virtual_machine.vm.id
  location              = azurerm_resource_group.lab.location
  enabled               = true
  daily_recurrence_time = "1900"
  timezone              = "GMT Standard Time"
  tags                  = local.tags

  notification_settings {
    enabled = false
  }
}
