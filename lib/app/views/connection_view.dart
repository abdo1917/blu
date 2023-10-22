import 'package:blu/app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import '../../bluetooth_data.dart';
import '../../main.dart';
import '../../utils.dart';

class ConnectionView extends StatelessWidget {
  const ConnectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Obx(() {
          return Visibility(
            visible: ctrl.isConnecting.value,
            child: const LinearProgressIndicator(
              backgroundColor: Colors.yellow,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        }),

        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 15,),
                Obx(() {
                  return
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Text(
                          ' Bluetooth',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        Transform.scale(
                          scale: 1.3,
                          child: Switch(

                            // value: BluetoothData.instance.bluetoothState.isEnabled,
                            value: ctrl.isBluetoothActive.value,
                            onChanged: (bool value) async {
                              if (value) {
                                await FlutterBluetoothSerial.instance.requestEnable();
                                await BluetoothData.instance.getPairedDevices();
                              } else {
                                if (ctrl.isConnected.isTrue) {
                                  BluetoothData.instance.disconnect();
                                }
                                await FlutterBluetoothSerial.instance.requestDisable();
                              }
                            },

                          ),

                        ),



                      ],
                    );
                }),


                const SizedBox(height: 20,),
                const Text(
                  "",
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),

                Obx((){
                  return
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Available Devices",style: TextStyle(fontSize: 24),),
                            SizedBox(width: 95,),
                            refreshButton()
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(

                          children: <Widget>[
                            const Text(
                              '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              
                              child:buildDeviceDropDown() ,
                              width: MediaQuery.of(context).size.width *.9,
                              padding: EdgeInsets.all(14),
                            )



                          ],
                        ),

                        
                        const SizedBox(height: 20,),
                        // auto reconnect switch

                      ],
                    );
                }),
                SizedBox(height: 30,),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(

                        children: <Widget>[
                          // ElevatedButton(
                          //
                          //   style: ButtonStyle(
                          //
                          //     backgroundColor: MaterialStateProperty.all(
                          //         (ctrl.selectedDevice.value != 'Device' &&
                          //             ctrl.selectedDevice.value != '' &&
                          //             ctrl.isConnecting.isFalse &&
                          //             ctrl.isBluetoothActive.isTrue)
                          //             ? AppColors.activeButton
                          //             : AppColors.inActiveButton
                          //     ),
                          //   ),
                          //   onPressed: () {
                          //     onPressedConnectButton();
                          //   },
                          //
                          //   child: Text(ctrl.isConnected.isTrue
                          //       ? 'Disconnect'
                          //       : ctrl.isConnecting.isTrue
                          //       ? 'Connecting'
                          //       : 'Connect'
                          //   ),
                          // ),

                          InkWell(
                            onTap:() {
                              FlutterBluetoothSerial.instance.openSettings();
                            } ,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Additional Settings",style: TextStyle(fontSize: 20),),
                                 Icon( Icons.arrow_forward_ios),
                                ],
                              ),
                            ),
                          )
                          // ElevatedButton(
                          //   // elevation: 2,
                          //   child: const Text("Bluetooth Settings"),
                          //   onPressed: () {
                          //     FlutterBluetoothSerial.instance.openSettings();
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )

      ],
    );
  }

  refreshButton() {
    return
      SingleChildScrollView(
        child: Row(
          children: [
            Container(
              height: 80,
              width: 50,
              child: FloatingActionButton(

                child: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 20,
                ),

                // style: ButtonStyle(
                //   backgroundColor: MaterialStateProperty.all(
                //       ctrl.isBluetoothActive.value ? AppColors.activeButton : AppColors.inActiveButton
                //   ),
                // ),
                onPressed: () async {
                  // So, that when new devices are paired
                  // while the app is running, user can refresh
                  // the paired devices list.
                  if (ctrl.isBluetoothActive.value) {
                    await BluetoothData.instance.getPairedDevices().then((_) {
                      // showSnackBar('Device list refreshed');
                      showGetxSnackbar('Devices refreshed', 'Device list refreshed');
                      ctrl.refreshDeviceList();
                      ctrl.refreshLogs(text:'Device list refreshed');
                    });
                  } else {
                    null;
                  }
                },
              ),
            ),
          ],
        ),
      );
  }

  // void onPressedConnectButton() {
  //   // if bluetooth not active or bluetooth active but still connecting, then
  //   // nothing to_do if user press the button
  //   if (ctrl.isBluetoothActive.isFalse || ctrl.isConnecting.isTrue) {
  //     null;
  //   }
  //   else {
  //     if (ctrl.selectedDevice.value != '' &&
  //         ctrl.selectedDevice.value != 'NONE') {
  //       if (ctrl.isConnecting.isFalse) {
  //         if (ctrl.isConnected.isTrue) {
  //           BluetoothData.instance.isDisconnecting = true;
  //           BluetoothData.instance.disconnect();
  //         } else {
  //           debugPrint('[connection_view] connecting...');
  //           BluetoothData.instance.connect();
  //         }
  //       }
  //     }
  //   }
  //
  // }

  buildDeviceDropDown() {
    var devList = ctrl.deviceItems.value.map<DropdownMenuItem<BluetoothDevice>>((dev) {
      return DropdownMenuItem(value: dev, child: Text(dev.name!));
    }).toList();

    return
      DropdownButton(
        // elevation: 0,
          menuMaxHeight: 300,
          items: devList,
          onChanged: (value) {
            if (value != null && value.name != 'NONE') {
              BluetoothData.instance.device = value;
              ctrl.devIndex.value = ctrl.deviceItems.value.indexWhere((element) {
                return element.name == value.name;
              });
              if (ctrl.isBluetoothActive.isFalse || ctrl.isConnecting.isTrue) {
                null;
              }
              else {
                if (ctrl.selectedDevice.value != '' &&
                    ctrl.selectedDevice.value != 'NONE') {
                  if (ctrl.isConnecting.isFalse) {
                    if (ctrl.isConnected.isTrue) {
                      BluetoothData.instance.isDisconnecting = true;
                      BluetoothData.instance.disconnect();
                    } else {
                      debugPrint('[connection_view] connecting...');
                      BluetoothData.instance.connect();
                    }
                  }
                }
              }

            }

            ctrl.selectedDevice.value = value!.name!;

            // print('[connection_view] ctrl.devIndex.value ${ctrl.devIndex.value}');
            // print('[connection_vew] value.name ${value?.name}');

            // ctrl.selectedDevice.value = value == null ? 'NONE' : '${value.name}\n${value.address}';
            // ctrl.selectedDevice.value = value == null ? 'NONE' : '${value.name}';
          },
          value: ctrl.deviceItems.value[ctrl.devIndex.value]
      );

  }
}






