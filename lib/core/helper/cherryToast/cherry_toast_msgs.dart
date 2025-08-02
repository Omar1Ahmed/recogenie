import 'package:flutter/material.dart';

import '../../Responsive/models/device_info.dart';

class CherryToastMsgs {
  static void showErrorToast(
    BuildContext context,
    String title,
    String description,
    DeviceInfo deviceInfo,
  ) {
    CherryToastMsgs._showAnimatedToast(
      context: context,
      title: title,
      description: description,
      deviceinfo: deviceInfo,
      icon: Icons.error_outline,
      iconColor: Colors.white,
      iconBackground: const Color(0xFFdd5b5e),
      backgroundColor: const Color(0xFFfcefea),
      borderColor: Colors.red,
      titleStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      descriptionStyle: const TextStyle(color: Colors.black54, fontSize: 14),
    );
  }

  static void showInfoToast(
    BuildContext context,
    String title,
    String description,
    DeviceInfo deviceinfo,
  ) {
    CherryToastMsgs._showAnimatedToast(
      context: context,
      title: title,
      description: description,
      deviceinfo: deviceinfo,
      icon: Icons.info_rounded,
      iconColor: Colors.white,
      iconBackground: Color(0xFF3188ea),
      backgroundColor: Color(0xFFe7eefa),
      borderColor: Color(0xFF528dc4),
      titleStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      descriptionStyle: const TextStyle(color: Colors.black54, fontSize: 14),
    );
  }

  static void showWarningToast(
    BuildContext context,
    String title,
    String description,
    DeviceInfo deviceinfo,
  ) {
    CherryToastMsgs._showAnimatedToast(
      context: context,
      title: title,
      description: description,
      deviceinfo: deviceinfo,
      icon: Icons.warning_amber_rounded,
      iconColor: Colors.white,
      iconBackground: Color(0xFFffc120),
      backgroundColor: Color(0xfffef7ea),
      borderColor: Color(0xFFfaca52),
      titleStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      descriptionStyle: const TextStyle(color: Colors.black54, fontSize: 14),
    );
  }

  static void showSuccessToast({
    required BuildContext context,
    required String title,
    required String description,
    required DeviceInfo deviceinfo,
  }) {
    CherryToastMsgs._showAnimatedToast(
      context: context,
      title: title,
      description: description,
      deviceinfo: deviceinfo,
      icon: Icons.check,
      iconColor: Colors.white,
      iconBackground: Color(0xFF51dc6b),
      backgroundColor: Color(0xFFf1f9f4),
      borderColor: Color(0xFF72c382),
      titleStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      descriptionStyle: const TextStyle(color: Colors.black54, fontSize: 14),
    );
  }

  static void _showAnimatedToast({
    required BuildContext context,
    required String title,
    required String description,
    required DeviceInfo deviceinfo,
    required IconData icon,
    required Color iconColor,
    required Color iconBackground,
    required Color backgroundColor,
    required Color borderColor,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    double borderRadius = 24,
    double borderWidth = 2,
    Duration duration = const Duration(seconds: 3),
    double elevation = 18,
    Color shadowColor = Colors.black26,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => _AnimatedToastOverlay(
        title: title,
        description: description,
        deviceinfo: deviceinfo,
        onClose: () => overlayEntry.remove(),
        icon: icon,
        iconColor: iconColor,
        iconBackground: iconBackground,
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        borderRadius: borderRadius,
        borderWidth: borderWidth,
        duration: duration,
        elevation: elevation,
        shadowColor: shadowColor,
        titleStyle: titleStyle,
        descriptionStyle: descriptionStyle,
      ),
    );
    overlay.insert(overlayEntry);
  }
}

class _AnimatedToastOverlay extends StatefulWidget {
  final String title;
  final String description;
  final DeviceInfo deviceinfo;
  final VoidCallback onClose;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final Duration duration;
  final double elevation;
  final Color shadowColor;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  const _AnimatedToastOverlay({
    required this.title,
    required this.description,
    required this.deviceinfo,
    required this.onClose,
    this.icon = Icons.error_outline,
    this.iconColor = Colors.red,
    this.iconBackground = const Color(0xFFFFEBEE),
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.red,
    this.borderRadius = 24,
    this.borderWidth = 2,
    this.duration = const Duration(seconds: 3),
    this.elevation = 18,
    this.shadowColor = Colors.black26,
    this.titleStyle,
    this.descriptionStyle,
  });

  @override
  State<_AnimatedToastOverlay> createState() => _AnimatedToastOverlayState();
}

class _AnimatedToastOverlayState extends State<_AnimatedToastOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    Future.delayed(widget.duration).then((_) {
      if (mounted) {
        _controller.reverse().then((_) {
          if (mounted) widget.onClose();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.deviceinfo.screenWidth * 0.85;
    return Positioned(
      top: widget.deviceinfo.screenWidth * 0.18,
      left: (widget.deviceinfo.screenWidth - width) / 2,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: width,
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(
                    color: widget.borderColor,
                    width: widget.borderWidth,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.shadowColor,
                      blurRadius: widget.elevation,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: widget.iconBackground,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        widget.icon,
                        color: widget.iconColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.title,
                            style:
                                widget.titleStyle ??
                                const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.description,
                            style:
                                widget.descriptionStyle ??
                                const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _controller.reverse().then((_) {
                          if (mounted) widget.onClose();
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: widget.deviceinfo.screenWidth * 0.02,
                          top: widget.deviceinfo.screenWidth * 0.02,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.grey.shade700,
                          size: widget.deviceinfo.screenWidth * 0.06,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
