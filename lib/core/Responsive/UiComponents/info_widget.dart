import 'package:flutter/cupertino.dart';

import '../Functions/get_device_info.dart';
import '../models/device_info.dart';

class InfoWidget extends StatelessWidget {
  final Widget Function (BuildContext context,DeviceInfo deviceinfo) builder;
  const InfoWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var mediaQueryData = MediaQuery.of(context);
      var deviceInfo = DeviceInfo(
        orientation: mediaQueryData.orientation,
        deviceType: getDeviceType(mediaQueryData),
        screenHeight: mediaQueryData.size.height,
        screenWidth: mediaQueryData.size.width,
        localHeight: constraints.maxHeight,
        localWidth: constraints.maxWidth,
      );
      return builder(context,deviceInfo);
    });
  }
}
