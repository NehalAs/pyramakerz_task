sealed class SpeechRecognitionState {}

final class SpeechRecognitionInitial extends SpeechRecognitionState {}

final class InitSpeechState extends SpeechRecognitionState {}

final class RecognizeWordsState extends SpeechRecognitionState {}

final class StartListeningState extends SpeechRecognitionState {}

final class StopListeningState extends SpeechRecognitionState {}

final class DetectCommandState extends SpeechRecognitionState {}

final class ListenMessageState extends SpeechRecognitionState {}

final class PublishMessageState extends SpeechRecognitionState {}

final class ConnectToBrokerState extends SpeechRecognitionState {}
