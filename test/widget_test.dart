import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/app/Common/resources/data_state.dart';
import 'package:search/app/data/repo_response.dart';
import 'widget_test.mocks.dart';
import 'package:http/http.dart' as http;
import 'package:search/app/modules/home/controllers/home_controller.dart';

@GenerateMocks([http.Client])
void main() {
  late HomeController homeController;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    homeController = HomeController(client: mockClient);
    Get.put(HomeController(client: mockClient));
    homeController = Get.find<HomeController>();
  });

  test('Fetch repositories successfully', () async {
    final mockResponse = jsonEncode([
      {"id": 1, "name": "repo1", "description": "Test repo"},
      {"id": 2, "name": "repo2", "description": "Another repo"},
    ]);

    //simulate api returning 200 response
    when(
      mockClient.get(any),
    ).thenAnswer((_) async => http.Response(mockResponse, 200));

    await homeController.getUserRepositories();

    expect(homeController.repositories.value, isA<Success>());
    final successState = homeController.repositories.value as Success;
    expect(successState.data, isA<List<RepoResponse>>());
    expect((successState.data as List).length, 2);
  });

  test("Handles error response", () async {
    when(
      mockClient.get(any),
    ).thenAnswer((_) async => http.Response("Not found", 404));

    await homeController.getUserRepositories();

    expect(homeController.repositories.value, isA<Error>());

    final errorState = homeController.repositories.value as Error;
    expect(errorState.error, "Enter github username");
  });

  test('Handles network error', () async {
    when(mockClient.get(any)).thenThrow(Exception("Network error"));

    await homeController.getUserRepositories();

    expect(homeController.repositories.value, isA<Error>());

    final errorState = homeController.repositories.value as Error;

    expect(errorState.error, "Connect to internet");
  });

  tearDown(() {
    Get.reset();
  });
}
