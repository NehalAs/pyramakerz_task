
import 'package:flutter_bloc/flutter_bloc.dart';
import 'objects_detection_state.dart';

class ObjectsDetectionCubit extends Cubit<ObjectsDetectionState> {
  ObjectsDetectionCubit() : super(ObjectsDetectionInitial());
}
