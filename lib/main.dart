import 'package:flutter/material.dart';
import 'package:pyramakerz_task_f/modules/speech_recognition/views/speech_recognition_view.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpeechRecognitionView(),
    );
  }
}





