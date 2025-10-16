import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../constants/app_colors.dart';
import '../../../../extensions/theme_extension.dart';

class BarcodeScannerView extends StatelessWidget {
  const BarcodeScannerView({
    super.key,
    required this.scannerController,
    required this.isScanning,
    required this.statusWidget,
  });

  final MobileScannerController? scannerController;
  final bool isScanning;
  final Widget statusWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      width: 365,
      color: context.customThemeColor(
        light: AppColor.barCodeScannerBgColorLight,
        dark: AppColor.colorDarkProfileContainer,
      ),
      // Dark background for scanner area
      child: Center(
        child: ClipRRect(
          //borderRadius: BorderRadius.circular(12.0),
          child: AspectRatio(
            aspectRatio:
                16 / 9, // Adjust aspect ratio as needed for the scanner preview
            child: Stack(
              children: [
                // MobileScanner widget
                if (scannerController != null)
                  MobileScanner(
                    controller: scannerController,
                    onDetect: (capture) {
                      // Barcode detection is handled by the BLoC listening to the stream
                    },
                  )
                else
                  // Display status widget if controller is not available
                  statusWidget,

                // Scanning Overlay (if actively scanning)
                if (isScanning) const AnimatedCornersOverlay(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedCornersOverlay extends StatefulWidget {
  const AnimatedCornersOverlay({super.key});

  @override
  State<AnimatedCornersOverlay> createState() => _AnimatedCornersOverlayState();
}

class _AnimatedCornersOverlayState extends State<AnimatedCornersOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnim;
  late final Animation<double> _scanLineAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _opacityAnim = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scanLineAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.7;
    final height = width * (9 / 16);

    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final scanLineTop = height * _scanLineAnim.value;

          return CustomPaint(
            painter: AnimatedCornerPainter(
              cornerLength: 24,
              strokeWidth: 3,
              color: Colors.white,
              opacity: _opacityAnim.value,
            ),
            child: SizedBox(
              width: width,
              height: height,
              child: Stack(
                children: [
                  // Moving scan line
                  Positioned(
                    top: scanLineTop,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFF19B790),
                        /* gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Color(0xFF19B790),
                            Colors.transparent,
                          ],
                        ),*/
                      ),
                    ),
                  ),
                  // Optional: LinearProgressIndicator at bottom
                  /* Align(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent.withOpacity(0.7)),
                    ),
                  ),*/
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/*class AnimatedCornersOverlay extends StatefulWidget {
  const AnimatedCornersOverlay({super.key});

  @override
  State<AnimatedCornersOverlay> createState() => _AnimatedCornersOverlayState();
}

class _AnimatedCornersOverlayState extends State<AnimatedCornersOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _opacityAnim = Tween<double>(begin: 0.3, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.7;
    final height = width * (9 / 16);

    return Center(
      child: AnimatedBuilder(
        animation: _opacityAnim,
        builder: (context, _) {
          return CustomPaint(
            painter: AnimatedCornerPainter(
              cornerLength: 24,
              strokeWidth: 3,
              color: Colors.greenAccent,
              opacity: _opacityAnim.value,
            ),
            child: SizedBox(
              width: width,
              height: height,
             /* child: Align(
                alignment: Alignment.bottomCenter,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent.withOpacity(0.7)),
                ),
              ),*/
            ),
          );
        },
      ),
    );
  }
}*/

class AnimatedCornerPainter extends CustomPainter {
  AnimatedCornerPainter({
    required this.cornerLength,
    required this.strokeWidth,
    required this.color,
    required this.opacity,
  });

  final double cornerLength;
  final double strokeWidth;
  final Color color;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color.withOpacity(opacity)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    // Top Left
    canvas
      ..drawLine(Offset(0, 0), Offset(cornerLength, 0), paint)
      ..drawLine(Offset(0, 0), Offset(0, cornerLength), paint)
      // Top Right
      ..drawLine(
        Offset(size.width, 0),
        Offset(size.width - cornerLength, 0),
        paint,
      )
      ..drawLine(Offset(size.width, 0), Offset(size.width, cornerLength), paint)
      // Bottom Left
      ..drawLine(
        Offset(0, size.height),
        Offset(cornerLength, size.height),
        paint,
      )
      ..drawLine(
        Offset(0, size.height),
        Offset(0, size.height - cornerLength),
        paint,
      )
      // Bottom Right
      ..drawLine(
        Offset(size.width, size.height),
        Offset(size.width - cornerLength, size.height),
        paint,
      )
      ..drawLine(
        Offset(size.width, size.height),
        Offset(size.width, size.height - cornerLength),
        paint,
      );
  }

  @override
  bool shouldRepaint(covariant AnimatedCornerPainter oldDelegate) =>
      oldDelegate.opacity != opacity;
}
