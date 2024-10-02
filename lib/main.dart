import 'package:barcode_generator/Generate_QR.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Generator"),
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 160),
            SizedBox(
              height: 350,
              width: 350,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => GenerateQr()));
                    });
                  },
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.cyan),
                    shadowColor: WidgetStatePropertyAll(Colors.black),
                  ),
                  child: const Text(
                    "Generate QR Code",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black
                    ),
                  )
              ),
            ),
            const SizedBox(height: 160),
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width,
              color: Colors.cyan,
              child: const Center(
                child: Text(
                  "Recent QR Codes",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
