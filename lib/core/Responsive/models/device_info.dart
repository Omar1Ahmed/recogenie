import 'package:flutter/widgets.dart';

import '../enums/device_type.dart';

class DeviceInfo {
  final Orientation orientation;
  final DeviceType deviceType;
  final double screenWidth;
  final double screenHeight;
  final double localWidth;
  final double localHeight;
  DeviceInfo(
      {required this.screenHeight,
      required this.localWidth,
      required this.localHeight,
      required this.deviceType,
      required this.screenWidth,
      required this.orientation});
}
