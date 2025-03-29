import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:http/http.dart' as http;

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(client: http.Client()));
  }
}
