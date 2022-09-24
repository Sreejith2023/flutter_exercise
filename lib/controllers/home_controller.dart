import 'dart:convert';

import 'package:flutter_exercise/model/remote_response_model.dart';
import 'package:flutter_exercise/remote/network_handler.dart';
import 'package:flutter_exercise/resources/api_managers.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  List<Rows> homeList = List.filled(0,Rows(),growable: true);
  RxList<Rows> filteredList = List.filled(0,Rows(),growable: true).obs;
  RxString title = "".obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    getHomeData(true);
    super.onInit();
  }

  // Api calling, 'updateLoading' tag is to check whether
  // circular loading should show or not
  getHomeData(bool updateLoading) async{
    if(updateLoading) isLoading.value = true;
    var response = await NetworkHandler()
        .get(AppApis.apiUrl);

    RemoteResponseModel remoteResponseModel = RemoteResponseModel.fromJson(jsonDecode(response));
    if(updateLoading) isLoading.value = false;
    print("response ${remoteResponseModel.toString()}");
    title.value = remoteResponseModel.title!;
    setHomeListData(remoteResponseModel.rows!);

  }

  //update homeList values
  setHomeListData(List<Rows> data){
    homeList = data;
    filteredList.value.clear();
    filterResponse("");

  }

  //get the values in homelist
  List<Rows> getHomeListData(){
    return homeList;
  }

  //get the values in filtered list
  List<Rows> getFilteredListData(){
    return filteredList.value;
  }

  //filter the values based on the search key
  filterResponse(String key){
    for(Rows element in homeList){
      if(element.title!.toLowerCase().contains(key.toLowerCase())){
        filteredList.value.add(element);
        filteredList.refresh();
      }
    }
  }
}