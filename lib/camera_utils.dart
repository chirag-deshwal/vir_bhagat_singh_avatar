import 'dart:ui';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:flutter/foundation.dart';

InputImage? inputImageFromCameraImage(
  CameraImage image,
  CameraDescription camera,
  InputImageRotation rotation,
) {
  final format = InputImageFormatValue.fromRawValue(image.format.raw);
  if (format == null) return null;

  final plane = image.planes.first;

  // Compose the WriteBuffer to get the bytes
  // Since we might need all planes for YUV420 on Android/iOS
  // This is a simplified version often used in examples

  final bytes = Uint8List(
    image.planes.fold(0, (count, plane) => count + plane.bytes.length),
  );
  int offset = 0;
  for (var plane in image.planes) {
    bytes.setRange(offset, offset + plane.bytes.length, plane.bytes);
    offset += plane.bytes.length;
  }

  // On Android, the image is YUV420_888, which ML Kit handles.
  // On iOS, it's BGRA8888.

  return InputImage.fromBytes(
    bytes: bytes,
    metadata: InputImageMetadata(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation, // We need to calculate this
      format: format,
      bytesPerRow: plane.bytesPerRow,
    ),
  );
}

InputImageRotation rotationIntToImageRotation(int rotation) {
  switch (rotation) {
    case 90:
      return InputImageRotation.rotation90deg;
    case 180:
      return InputImageRotation.rotation180deg;
    case 270:
      return InputImageRotation.rotation270deg;
    default:
      return InputImageRotation.rotation0deg;
  }
}
