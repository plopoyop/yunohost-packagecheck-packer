packer {
  required_version = ">= 1.7.0, < 2.0.0"

  required_plugins {
    qemu = {
      source  = "github.com/hashicorp/qemu"
      version = "~> 1"
    }
  }
}

variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "headless" {
  type    = string
  default = "false"
}

variable "shutdown_command" {
  type    = string
  default = "echo 'yunohost'|sudo -S /sbin/halt -h -p"
}

variable "ssh_port" {
  type    = string
  default = "22"
}

variable "ssh_private_key_file" {
  type    = string
  default = "/home/clement/.ssh/id_ed25519"
}

variable "ssh_timeout" {
  type    = string
  default = "10000s"
}

variable "vm_name_base" {
  type    = string
}

variable "ssh_pass" {
  type    = string
}
variable "ssh_user" {
  type    = string
}

variable "iso_urls" {
  type    = string
}

variable "box_cpus" {
  type    = string
}
variable "box_disk_size" {
  type    = string
}

variable "disk_name" {
  type    = string
}

variable "iso_sha256" {
  type    = string
}

variable "box_memory" {
  type    = string
}

variable "locales" {
  type    = string
  default = "fr_FR.UTF-8"
}

variable "keymap" {
  type    = string
  default = "fr"
}

locals {
  vm_name          = "${var.vm_name_base}"
  boot_command     = ["<esc><wait>",
        "install <wait>",
        "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
        "debian-installer=${var.locales} <wait>",
        "auto <wait>",
        "locale=${var.locales} <wait>",
        "kbd-chooser/method=${var.keymap} <wait>",
        "keyboard-configuration/xkb-keymap=${var.keymap} <wait>",
        "netcfg/get_hostname={{ .Name }} <wait>",
        "netcfg/get_domain=yunohost.local <wait>",
        "fb=false <wait>",
        "debconf/frontend=noninteractive <wait>",
        "console-setup/ask_detect=false <wait>",
        "console-keymaps-at/keymap=${var.keymap} <wait>",
        "grub-installer/bootdev=${var.disk_name} <wait>",
        "<enter><wait>"]
}

source "qemu" "ynh_package_check" {
    boot_command            = "${local.boot_command}"

    boot_wait               = "${var.boot_wait}"
    disk_size               = "${var.box_disk_size}"
    headless                = "${var.headless}"
    iso_checksum            = "sha256:${var.iso_sha256}"
    iso_urls                = ["${var.iso_urls}"]
    output_directory        = "./output/"
    shutdown_command        = "${var.shutdown_command}"
    ssh_password            = "${var.ssh_pass}"
    ssh_port                = "${var.ssh_port}"
    ssh_timeout             = "${var.ssh_timeout}"
    ssh_username            = "${var.ssh_user}"
    vm_name                 = "${local.vm_name}"
    http_directory          = "http"
    net_device              = "virtio-net"
    disk_interface          = "virtio"
    cpus                    = "${var.box_cpus}"
    memory                  = "${var.box_memory}"
    qemuargs                = [["-cpu", "host"]]
    format                  = "qcow2"
}

build {
  sources = ["source.qemu.ynh_package_check"]

  provisioner "shell" {
    remote_path = "/home/yunohost/setup.sh"
    script     = "scripts/setup.sh"
    execute_command = "echo 'yunohost' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
  }

  provisioner "shell" {
    remote_path = "/home/yunohost/incus.sh"
    script     = "scripts/tools.sh"
    execute_command = "echo 'yunohost' | {{ .Vars }} bash '{{ .Path }}'"
  }

  provisioner "shell" {
      inline = ["sudo systemctl reboot"]
      expect_disconnect = true
      timeout = "5m"
  }

  provisioner "shell" {
    remote_path = "/home/yunohost/yunohost.sh"
    script     = "scripts/yunohost.sh"
    execute_command = "echo 'yunohost' | {{ .Vars }} bash '{{ .Path }}'"
  }

  provisioner "shell" {
    execute_command = "echo 'yunohost' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    remote_path     = "/home/yunohost/cleanup.sh"
    script          = "scripts/cleanup.sh"
  }
}
