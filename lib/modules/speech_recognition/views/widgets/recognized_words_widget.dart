import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyramakerz_task_f/modules/speech_recognition/cubit/speach_recognition_state.dart';
import 'package:pyramakerz_task_f/modules/speech_recognition/cubit/speech_recognition_cubit.dart';

class RecognizedWordsWidget extends StatelessWidget {
  const RecognizedWordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeechRecognitionCubit, SpeechRecognitionState>(
        builder: (context,state) {
          SpeechRecognitionCubit speechRecognitionCubit = SpeechRecognitionCubit.get(context);
          return                  Text(
            speechRecognitionCubit.speechToText.isListening
                ? speechRecognitionCubit.recognizedWords
                : speechRecognitionCubit.isSpeechEnabled
                ? 'Tap the microphone to start listening...'
                : 'Speech not available',
          );
        }
    );
  }
}
