# terraform-gcp-vm
# VM using Terraform

A Virtual Machine (VM) on Google Cloud Platform (GCP) is a virtualized computing resource that runs on Google’s infrastructure. GCP offers a service called Google Compute Engine (GCE) that allows users to create and manage VMs. These VMs provide the same functionality as physical servers, but with the flexibility and scalability of cloud computing.

## Key Features of VMs on GCP

### Customizable Machine Types
You can choose predefined machine types (e.g., `n1-standard-1`, `e2-medium`) or create custom machine types tailored to your specific needs in terms of CPU and memory.

### Operating System Choices
VMs can run various operating systems including multiple versions of Linux distributions (e.g., Debian, Ubuntu, CentOS) and Windows Server.

### Persistent Disks
VMs can be attached to persistent disks, which provide durable storage. These disks can be standard or SSD and can be resized without downtime.

### Networking
VMs can be connected to various networking services including Virtual Private Cloud (VPC), load balancers, and firewall rules to manage traffic.

### Scalability
Easily scale up or down based on demand. GCP supports automated scaling using managed instance groups.

### Security
GCP provides robust security features including encryption at rest and in transit, IAM policies for access control, and support for custom encryption keys.

### Global Availability
Deploy VMs in multiple regions and zones around the world, ensuring low latency and high availability.

## Creating and Managing VMs
We can create and manage VMs on GCP through several methods:

- **Google Cloud Console**: A web-based interface where you can create, configure, and manage VMs.
- **gcloud Command-Line Tool**: A CLI tool that allows you to manage GCP resources, including VMs, through commands.
- **Terraform**: Infrastructure as Code (IaC) tool that allows you to define and manage your GCP resources using configuration files.
- **APIs and SDKs**: Programmatically manage VMs using GCP’s APIs and client libraries available in multiple programming languages.

## Steps to Create a VM using Google Cloud Console
1. Go to the Google Cloud Console.
2. Navigate to **Compute Engine > VM instances**.
3. Click on **Create Instance**.
4. Fill in the necessary details like name, region, zone, machine type, boot disk, and network settings.
5. Click on **Create** to deploy the VM.

## Steps to Create a VM using Terraform

### 1. Set Up Your GCP Environment
#### a. Create a GCP Project
- Go to the **Google Cloud Console**.
- Create a new project or select an existing project.

#### b. Enable the Compute Engine API
- In the **Google Cloud Console**, navigate to **APIs & Services > Library**.
- Enable the **Compute Engine API**.

#### c. Create a Service Account
- Navigate to **IAM & Admin > Service Accounts**.
- Create a new service account, grant it the **Editor** role, and download the JSON key file.

### 2. Install Terraform
Download and install Terraform from the [official Terraform website](https://developer.hashicorp.com/terraform/downloads).

### 3. Authenticate Terraform with GCP
Set the environment variable for the Google Cloud credentials:
```sh
export GOOGLE_CLOUD_KEYFILE_JSON=/path/to/your-service-account-key.json
```

### 4. Write Terraform Configuration Files
#### a. Provider Configuration (`provider.tf`)
```hcl
provider "google" {
  credentials = file("/path/to/your-service-account-key.json")
  project     = "your-gcp-project-id"
  region      = "us-central1"
}
```

#### b. VM Instance Configuration (`main.tf`)
```hcl
resource "google_compute_instance" "default" {
  name         = "terraform-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "username:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD..."
  }

  tags = ["web", "dev"]
}
```

### 5. Initialize and Apply Terraform Configuration
#### a. Initialize the Terraform Configuration Directory
Navigate to your Terraform configuration directory and run:
```sh
terraform init
```

#### b. Review the Configuration Plan
Generate and review an execution plan:
```sh
terraform plan
```

#### c. Apply the Configuration
Apply the configuration to create the VM:
```sh
terraform apply
```

## Notes
- Replace `"/path/to/your-service-account-key.json"` with the actual path to your service account JSON key file.
- Replace `"your-gcp-project-id"` with your actual GCP project ID.
- Update the SSH key in the metadata section with your actual SSH public key.
- Adjust machine types, images, and other parameters as needed for your specific use case.

For more details, visit the [Terraform GCP Provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs).
