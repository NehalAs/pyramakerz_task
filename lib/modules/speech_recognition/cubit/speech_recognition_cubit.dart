import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyramakerz_task_f/modules/speech_recognition/cubit/speach_recognition_state.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechRecognitionCubit extends Cubit<SpeechRecognitionState> {
  SpeechRecognitionCubit() : super(SpeechRecognitionInitial()){
    initSpeech();
  }

  static SpeechRecognitionCubit get(context) => BlocProvider.of(context);

  final SpeechToText speechToText = SpeechToText();
  bool isSpeechEnabled = false;
  String recognizedWords = '';
  List<String> commandWords=['Forward','Backward','Left','Right','Up','Down','Stop'];



  void initSpeech() async {
    isSpeechEnabled = await speechToText.initialize();
    emit(InitSpeechState());
  }

  void startListening() async {
    await speechToText.listen(onResult: (result) {
      recognizedWords = result.recognizedWords;
      recognizeKnownCommands();
      emit(RecognizeWordsState());
    },);

    emit(StartListeningState());
  }


  void stopListening() async {
    await speechToText.stop();
    emit(StopListeningState());
  }

  String detectedCommand ='';

  void recognizeKnownCommands()
  {
    commandWords.forEach((element) {
      if(recognizedWords.contains(element.toLowerCase())){
        detectedCommand = element;
        emit(DetectCommandState());
      }
    },);
  }


}
