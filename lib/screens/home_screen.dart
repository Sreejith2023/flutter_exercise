import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_exercise/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  final searchController = TextEditingController();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: RefreshIndicator(
          onRefresh: _refreshPage,
          child: homeBody(),
        ),
      ),
    );
  }

  //Home page widgets rendering
  homeBody() {
    return Obx(() {
      return controller.isLoading.value
          ? progressWidget()
          : controller.getFilteredListData().isNotEmpty
              ? listItems()
              : noDataWidget();
    });
  }

  //list of items widget
  Widget listItems() {
    return ListView.builder(
        itemCount: controller.getFilteredListData().length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  itemRowTitle(index),
                  itemRowDescription(index),
                  itemRowImage(index),
                ],
              ),
            ),
          );
        });
  }

  //Each list item title widget
  Widget itemRowTitle(int index) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Text("Title : ${controller.getFilteredListData()[index].title!}"),
    );
  }

  //Each list item description widget
  Widget itemRowDescription(int index) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
          "Description : ${controller.getFilteredListData()[index].description!}"),
    );
  }

  //Each list item image widget
  Widget itemRowImage(int index) {
    return CachedNetworkImage(
      imageUrl: controller.getFilteredListData()[index].imageHref!,
      placeholder: (context, url) =>
          const Image(image: AssetImage('asset/images/ic_profile.png')),
      errorWidget: (context, url, error) =>
          const Image(image: AssetImage('asset/images/ic_profile.png')),
    );
  }

  //progress indicator widget while fetching data
  Widget progressWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  //no data widget to show when the list is empty
  Widget noDataWidget() {
    return const Center(
      child: Text("No Data"),
    );
  }

  //code to invoke while swiping in pull refresh
  Future<void> _refreshPage() async {
    controller.getHomeData(false);
  }

  //Appbar widgets
  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 100,
      flexibleSpace: Column(
        children: [
          pageTitle(),
          searchWidget(),
        ],
      ),
    );
  }

  //Appbar title
  Widget pageTitle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Obx(() {
        return Text(
          controller.title.value,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        );
      }),
    );
  }

  //Search widget in appbar
  Widget searchWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blueAccent),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: TextField(
        controller: searchController,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search Title Here...',
        ),
        onChanged: (value) {
          controller.filteredList.value.clear();
          controller.filteredList.refresh();
          controller.filterResponse(value);
        },
      ),
    );
  }
}
