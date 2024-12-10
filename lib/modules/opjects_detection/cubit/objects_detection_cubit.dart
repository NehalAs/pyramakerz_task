import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyramakerz_task_f/models/real_time_recognition_model.dart';
import 'package:tflite/tflite.dart';
import '../../../main.dart';
import 'objects_detection_state.dart';

class ObjectsDetectionCubit extends Cubit<ObjectsDetectionState> {
  ObjectsDetectionCubit() : super(ObjectsDetectionInitial()) {
    initializeCamera();
    loadModel();
  }

  static ObjectsDetectionCubit get(context) => BlocProvider.of(context);

  CameraImage? imageCamera;
  bool isWorking = false;
  late CameraController cameraController;
  //this model changes according to trained model result format
  List<RealTimeRecognitionModel>? recognitionsResults;

  // Initialize the camera with proper resolution and handle exceptions
  Future<void> initializeCamera() async {
    try {
      cameraController = CameraController(cameras[0], ResolutionPreset.high);

      await cameraController.initialize().then((_) {
        cameraController.startImageStream((imageFromStream) {
          if (!isWorking) {
            isWorking = true;
            imageCamera = imageFromStream;
            emit(ImageFromStreamState());
            detectObjects();
          }
        });
        emit(InitializeCameraState());
      });
    } catch (e) {
      log("Camera initialization failed: $e");
      emit(CameraErrorState(e.toString()));
    }
  }

  // Load the TFLite model and handle any potential errors
  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/detect.tflite",
        labels: "assets/labelmap.txt",
      );
      log("Model loaded successfully.");
    } catch (e) {
      log("Failed to load model: $e");
      emit(ModelLoadErrorState(e.toString()));
    }
  }

  // Detect objects in the current camera frame
  Future<void> detectObjects() async {
    if (imageCamera != null) {
      try {
        List? recognitions = await Tflite.detectObjectOnFrame(
          bytesList: imageCamera!.planes.map((plane) => plane.bytes).toList(),
          model: "SSDMobileNet",
          imageHeight: imageCamera!.height,
          imageWidth: imageCamera!.width,
          threshold: 0.5,
          asynch: true,
        );
        recognitionsResults =
            recognitions?.map<RealTimeRecognitionModel>((recognition) {
          return RealTimeRecognitionModel.fromJson(recognition);
        }).toList();
        isWorking = false;
        emit(DetectObjectsState());
      } catch (e) {
        log("Object detection error: $e");
        isWorking = false;
        emit(DetectionErrorState(e.toString()));
      }
    }
  }

  // Dispose the camera and release resources
  void dispose() {
    cameraController.dispose();
    Tflite.close();
    super.close();
  }
}
