import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_exercise/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: RefreshIndicator(
          onRefresh: _refreshPage,
          child: listWidget(),
        ),
      ),
    );
  }

  listWidget() {
    return Obx(() {
      return controller.isLoading.value? progressWidget():controller.getFilteredListData().length>0?ListView.builder(
          itemCount: controller.getFilteredListData().length,
          itemBuilder: (BuildContext context, int index) {
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
                          Text("Title : ${controller.getFilteredListData()[index].title!}"),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                            "Description : ${controller.getFilteredListData()[index].description!}")),
                    CachedNetworkImage(
                      imageUrl: controller.getFilteredListData()[index].imageHref!,
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
          }):noDataWidget();
    });
  }

  Widget progressWidget(){
    return const Center(child: CircularProgressIndicator(),);
  }

  Widget noDataWidget(){
    return const Center(child: Text("No Data"),);
  }

  Future<void> _refreshPage() async {
    controller.getHomeData(false);
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 100,
      flexibleSpace: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Obx((){
                return Text(
                  controller.title.value,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                );
              })),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Title Here...',
              ),
              onChanged: (value){
                controller.filteredList.value.clear();
                controller.filteredList.refresh();
                controller.filterResponse(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
