import 'package:flutter/material.dart';

class AppDeviceBuilder extends StatelessWidget {
  final Widget Function(BuildContext, Devices, Size) builder;

  const AppDeviceBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Devices device = _getDeviceRatio(size);

    return builder(context, device, size);
  }

  Devices _getDeviceRatio(Size size) {
    if (size.width < 640) {
      return Devices.mobile;
    } else if (size.width >= 640 && size.width < 1007) {
      return Devices.tablet;
    } else {
      return Devices.desktop;
    }
  }
}

enum Devices {
  mobile,
  tablet,
  desktop,
}
