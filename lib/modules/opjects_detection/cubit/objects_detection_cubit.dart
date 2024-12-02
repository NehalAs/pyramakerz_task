
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tflite/tflite.dart';
import '../../../main.dart';
import 'objects_detection_state.dart';

class ObjectsDetectionCubit extends Cubit<ObjectsDetectionState> {
  ObjectsDetectionCubit() : super(ObjectsDetectionInitial()){
    initializeCamera();
    loadModel();
  }

  static ObjectsDetectionCubit get(context) => BlocProvider.of(context);
  CameraImage? imageCamera;
  bool isWorking=false;
  String result="";
  late CameraController cameraController;


  Future<void> initializeCamera() async {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await cameraController.initialize().then((value) {
      cameraController.startImageStream((imageFromStream){
        if(!isWorking)
        {
          isWorking =true;
          imageCamera=imageFromStream;
          emit(ImageFromStreamState());
          detectObjects();

        }
      });
    },);

    emit(InitializeCameraState());
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: "assets/mobilenet_v1_1.0_224.tflite",
      labels: "assets/mobilenet_v1_1.0_224.txt",
    );
  }

  Future<void> detectObjects() async {

    if(imageCamera != null)
    {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: imageCamera!.planes.map((plane) => plane.bytes).toList(),
        imageHeight: imageCamera!.height,
        imageWidth: imageCamera!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );
      result='';
      recognitions?.forEach((element) {
        result+=element["label"]+" "+ (element["confidence"] as double).toStringAsFixed(2) + "\n\n";
        print('resulttttttttttttttttttttt$result');
      },);

      isWorking=false;

      emit(DetectObjectsState());
    }
  }
}
