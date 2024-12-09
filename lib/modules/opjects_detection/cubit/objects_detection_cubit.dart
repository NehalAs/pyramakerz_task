import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  String result = "";
  late CameraController cameraController;

  // Initialize the camera with proper resolution and handle exceptions
  Future<void> initializeCamera() async {
    try {
      cameraController = CameraController(cameras[0], ResolutionPreset.high);

      await cameraController.initialize().then((_) {
        cameraController.startImageStream((imageFromStream) {
          if (!isWorking) {
            isWorking = true;
            imageCamera = imageFromStream;
            print('Frame format: ${imageCamera?.format.group}');
            emit(ImageFromStreamState());
            detectObjects();
          }
        });
        emit(InitializeCameraState());
      });
    } catch (e) {
      print("Camera initialization failed: $e");
      emit(CameraErrorState(e.toString()));
    }
  }

  // Load the TFLite model and handle any potential errors
  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/labels.txt",
      );
      print("Model loaded successfully.");
    } catch (e) {
      print("Failed to load model: $e");
      emit(ModelLoadErrorState(e.toString()));
    }
  }

  // Detect objects in the current camera frame
  Future<void> detectObjects() async {
    if (imageCamera != null) {
      try {
        var recognitions = await Tflite.runModelOnFrame(
          bytesList: imageCamera!.planes.map((plane) => plane.bytes).toList(),
          imageHeight: imageCamera!.height,
          imageWidth: imageCamera!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          threshold: 0.5, // Adjust threshold for better accuracy
          numResults: 3, // Increase for more detailed results
          asynch: true,
        );

        result = '';
        recognitions?.forEach((element) {
          result +=
          "${element["label"]} ${(element["confidence"] as double).toStringAsFixed(2)}\n\n";
          print("Detection: $result");
        });

        isWorking = false;
        emit(DetectObjectsState());
      } catch (e) {
        print("Object detection error: $e");
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
