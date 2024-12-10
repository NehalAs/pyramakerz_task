import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyramakerz_task_f/modules/speech_recognition/cubit/speach_recognition_state.dart';
import 'package:pyramakerz_task_f/modules/speech_recognition/cubit/speech_recognition_cubit.dart';

class DetectedCommandWidget extends StatelessWidget {
  const DetectedCommandWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeechRecognitionCubit, SpeechRecognitionState>(
      builder: (context,state) {
        SpeechRecognitionCubit speechRecognitionCubit = SpeechRecognitionCubit.get(context);
        return Center(
            child: CircleAvatar(
              radius: 50,
              child: Text(speechRecognitionCubit.detectedCommand),
            ));
      }
    );
  }
}
