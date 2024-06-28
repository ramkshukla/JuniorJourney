import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stack_overflow/_util/app_constant.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  @override
  State<ScannerView> createState() => _ScannerViewState();
}

class _ScannerViewState extends State<ScannerView> with WidgetsBindingObserver {
  var myBox = Hive.box("myBox");
  List<String> localData = [];
  MobileScannerController controller = MobileScannerController(
    autoStart: true,
    facing: CameraFacing.back,
    torchEnabled: false,
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  List<String> codes = [];
  Barcode? _barcode;

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
    }
    codes.add(_barcode!.displayValue!);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      if (status == InternetStatus.connected) {
        print(status);
        syncData(localData: localData);
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    controller.barcodes.listen(
      _handleBarcode,
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> syncData({List<String>? localData}) async {
    print("Synced Successfuully");
    final url =
        Uri.parse('http://consumerapp.netcarrots.in/API/QRCodeSubmitAPI');
    final response = await http.post(url, body: {
      "MobileNo": "9999888800",
      "CustomerMobileNo": "9999999999",
      "Image": "",
      'QRCode': codes.join(','),
    });
    if (response.statusCode == 200) {
      print('Data synced successfully!');
    } else {
      print('Error syncing data: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("---Internet Connected : $status");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Scanner View",
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            child: MobileScanner(
              fit: BoxFit.contain,
              overlayBuilder: (context, constraints) {
                return SizedBox();
              },
              onDetect: (BarcodeCapture barcodes) {
                // print(">>>>>>>$barcodes");
              },
              errorBuilder: (p0, p1, p2) {
                print(">>>>>>>error");
                return SizedBox();
              },
              controller: controller,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: status == InternetStatus.disconnected
                  ? localData.length
                  : codes.length,
              itemBuilder: (context, index) {
                return status == InternetStatus.disconnected
                    ? Text(localData[index])
                    : Text(codes[index]);
              },
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              setState(() {
                myBox.put("data", codes);
                print("-----------------${myBox.get("data")}");
                localData = myBox.get("data") ?? [];
              });

              print("================Local Data : $localData");
              if (status == InternetStatus.connected) {
                syncData();
              } else {
                print("Waiting for Internet Connection");
              }
            },
            child: Text("Sync Data"),
          ),
          SizedBox(height: 80)
        ],
      ),
    );
  }
}
