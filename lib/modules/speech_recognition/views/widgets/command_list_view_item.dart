import 'package:flutter/material.dart';

import '../../cubit/speech_recognition_cubit.dart';

class CommandListViewItem extends StatelessWidget {
  const CommandListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    SpeechRecognitionCubit speechRecognitionCubit=SpeechRecognitionCubit.get(context);
    return Expanded(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) =>
              Text(speechRecognitionCubit.commandWords[index]),
          itemCount: speechRecognitionCubit.commandWords.length,
        ));
  }
}
