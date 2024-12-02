import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyramakerz_task_f/modules/opjects_detection/cubit/objects_detection_cubit.dart';
import 'package:pyramakerz_task_f/modules/opjects_detection/cubit/objects_detection_state.dart';
import 'package:tflite/tflite.dart';

import '../../../main.dart';

class ObjectsDetectionView extends StatelessWidget {
  const ObjectsDetectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ObjectsDetectionCubit(),
      child: BlocBuilder<ObjectsDetectionCubit, ObjectsDetectionState>(
        builder: (context, state) {
          ObjectsDetectionCubit objectsDetectionState=ObjectsDetectionCubit.get(context);
          return Scaffold(
            appBar: AppBar(title: const Text('Object Detection')),
            body: Stack(
              children: [
                objectsDetectionState.imageCamera != null
                    ? CameraPreview(objectsDetectionState.cameraController)
                    : const Center(child: CircularProgressIndicator()),
                Center(child: Text(objectsDetectionState.result),)
              ],
            ),
          );
        },
      ),
    );
  }
}
