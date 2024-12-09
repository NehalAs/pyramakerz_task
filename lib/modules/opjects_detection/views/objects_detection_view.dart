import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pyramakerz_task_f/modules/opjects_detection/cubit/objects_detection_cubit.dart';
import 'package:pyramakerz_task_f/modules/opjects_detection/cubit/objects_detection_state.dart';


class ObjectsDetectionView extends StatelessWidget {
  const ObjectsDetectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ObjectsDetectionCubit(),
      child: BlocBuilder<ObjectsDetectionCubit, ObjectsDetectionState>(
        builder: (context, state) {
          ObjectsDetectionCubit objectsDetectionCubit=ObjectsDetectionCubit.get(context);
          return Scaffold(
            appBar: AppBar(title: const Text('Object Detection')),
            body: Stack(
              children: [
                objectsDetectionCubit.imageCamera != null
                    ? CameraPreview(objectsDetectionCubit.cameraController)
                    : const Center(child: CircularProgressIndicator()),
                if (objectsDetectionCubit.result!='') ...[
                  for (var recognition in objectsDetectionCubit.recognitionsResults)
                    Center(
                      child: Container(
                        width: 0.6 * MediaQuery.of(context).size.width,
                        height: 0.4 * MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        child: Text(
                          "${recognition['label']} ${(recognition['confidence'] as double).toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Colors.red,
                            backgroundColor: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                ],
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(objectsDetectionCubit.result))
              ],
            ),
          );
        },
      ),
    );
  }
}
