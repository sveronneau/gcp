Sample code to deploy simple VM in deployement manager via the Privat Catalog.  This VM will have no external IP and as OS_LOGIN and OS_LOGIN_2FA enabled via metadata

Zip the 2 files together under the name test.zip to use in GCP Private Catalog

To limit a user access rights while giving them acces to the catalog, you'll need to assign the following roles:

* Custom-AI-PrivateCatalogUser-DM-VM
* Compute OS Login
* Compute Viewer
* Service Account User
* IAP-secured Tunnel User
* A CUSTOM ROLE WITH THE FOLLOWING ROLES
** compute.instances.setMetadata
** compute.instances.start
** compute.instances.stop
** deploymentmanager.deployments.create
** deploymentmanager.deployments.delete
** deploymentmanager.deployments.get
** deploymentmanager.deployments.list
** deploymentmanager.deployments.stop
