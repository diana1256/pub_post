import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';


class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String result = "Сканируйте QR-код";

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сканер QR-кодов'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(result),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code ?? "Ошибка сканирования";
      });
      if (scanData.code != null && scanData.code!.isNotEmpty) {
        Fluttertoast.showToast(msg: "${scanData.code}");

        // Добавьте задержку перед переходом
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.of(context).pushNamed('/HomeScreen', arguments: scanData.code);
        });
      }
    });
  }


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

