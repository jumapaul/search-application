import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/http/mock/http_request_mock.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:search/app/modules/home/controllers/home_controller.dart';

@GenerateMocks([http.Client])
void main() {
  late HomeController homeController;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    homeController = HomeController();
    Get.put(HomeController());
    homeController = Get.find<HomeController>();
  });

  tearDown(() {
    Get.reset();
  });
}
