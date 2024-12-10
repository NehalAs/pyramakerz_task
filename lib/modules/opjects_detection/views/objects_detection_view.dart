import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyramakerz_task_f/modules/opjects_detection/cubit/objects_detection_cubit.dart';
import 'package:pyramakerz_task_f/modules/opjects_detection/cubit/objects_detection_state.dart';
import 'package:pyramakerz_task_f/modules/opjects_detection/views/widgets/detected_object_frame.dart';


class ObjectsDetectionView extends StatelessWidget {
  const ObjectsDetectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ObjectsDetectionCubit(),
      child: BlocBuilder<ObjectsDetectionCubit, ObjectsDetectionState>(
        builder: (context, state) {
          ObjectsDetectionCubit objectsDetectionSCubit=ObjectsDetectionCubit.get(context);
          return Scaffold(
            body: Stack(
              children: [
                //check if camera not initialized make loading indicator
                objectsDetectionSCubit.imageCamera != null
                    ? SizedBox.expand(child: CameraPreview(objectsDetectionSCubit.cameraController))
                    : const Center(child: CircularProgressIndicator()),
                if (objectsDetectionSCubit.recognitionsResults !=null) ...[
                  // to build frame on every detected object
                  for (var recognition in objectsDetectionSCubit.recognitionsResults!)
                    DetectedObjectFrame(recognition:recognition),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
