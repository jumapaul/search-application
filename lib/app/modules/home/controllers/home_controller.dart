import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:search/app/Common/constants/constants.dart';
import 'package:search/app/Common/resources/data_state.dart';

import '../../../data/repo_response.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  TextEditingController nameEditTextController = TextEditingController();
  var repositories = Rx<DataState<RepoResponse>>(const Empty());
  var type = 'all'.obs;
  var page = 1.obs;
  var changeSortDirection = false.obs;
  var sortDirection = "asc".obs;
  var typesListing = ["all", "public", "private", "forks", "sources", "member"];

  void toggleDirection() {
    changeSortDirection.value = !changeSortDirection.value;
    if (changeSortDirection.value) {
      sortDirection.value = "desc";
    } else {
      sortDirection.value = "asc";
    }
  }

  loadNextPage() async {
    page.value++;
    await _fetchRepositories(page.value);
  }

  loadPreviousPage() async {
    if (page.value > 1) {
      page.value--;
      await _fetchRepositories(page.value);
    }
  }

  getUserRepositories() async => await _fetchRepositories(1);

  _fetchRepositories(int page) async {
    try {
      repositories.value = Initial();
      var url =
          "${Constants.BASE_URL}${nameEditTextController.text}/repos?per_page=10&page=$page&type=${type.value}&direction=${sortDirection.value}";
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);

        List<RepoResponse> repoList =
            jsonList
                .map((repoJson) => RepoResponse.fromJson(repoJson))
                .toList();
        repositories.value = Success(repoList);
      } else {
        repositories.value = Error("Enter github username");
      }
    } catch (e) {
      repositories.value = Error("Network error");
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
