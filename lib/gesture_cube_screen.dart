import 'dart:math' as math;
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'camera_utils.dart';
import 'pose_painter.dart';

class GestureCubeScreen extends StatefulWidget {
  const GestureCubeScreen({super.key});

  @override
  State<GestureCubeScreen> createState() => _GestureCubeScreenState();
}

class _GestureCubeScreenState extends State<GestureCubeScreen> {
  CameraController? _controller;
  PoseDetector? _poseDetector;
  bool _isCameraInitialized = false;
  bool _isProcessing = false;
  List<Pose> _poses = [];

  // Cube Rotation State
  double _rotationX = 0;
  double _rotationY = 0;

  // Gesture State
  double? _prevWristY;
  double? _prevWristX;

  // Threshold for swipe detection (pixels)
  final double _swipeThreshold = 10.0; // Lowered for sensitivity

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _poseDetector = PoseDetector(
      options: PoseDetectorOptions(mode: PoseDetectionMode.stream),
    );
  }

  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      debugPrint("Camera permission denied");
      return;
    }

    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      debugPrint("No cameras found");
      return;
    }

    // Try to find front camera
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
      imageFormatGroup: defaultTargetPlatform == TargetPlatform.android
          ? ImageFormatGroup.yuv420
          : ImageFormatGroup.bgra8888,
    );

    try {
      await _controller!.initialize();
      if (!mounted) return;

      setState(() {
        _isCameraInitialized = true;
      });

      // ML Kit Pose Detection is NOT supported on Web.
      // We only start the stream if we are NOT on web.
      if (!kIsWeb) {
        await _controller!.startImageStream(_processImage);
      } else {
        debugPrint("Web detected: Skipping ML Kit image stream");
      }
    } catch (e) {
      debugPrint("Error initializing camera: $e");
    }
  }

  Future<void> _processImage(CameraImage image) async {
    if (_isProcessing || _poseDetector == null || !_isCameraInitialized) return;
    _isProcessing = true;

    final camera = _controller!.description;
    final rotation = rotationIntToImageRotation(camera.sensorOrientation);

    final inputImage = inputImageFromCameraImage(image, camera, rotation);
    if (inputImage == null) {
      _isProcessing = false;
      return;
    }

    try {
      final poses = await _poseDetector!.processImage(inputImage);

      if (mounted) {
        setState(() {
          _poses = poses;
        });
      }

      if (poses.isNotEmpty) {
        _handleGestures(poses.first);
      }
    } catch (e) {
      debugPrint('Error processing image: $e');
    } finally {
      if (mounted) {
        _isProcessing = false;
      }
    }
  }

  int _fingerCount = 0;

  void _handleGestures(Pose pose) {
    _countFingers(pose);

    final wrist = pose.landmarks[PoseLandmarkType.rightWrist];

    if (wrist != null) {
      final y = wrist.y;
      final x = wrist.x;

      if (_prevWristY != null) {
        final dy = y - _prevWristY!;
        if (dy.abs() > _swipeThreshold) {
          // Invert logic if needed depending on camera mirroring
          // dy positive means moving DOWN (Y increases downwards in screen coords)
          setState(() {
            _rotationX += dy * 0.01;
          });
        }
      }

      if (_prevWristX != null) {
        final dx = x - _prevWristX!;
        if (dx.abs() > _swipeThreshold) {
          // dx positive means moving RIGHT
          setState(() {
            _rotationY -= dx * 0.01;
          });
        }
      }

      _prevWristY = y;
      _prevWristX = x;
    }
  }

  void _countFingers(Pose pose) {
    int totalCount = 0;

    // Helper to check each hand
    int checkHand(
      PoseLandmarkType wristType,
      PoseLandmarkType elbowType,
      PoseLandmarkType indexType,
      PoseLandmarkType pinkyType,
      PoseLandmarkType thumbType,
    ) {
      final wrist = pose.landmarks[wristType];
      final elbow = pose.landmarks[elbowType];
      final index = pose.landmarks[indexType];
      final pinky = pose.landmarks[pinkyType];
      final thumb = pose.landmarks[thumbType];

      // If wrist or elbow missing, can't measure scale
      if (wrist == null || elbow == null) return 0;

      // Forearm length as reference scale
      final double forearmDist = _getDistance(wrist, elbow);
      // Safety check for very small inputs
      if (forearmDist < 10) return 0;

      int extendedPoints = 0;

      // Check Index
      if (index != null && _isExtended(index, wrist, elbow, forearmDist)) {
        extendedPoints++;
      }
      // Check Pinky
      if (pinky != null && _isExtended(pinky, wrist, elbow, forearmDist)) {
        extendedPoints++;
      }
      // Check Thumb
      if (thumb != null && _isExtended(thumb, wrist, elbow, forearmDist)) {
        extendedPoints++;
      }

      // Heuristic mapping: Pose Detection only tracks 3 finger tips.
      // 3 extended -> Likely Open Hand (5 fingers)
      // 2 extended -> Likely 2 or 3 fingers
      // 1 extended -> 1 finger
      // 0 extended -> Fist (0)
      if (extendedPoints == 3) return 5;
      if (extendedPoints == 2) return 2;
      return extendedPoints;
    }

    // Check Right Hand
    totalCount += checkHand(
      PoseLandmarkType.rightWrist,
      PoseLandmarkType.rightElbow,
      PoseLandmarkType.rightIndex,
      PoseLandmarkType.rightPinky,
      PoseLandmarkType.rightThumb,
    );

    // Check Left Hand
    totalCount += checkHand(
      PoseLandmarkType.leftWrist,
      PoseLandmarkType.leftElbow,
      PoseLandmarkType.leftIndex,
      PoseLandmarkType.leftPinky,
      PoseLandmarkType.leftThumb,
    );

    if (mounted) {
      setState(() {
        _fingerCount = totalCount;
      });
    }
  }

  bool _isExtended(
    PoseLandmark tip,
    PoseLandmark wrist,
    PoseLandmark elbow,
    double scale,
  ) {
    // Logic: A finger is open if the tip is far from the wrist.
    // If curled, the tip is close to the wrist (or knuckles).
    // Threshold: 50% of forearm length is a reasonable guess for "extended" vs "curled"
    // (Fingers are roughly 40-50% length of forearm).
    final dist = _getDistance(tip, wrist);
    return dist > (scale * 0.5);
  }

  double _getDistance(PoseLandmark a, PoseLandmark b) {
    return math.sqrt(math.pow(a.x - b.x, 2) + math.pow(a.y - b.y, 2));
  }

  @override
  void dispose() {
    _controller?.dispose();
    _poseDetector?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main Content: 3D Cube
          Center(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // Perspective
                ..rotateX(_rotationX)
                ..rotateY(_rotationY),
              child: const CubeWidget(),
            ),
          ),

          // Camera Preview & Visual Debugger
          if (_isCameraInitialized && _controller != null)
            Positioned(
              bottom: 20,
              right: 20,
              width: 150,
              height: 200,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black54,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // 1. Camera Feed
                      CameraPreview(_controller!),

                      // 2. Pose Visualizer Overlay
                      if (_poses.isNotEmpty)
                        CustomPaint(
                          painter: PosePainter(
                            _poses,
                            const Size(150, 200), // Canvas Size
                            InputImageRotation
                                .rotation0deg, // Simple pass, logic inside painter handles scaling
                          ),
                        ),

                      // 3. Status Text
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Poses: ${_poses.length}",
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Instructions
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text(
                  "Debug Mode: Active",
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  "Fingers Detected: $_fingerCount",
                  style: const TextStyle(
                    color: Colors.yellow,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (kIsWeb)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.red,
                    child: const Text(
                      "GESTURES NOT SUPPORTED ON WEB\nRun on Android/iOS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else
                  const Text(
                    "Wave your hand!\n(Ensure UPPER BODY is visible)",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CubeWidget extends StatelessWidget {
  const CubeWidget({super.key});

  final double size = 200.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Front
          _buildFace(
            Transform(
              transform: Matrix4.identity()..translate(0.0, 0.0, -size / 2),
              alignment: Alignment.center,
              child: Container(
                width: size,
                height: size,
                color: Colors.blue.withOpacity(0.8),
                alignment: Alignment.center,
                child: const Text(
                  "FRONT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Back
          _buildFace(
            Transform(
              transform: Matrix4.identity()..translate(0.0, 0.0, size / 2),
              alignment: Alignment.center,
              child: Container(
                width: size,
                height: size,
                color: Colors.red.withOpacity(0.8),
                alignment: Alignment.center,
                child: const Text(
                  "BACK",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Left
          _buildFace(
            Transform(
              transform: Matrix4.identity()
                ..translate(-size / 2, 0.0, 0.0)
                ..rotateY(math.pi / 2),
              alignment: Alignment.center,
              child: Container(
                width: size,
                height: size,
                color: Colors.green.withOpacity(0.8),
                alignment: Alignment.center,
                child: const Text(
                  "LEFT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Right
          _buildFace(
            Transform(
              transform: Matrix4.identity()
                ..translate(size / 2, 0.0, 0.0)
                ..rotateY(math.pi / 2),
              alignment: Alignment.center,
              child: Container(
                width: size,
                height: size,
                color: Colors.yellow.withOpacity(0.8),
                alignment: Alignment.center,
                child: const Text(
                  "RIGHT",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Top
          _buildFace(
            Transform(
              transform: Matrix4.identity()
                ..translate(0.0, -size / 2, 0.0)
                ..rotateX(math.pi / 2),
              alignment: Alignment.center,
              child: Container(
                width: size,
                height: size,
                color: Colors.orange.withOpacity(0.8),
                alignment: Alignment.center,
                child: const Text(
                  "TOP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Bottom
          _buildFace(
            Transform(
              transform: Matrix4.identity()
                ..translate(0.0, size / 2, 0.0)
                ..rotateX(math.pi / 2),
              alignment: Alignment.center,
              child: Container(
                width: size,
                height: size,
                color: Colors.purple.withOpacity(0.8),
                alignment: Alignment.center,
                child: const Text(
                  "BOTTOM",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFace(Widget child) {
    return child;
  }
}
