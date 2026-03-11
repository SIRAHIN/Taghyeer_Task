class ApiEndpoints {
  static const String baseUrl = "https://dummyjson.com";
  static const String loginUrl = "/auth/login";
  static String getProdcutsUrl({required String skip}) => '$baseUrl/products?limit=10&skip=$skip';
  static String getPostsUrl({required String skip}) => '$baseUrl/posts?limit=10&skip=$skip';
}