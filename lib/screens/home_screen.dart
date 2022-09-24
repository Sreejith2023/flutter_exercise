import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_exercise/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: RefreshIndicator(
        onRefresh: _refreshPage,
        child: listWidget(),
      ),
    );
  }

  listWidget() {
    return Obx(() {
      return ListView.builder(
          itemCount: controller.homeList.length,
          itemBuilder: (BuildContext context, int index) {
            print("current index $index");
            return Card(
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child:
                          Text("Title : ${controller.homeList[index].title!}"),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                            "Description : ${controller.homeList[index].description!}")),
                    CachedNetworkImage(
                      imageUrl: controller.homeList[index].imageHref!,
                      // imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg',
                      placeholder: (context, url) => Image(
                          image: AssetImage('asset/images/ic_profile.png')),
                      errorWidget: (context, url, error) => Image(
                          image: AssetImage('asset/images/ic_profile.png')),
                    ),
                  ],
                ),
              ),
            );
          });
    });
  }

  Future<void> _refreshPage() async {
    controller.getHomeData();
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text('App Title'),
      flexibleSpace: Container(
        child: TextField(),
      ),
    );
  }
}
