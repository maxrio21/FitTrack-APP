//BaseApiServices
abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getUserListResponse(String url, Map<String, String> headers);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> registerApi(String registerEndPoint, data);
}
