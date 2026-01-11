import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class PosePainter extends CustomPainter {
  final List<Pose> poses;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  PosePainter(this.poses, this.absoluteImageSize, this.rotation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.green;

    final landmarkPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 5.0
      ..color = Colors.red;

    for (final pose in poses) {
      pose.landmarks.forEach((_, landmark) {
        canvas.drawCircle(
          Offset(
            translateX(landmark.x, size, absoluteImageSize, rotation),
            translateY(landmark.y, size, absoluteImageSize, rotation),
          ),
          1,
          landmarkPaint,
        );
      });

      // Draw a line for right arm to visualize wrist movement
      // Shoulder -> Elbow -> Wrist
      final rightShoulder = pose.landmarks[PoseLandmarkType.rightShoulder];
      final rightElbow = pose.landmarks[PoseLandmarkType.rightElbow];
      final rightWrist = pose.landmarks[PoseLandmarkType.rightWrist];

      if (rightShoulder != null && rightElbow != null && rightWrist != null) {
        final sX = translateX(
          rightShoulder.x,
          size,
          absoluteImageSize,
          rotation,
        );
        final sY = translateY(
          rightShoulder.y,
          size,
          absoluteImageSize,
          rotation,
        );
        final eX = translateX(rightElbow.x, size, absoluteImageSize, rotation);
        final eY = translateY(rightElbow.y, size, absoluteImageSize, rotation);
        final wX = translateX(rightWrist.x, size, absoluteImageSize, rotation);
        final wY = translateY(rightWrist.y, size, absoluteImageSize, rotation);

        canvas.drawLine(Offset(sX, sY), Offset(eX, eY), paint);
        canvas.drawLine(Offset(eX, eY), Offset(wX, wY), paint);
      }
    }
  }

  // Simplified translator (assumes front camera mirroring usually needed but we keep it simple first)
  double translateX(
    double x,
    Size canvasSize,
    Size imageSize,
    InputImageRotation rotation,
  ) {
    // For front camera, we often need to mirror X, but let's stick to basic scaling first
    // Just scaling X to canvas width
    return x * canvasSize.width / imageSize.width;
  }

  double translateY(
    double y,
    Size canvasSize,
    Size imageSize,
    InputImageRotation rotation,
  ) {
    return y * canvasSize.height / imageSize.height;
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.poses != poses;
  }
}
