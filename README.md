# Packer Debian 12 for Yunohost Package Check

This project is a [Packer](https://www.packer.io/) template that allows building a preconfigured Debian 12 image to be used with [YunoHost](https://yunohost.org/)'s [package_check](https://github.com/YunoHost/package_check).

## 📦 Features
- Based on **Debian 12**
- SSH login credentials:
  - **Username**: `yunohost`
  - **Password**: `yunohost`
- Minimal setup and configuration to support `package_check`

## 🚀 Requirements
- [Packer](https://developer.hashicorp.com/packer/downloads) installed on your machine
- **QEMU**
- [Task](https://taskfile.dev/) installed for task automation

## 🛠️ Usage
### 1️⃣ Clone the repository
```sh
git clone https://github.com/plopoyop/yunohost-packagecheck-packer.git
cd yunohost-packagecheck-packer
```

### 2️⃣ Use Taskfile
This project includes a `Taskfile.yml` to simplify command execution:

- List all available tasks:
  ```sh
  task
  ```
- Initialize Packer plugins:
  ```sh
  task init
  ```
- Clean up previous build files:
  ```sh
  task clean
  ```
- Build the image:
  ```sh
  task build
  ```

The generated image will be available in the `output/yunohost-package-check` directory.

### 3️⃣ Manually build the image
If you prefer not to use `Taskfile`, run:
```sh
packer build .
```

### 4️⃣ Use the image
Once the build is complete, the image is ready to be used with YunoHost's `package_check`.

## 📜 License
This project is licensed under **MIT**. See the `LICENSE` file for more details.

## 🤝 Contribution
Contributions are welcome! Feel free to open an issue or a pull request.

---

💡 **Useful links**:
- [YunoHost package_check](https://yunohost.org/packaging_apps)
- [Packer Documentation](https://developer.hashicorp.com/packer/docs)
- [Taskfile.dev Documentation](https://taskfile.dev/)
