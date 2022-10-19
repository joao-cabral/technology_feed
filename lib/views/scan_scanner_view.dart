import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:technology_feed/controllres/subreddit_controller.dart';

//Codigo retirado da documentação https://pub.dev/packages/qr_code_scanner

class ScanScannerView extends StatefulWidget {
  const ScanScannerView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanScannerViewState();
}

class _ScanScannerViewState extends State<ScanScannerView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('Iniciar camera',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    final subredditController =
        Provider.of<SubredditController>(context, listen: false);

    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      subredditController.controllerSearchSubreddit.text = scanData.code!;
      controller.dispose();
      Navigator.pop(context);
    });
  }

  void _onPermissionSet(
      BuildContext context, QRViewController ctrl, bool permission) {
    if (!permission) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permissão negada')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
