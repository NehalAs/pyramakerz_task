sealed class ObjectsDetectionState {}

final class ObjectsDetectionInitial extends ObjectsDetectionState {}

final class ImageFromStreamState extends ObjectsDetectionState {}

final class InitializeCameraState extends ObjectsDetectionState {}

final class InitializeModelState extends ObjectsDetectionState {}

final class DetectObjectsState extends ObjectsDetectionState {}

final class PickImageState extends ObjectsDetectionState {}

final class DetectionErrorState extends ObjectsDetectionState {
  late String error;
  DetectionErrorState(this.error);
}

final class CameraErrorState extends ObjectsDetectionState {
  late String error;
  CameraErrorState(this.error);
}

final class ModelLoadErrorState extends ObjectsDetectionState {
  late String error;
  ModelLoadErrorState(this.error);
}
