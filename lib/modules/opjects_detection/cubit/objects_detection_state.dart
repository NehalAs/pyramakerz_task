
sealed class ObjectsDetectionState {}

final class ObjectsDetectionInitial extends ObjectsDetectionState {}

final class ImageFromStreamState extends ObjectsDetectionState {}

final class InitializeCameraState extends ObjectsDetectionState {}

final class DetectObjectsState extends ObjectsDetectionState {}
