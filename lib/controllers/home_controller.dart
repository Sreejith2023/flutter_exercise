import 'dart:convert';

import 'package:flutter_exercise/model/remote_response_model.dart';
import 'package:flutter_exercise/remote/network_handler.dart';
import 'package:flutter_exercise/resources/api_managers.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  RxList<Rows> homeList = List.filled(0,Rows(),growable: true).obs;
  RxList<Rows> filteredList = List.filled(0,Rows(),growable: true).obs;
  RxString title = "".obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    getHomeData(true);
    super.onInit();
  }

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

  setHomeListData(List<Rows> data){
    homeList.value = data;
    filteredList.value.clear();
    filterResponse("");

  }

  List<Rows> getHomeListData(){
    return homeList.value;
  }

  List<Rows> getFilteredListData(){
    return filteredList.value;
  }

  filterResponse(String key){
    for(Rows element in homeList){
      if(element.title!.toLowerCase().contains(key.toLowerCase())){
        filteredList.value.add(element);
        filteredList.refresh();
      }
    }
  }
}