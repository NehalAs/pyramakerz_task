import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyramakerz_task_f/modules/speech_recognition/cubit/speach_recognition_state.dart';
import 'package:pyramakerz_task_f/modules/speech_recognition/cubit/speech_recognition_cubit.dart';

class SpeechRecognitionView extends StatelessWidget {
  const SpeechRecognitionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpeechRecognitionCubit(),
      child: BlocBuilder<SpeechRecognitionCubit, SpeechRecognitionState>(
        builder: (context, state) {
          SpeechRecognitionCubit speechRecognitionCubit =
              SpeechRecognitionCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                      child: CircleAvatar(
                        radius: 50,
                        child: Text(speechRecognitionCubit.detectedCommand),
                  )),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    speechRecognitionCubit.speechToText.isListening
                        ? speechRecognitionCubit.recognizedWords
                        : speechRecognitionCubit.isSpeechEnabled
                            ? 'Tap the microphone to start listening...'
                            : 'Speech not available',
                  ),
                  const SizedBox(height: 25,),
                  const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text('Commands you can try it')),
                  const SizedBox(height: 25,),
                  Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                    itemBuilder: (context, index) =>
                        Text(speechRecognitionCubit.commandWords[index]),
                    itemCount: speechRecognitionCubit.commandWords.length,
                  )),
                  const Spacer(),
                  FloatingActionButton(
                    shape: const CircleBorder(),
                    onPressed: speechRecognitionCubit.speechToText.isListening
                        ? speechRecognitionCubit.stopListening
                        : speechRecognitionCubit.startListening,
                    child: Icon(
                        speechRecognitionCubit.speechToText.isNotListening
                            ? Icons.mic_off
                            : Icons.mic),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
