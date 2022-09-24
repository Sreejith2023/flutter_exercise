import 'dart:convert';

import 'package:flutter_exercise/model/remote_response_model.dart';
import 'package:flutter_exercise/remote/network_handler.dart';
import 'package:flutter_exercise/resources/api_managers.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  RxList<Rows> homeList = List.filled(0,Rows(),growable: true).obs;
  @override
  void onInit() {
    getHomeData();
    super.onInit();
  }

  getHomeData() async{
    var response = await NetworkHandler()
        .get(AppApis.apiUrl);

    RemoteResponseModel remoteResponseModel = RemoteResponseModel.fromJson(jsonDecode(response));
    print("response ${remoteResponseModel.toString()}");
    setHomeListData(remoteResponseModel.rows!);

  }

  setHomeListData(List<Rows> data){
    homeList.value = data;
  }

  List<Rows> getHomeListData(){
    return homeList.value;
  }
}