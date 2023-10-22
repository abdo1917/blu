import 'package:blu/homee.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../main.dart';
import '../controllers/device_controller.dart';
import '../helper/popup_dialogs.dart';
import 'connection_view.dart';
import 'data_logs_view.dart';
import 'devices_view.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
enum DevicePopupMenuItem {newDevice, saveDevice, loadDevice}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context,);
              }, icon: Icon(Icons.arrow_back,size: 30,))
        ],) ,
        backgroundColor: Colors.deepPurple,


        bottom: TabBar(
          controller: ctrl.tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.bluetooth ,size: 32,),
                SizedBox(width: 15,),

                // SizedBox(width: 10,),
                Text('Bluetooth',style: TextStyle(fontSize: 28, ),)
              ],),

            ),
            Tab(icon: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [

                // SizedBox(width: 10,),
                Text('data logs',style: TextStyle(fontSize: 28, ),)
              ],),

            ),




          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - kToolbarHeight * 1.2,
          child: TabBarView(
            controller: ctrl.tabController,
            children: const [
              // bluetooth connection tab
              ConnectionView(),

              // Data logs tab
              DataLogs(),


            ],
          ),
        ),
      ),
    );
  }

  void deleteLogs() {
    Get.back();
    ctrl.logs.value.clear();
    ctrl.logs.refresh();
    debugPrint('[main_view] Logs deleted');
  }


}
