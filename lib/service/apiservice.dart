 import 'package:dio/dio.dart';
import 'package:ecom_test2/models/RespProducts.dart';
import 'package:logger/logger.dart';

class Apiservice {

late Dio _dio;
final logger = Logger();

Apiservice() {
  _dio = Dio(
    BaseOptions(
      baseUrl: "https://dummyjson.com",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ),
  );

  _dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      logger.i("url:${options.path}");
      logger.i("method:${options.method}");
      logger.i("baseurl:${options.baseUrl}");
      logger.i("headers:${options.headers}");
      logger.i("data:${options.data}");
      handler.next(options);
    },
    onResponse: (response, handler) {
      logger.i("statusCode:${response.statusCode}");
      logger.i("resp:${response.data}");
      handler.next(response);
    },
    onError: (error, handler) {
      logger.e("err:${error.message}");
      logger.e("stack trace:${error.stackTrace}");
      handler.next(error);
    },
  ));
}
Future<List<Products>?> getproducts() async {
  try{
    final response=await _dio.get("/products");
    if(response.statusCode==200){
      var resp=RespProducts.fromJson(response.data);
      return resp.products;
    }
  }
  on DioException catch(e){
    logger.e(e.message);
  }
  catch(e){
    print(e.toString());
  }
}


}