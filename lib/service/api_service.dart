import 'package:dio/dio.dart';
import 'package:map_project_1/models/post_model.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class ApiService {
 factory ApiService(Dio dio) = _ApiService;

 @GET('posts')
 Future<List<PostModel>> getPosts();
}