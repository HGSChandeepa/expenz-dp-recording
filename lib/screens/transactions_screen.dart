import 'package:flutter/material.dart';

class TranscatiosScreen extends StatefulWidget {
  const TranscatiosScreen({super.key});

  @override
  State<TranscatiosScreen> createState() => _TranscatiosScreenState();
}

class _TranscatiosScreenState extends State<TranscatiosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transcations Screen"),
      ),
    );
  }
}
