import 'package:flutter/material.dart';
import 'package:pyramakerz_task_f/modules/opjects_detection/models/real_time_recognition_model.dart';

class DetectedObjectFrame extends StatelessWidget {
  const DetectedObjectFrame({super.key, required this.recognition});
  final RealTimeRecognitionModel recognition;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: recognition.rect!.x !* MediaQuery.of(context).size.width,
      top: recognition.rect!.y ! * MediaQuery.of(context).size.height,
      width: recognition.rect!.w ! * MediaQuery.of(context).size.width,
      height: recognition.rect!.h ! * MediaQuery.of(context).size.height,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.green,
            width: 3,
          ),
        ),
        child: Text(
          "${recognition.detectedClass} ${(recognition.confidenceInClass)!.toStringAsFixed(2)}",
          style: TextStyle(
            color: Colors.white,
            backgroundColor: Colors.black54,
          ),
        ),
      ),
    );
  }
}
