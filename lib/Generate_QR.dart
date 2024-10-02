import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQr extends StatefulWidget {
  const GenerateQr({super.key});

  @override
  State<GenerateQr> createState() => _GenerateQrState();
}

class _GenerateQrState extends State<GenerateQr> {
  TextEditingController gen1Controller = TextEditingController();
  TextEditingController gen2Controller = TextEditingController();
  TextEditingController gen3Controller = TextEditingController();
  final GlobalKey qrkey = GlobalKey();
  bool dirExists = false;
  dynamic externalDir = '/storage/emulated/0/DCIM/Qr_code';

  Future<void> _captureAndSavePng() async {
    try{
      RenderRepaintBoundary boundary = qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      final whitePaint = Paint()..color = Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder,Rect.fromLTWH(0,0,image.width.toDouble(),image.height.toDouble()));
      canvas.drawRect(Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()), whitePaint);
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      String fileName = 'qr_code';
      int i = 1;
      while(await File('$externalDir/$fileName.png').exists()){
        fileName = 'qr_code_$i';
        i++;
      }
      dirExists = await File(externalDir).exists();
      if(!dirExists){
        await Directory(externalDir).create(recursive: true);
        dirExists = true;
      }

      final file = await File('$externalDir/$fileName.png').create();
      await file.writeAsBytes(pngBytes);

      if(!mounted)return;
      const snackBar = SnackBar(content: Text('QR code saved to gallery'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }catch(e){
      if(!mounted)return;
      const snackBar = SnackBar(content: Text('Something went wrong!!!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
@override
  Widget build(BuildContext context) {
    // final GlobalKey qrKey = GlobalKey();
    String qrData =
        '${gen1Controller.text},${gen2Controller.text},${gen3Controller.text}';
    return Scaffold(
        appBar: AppBar(
          title: const Text("Enter the data"),
          backgroundColor: Colors.cyan,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (gen1Controller.text.isNotEmpty)
                  SizedBox(
                    height: 300,
                    width: 300,
                      child: RepaintBoundary(
                        key: qrkey,
                        child: QrImageView(
                          data: qrData,
                          version: QrVersions.auto,
                          size: 250.0,
                        ),
                      ),
                    ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: gen1Controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter data to generate QR',
                      prefixIcon: Icon(Icons.add_comment_outlined),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: gen2Controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter data to generate QR',
                      prefixIcon: Icon(Icons.add_comment_outlined),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: gen3Controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter data to generate QR',
                      prefixIcon: Icon(Icons.add_comment_outlined),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.cyan),
                  ),
                  child: const Text('Generate QR Code',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _captureAndSavePng,
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.cyan),
                  ),
                  child: const Text('Download QR Code',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        )
    );
  }
}
// Future<Uint8List?> _capturePng(dynamic qrKey) async {
//   try {
//     RenderRepaintBoundary boundary = qrKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
//     var image = await boundary.toImage(pixelRatio: 3.0);
//     final ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }

// Future<Uint8List> captureWidget() async {
//
//   final RenderRepaintBoundary boundary = qrKey.currentContext.findRenderObject();
//
//   final ui.Image image = await boundary.toImage();
//
//   final ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//
//   final Uint8List pngBytes = byteData.buffer.asUint8List();
//
//   return pngBytes;
// }