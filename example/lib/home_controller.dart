// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:math';

import 'package:ble_peripheral/ble_peripheral.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class BleClient {
  String? name;
  String deviceId;
  Set<String> subscribedChars;

  BleClient({
    required this.name,
    required this.deviceId,
    required this.subscribedChars,
  });
}

class HomeController extends GetxController {
  RxBool isAdvertising = false.obs;
  RxBool isBleOn = false.obs;
  RxList<BleClient> devices = <BleClient>[].obs;

  String get deviceName => switch (defaultTargetPlatform) {
        TargetPlatform.android => "BleDroid",
        TargetPlatform.iOS => "BleIOS",
        TargetPlatform.macOS => "BleMac",
        TargetPlatform.windows => "BleWin",
        _ => "TestDevice"
      };

  // Battery Service
  String serviceBattery = "0000180F-0000-1000-8000-00805F9B34FB";
  String characteristicBatteryLevel = "00002A19-0000-1000-8000-00805F9B34FB";
  // Test service
  String serviceTest = "0000180D-0000-1000-8000-00805F9B34FB";
  String characteristicTest = "00002A18-0000-1000-8000-00805F9B34FB";

  @override
  void onInit() {
    _initialize();
    // setup callbacks
    BlePeripheral.setBleStateChangeCallback(isBleOn);

    BlePeripheral.setAdvertisingStatusUpdateCallback(
        (bool advertising, String? error) {
      isAdvertising.value = advertising;
      Get.log("AdvertingStarted: $advertising, Error: $error");
    });

    BlePeripheral.setCharacteristicSubscriptionChangeCallback((
      String deviceId,
      String characteristicId,
      bool isSubscribed,
      String? name,
    ) {
      Get.log(
        "onCharacteristicSubscriptionChange: $deviceId : $characteristicId $isSubscribed Name: $name",
      );

      int? index = devices.indexWhere((e) => e.deviceId == deviceId);
      if (isSubscribed) {
        if (index != -1) {
          devices[index].subscribedChars.add(characteristicId);
        } else {
          devices.add(BleClient(
            name: name,
            deviceId: deviceId,
            subscribedChars: {characteristicId},
          ));
        }
      } else {
        if (index != -1) {
          devices[index].subscribedChars.remove(characteristicId);
          if (devices[index].subscribedChars.isEmpty) {
            devices.removeWhere((e) => e.deviceId == deviceId);
          }
        }
      }
      devices.refresh();
    });

    BlePeripheral.setReadRequestCallback(
        (deviceId, characteristicId, offset, value) {
      Get.log("ReadRequest: $deviceId $characteristicId : $offset : $value");
      return ReadRequestResult(value: utf8.encode("Hello World"));
    });

    BlePeripheral.setWriteRequestCallback(
        (deviceId, characteristicId, offset, value) {
      Get.log("WriteRequest: $deviceId $characteristicId : $offset : $value");
      // return WriteRequestResult(status: 144);
      return null;
    });

    // Android only
    BlePeripheral.setBondStateChangeCallback((deviceId, bondState) {
      Get.log("OnBondState: $deviceId $bondState");
    });

    super.onInit();
  }

  void _initialize() async {
    try {
      await BlePeripheral.initialize();
    } catch (e) {
      Get.log("InitializationError: $e");
    }
  }

  void startAdvertising() async {
    Get.log("Starting Advertising");
    await BlePeripheral.startAdvertising(
      services: [serviceBattery, serviceTest],
      localName: deviceName,
      manufacturerData: ManufacturerData(
        manufacturerId: 0x012D,
        data: Uint8List.fromList([0x01, 0x02, 0x03]),
      ),
      addManufacturerDataInScanResponse: true,
    );
  }

  void addServices() async {
    try {
      var notificationControlDescriptor = BleDescriptor(
        uuid: "00002908-0000-1000-8000-00805F9B34FB",
        value: Uint8List.fromList([0, 1]),
        permissions: [
          AttributePermissions.readable,
          AttributePermissions.writeable
        ],
      );

      await BlePeripheral.addService(
        BleService(
          uuid: serviceBattery,
          primary: true,
          characteristics: [
            BleCharacteristic(
              uuid: characteristicBatteryLevel,
              properties: [
                CharacteristicProperties.read,
                CharacteristicProperties.notify
              ],
              value: null,
              permissions: [AttributePermissions.readable],
            ),
          ],
        ),
      );

      await BlePeripheral.addService(
        BleService(
          uuid: serviceTest,
          primary: true,
          characteristics: [
            BleCharacteristic(
              uuid: characteristicTest,
              properties: [
                CharacteristicProperties.read,
                CharacteristicProperties.notify,
                CharacteristicProperties.write,
              ],
              descriptors: [notificationControlDescriptor],
              value: null,
              permissions: [
                AttributePermissions.readable,
                AttributePermissions.writeable
              ],
            ),
          ],
        ),
      );
      Get.log("Services added");
    } catch (e) {
      Get.log("Error: $e");
    }
  }

  void getAllServices() async {
    List<String> services = await BlePeripheral.getServices();
    Get.log(services.toString());
  }

  void removeServices() async {
    await BlePeripheral.clearServices();
    Get.log("Services removed");
  }

  /// Update characteristic value, to all the devices which are subscribed to it
  void updateCharacteristic() async {
    try {
      for (BleClient client in devices) {
        var value = "Hii ${Random().nextInt(100)}";
        BlePeripheral.updateCharacteristic(
          characteristicId: characteristicTest,
          value: utf8.encode(value),
          deviceId: client.deviceId,
        );
      }
    } catch (e) {
      Get.log("UpdateCharacteristicError: $e");
    }
  }

  void getSubscribedClients() async {
    List<SubscribedClient> clients = await BlePeripheral.getSubscribedClients();
    if (clients.isEmpty) {
      Get.log("No clients subscribed");
      return;
    }

    Get.log(clients
        .map((e) => {
              "DeviceId": e.deviceId,
              "SubscribedChars": e.subscribedCharacteristics
            })
        .join(", "));
  }
}
