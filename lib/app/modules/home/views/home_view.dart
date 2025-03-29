import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:search/app/Common/resources/data_state.dart';
import 'package:search/app/Common/themes/themes.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Repositories'),
        centerTitle: true,
      ),
      body: Obx(() {
        var allRepos = controller.repositories.value.data;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _buildTopSection(context),
              SizedBox(height: 10),
              Expanded(
                flex: 7,
                child:
                    controller.repositories.value is Success &&
                            allRepos!.isNotEmpty
                        ? NotificationListener(
                          onNotification: (scrollNotification) {
                            if (scrollNotification is ScrollEndNotification &&
                                scrollNotification.metrics.pixels ==
                                    scrollNotification
                                        .metrics
                                        .maxScrollExtent) {
                              controller.loadNextPage();
                            }

                            return false;
                          },
                          child: RefreshIndicator(
                            onRefresh: () {
                              if (controller.page.value <= 1) {
                                controller.page.value = 1;
                              } else {
                                controller.page.value -= 1;
                              }
                              return controller.loadPreviousPage();
                            },
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                var repo =
                                    controller.repositories.value.data?[index];
                                return _buildRepoDetailsWidget(
                                  repo?.owner?.login,
                                  repo?.owner?.avatarUrl,
                                  repo?.name,
                                );
                              },
                              separatorBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                return SizedBox(height: 10);
                              },
                              itemCount: allRepos.length,
                            ),
                          ),
                        )
                        : controller.repositories.value is Success &&
                            allRepos!.isEmpty
                        ? Center(child: Text("No repo found"))
                        : controller.repositories.value is Empty
                        ? Center(child: Text("Enter github username"))
                        : controller.repositories.value is Error
                        ? Center(
                          child: Text("${controller.repositories.value.error}"),
                        )
                        : Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        );
      }),
    );
  }

  _buildTopSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(Get.context!).size.width * 0.27,
          child: DropdownButtonFormField(
            alignment: Alignment.center,
            value: controller.type.value,
            decoration: InputDecoration(),
            items:
                controller.typesListing.map((String value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
            onChanged: (newValue) {
              controller.type.value = newValue!;
              controller.getUserRepositories();
            },
            hint: Text("Type"),
          ),
        ),

        SizedBox(width: 5),
        Flexible(
          child: TextField(
            controller: controller.nameEditTextController,
            onSubmitted: (value) {
              controller.nameEditTextController.text = value;
              if (controller.nameEditTextController.text.isEmpty) {
                ScaffoldMessenger.of(Get.context!).showSnackBar(
                  SnackBar(content: Text("Enter github username")),
                );
                return;
              } else {
                controller.getUserRepositories();
              }
            },
            decoration: InputDecoration(
              hintText: "Enter github username",
              hintStyle: TextStyle(color: Colors.grey),
              suffixIcon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
        SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            controller.changeSortDirection;
            controller.getUserRepositories();
          },
          child: Image.asset(
            width: 30,
            height: 30,
            "assets/images/sort.png",
            color: Theme.of(context).extension<ImageTheme>()?.iconColor,
          ),
        ),
      ],
    );
  }

  _buildRepoDetailsWidget(username, avatarUrl, repoName) {
    return Card(
      color: Colors.grey[100],
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
            ),

            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(username, style: TextStyle(color: Colors.black)),
                SizedBox(height: 10),
                Text(repoName, style: TextStyle(color: Colors.black)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
