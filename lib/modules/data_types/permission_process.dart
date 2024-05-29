enum PermissionClient {camera, storage, contacts}

class PermissionProcessModel
{
  PermissionClient permissionClient;
  Function() onPermissionGranted;
  Function() onPermissionDenied;

  PermissionProcessModel({
    required this.permissionClient,
    required this.onPermissionGranted,
    required this.onPermissionDenied,
  });
}