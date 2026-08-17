class LocationPermissionException implements Exception {
  LocationPermissionException([this.message = 'Quyền vị trí bị từ chối']);

  final String message;
}

class LocationDisabledException implements Exception {
  LocationDisabledException([this.message = 'Dịch vụ định vị chưa được bật']);

  final String message;
}

class NetworkException implements Exception {
  NetworkException([this.message = 'Không có kết nối mạng']);

  final String message;
}
