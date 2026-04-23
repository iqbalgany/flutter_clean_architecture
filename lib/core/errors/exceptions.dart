class CacheException implements Exception {
  final String? message;

  CacheException({this.message = 'Failed to load data from the cacher'});

  @override
  String toString() {
    return 'CacheException: $message';
  }
}

class ServerException implements Exception {
  final String? message;
  final int? statusCode;
  final dynamic originalError;

  ServerException({
    this.message = 'Failed to load data from the Server',
    this.statusCode,
    this.originalError,
  });

  @override
  String toString() {
    return 'ServerException: $message (Code: $statusCode)';
  }
}
