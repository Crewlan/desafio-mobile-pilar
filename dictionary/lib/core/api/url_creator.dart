abstract class IUrlCreator {
  String create({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    List<String>? pathSegments,
    String scheme,
    String? hostKey,
    int? port,
  });
}

class UrlCreator implements IUrlCreator {
  @override
  String create({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    List<String>? pathSegments,
    String scheme = 'https',
    String? hostKey,
    int? port,
  }) {
    return Uri(
      scheme: scheme,
      host: 'https://wordsapiv1.p.rapidapi.com',
      port: port,
      pathSegments: [...endpoint.split('/'), ...(pathSegments ?? [])],
      queryParameters: queryParameters,
    ).toString();
  }
}
