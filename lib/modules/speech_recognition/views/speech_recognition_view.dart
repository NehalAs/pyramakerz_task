import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyramakerz_task_f/modules/opjects_detection/views/objects_detection_view.dart';
import 'package:pyramakerz_task_f/modules/speech_recognition/cubit/speach_recognition_state.dart';
import 'package:pyramakerz_task_f/modules/speech_recognition/cubit/speech_recognition_cubit.dart';
import 'package:pyramakerz_task_f/modules/speech_recognition/views/widgets/command_list_view_item.dart';
import 'package:pyramakerz_task_f/modules/speech_recognition/views/widgets/detected_command_widget.dart';
import 'package:pyramakerz_task_f/modules/speech_recognition/views/widgets/recognized_words_widget.dart';
import 'package:pyramakerz_task_f/services/mqtt_service.dart';

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
              child: SafeArea(
                child: Column(
                  children: [
                    DetectedCommandWidget(),
                    const SizedBox(
                      height: 50,
                    ),
                    RecognizedWordsWidget(),
                    const SizedBox(
                      height: 25,
                    ),
                    const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text('Commands you can try it')),
                    const SizedBox(
                      height: 25,
                    ),
                    const CommandListViewItem(),
                    SizedBox(height: 30,),
                    Text('Listening from broker',style: TextStyle(fontWeight: FontWeight.bold),),
                    CircleAvatar(radius: 60,child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(speechRecognitionCubit.listenedStringMessage,textAlign: TextAlign.center,),
                    ),),
                    const Spacer(),
                    Row(
                      children: [
                        FloatingActionButton(
                          shape: const CircleBorder(),
                          onPressed:
                              speechRecognitionCubit.speechToText.isListening
                                  ? speechRecognitionCubit.stopListening
                                  : speechRecognitionCubit.startListening,
                          child: Icon(
                              speechRecognitionCubit.speechToText.isNotListening
                                  ? Icons.mic_off
                                  : Icons.mic),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ObjectsDetectionView(),
                                ));

                          },
                          child: const Text('Objects Detection '),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
