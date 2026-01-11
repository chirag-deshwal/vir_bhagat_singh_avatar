# Gesture Controlled 3D Cube

This Flutter application uses the device camera to track hand gestures (wrists) and allows you to rotate a 3D cube by swiping your hand in the air.

## Features
- **3D Cube**: A rendered 3D cube using Flutter transforms.
- **Hand Gesture Recognition**: Uses Google ML Kit Pose Detection to track wrist movements.
- **Camera Integration**: Real-time camera feed processing.
- **Swipe Control**: 
  - Move hand UP to rotate Up.
  - Move hand DOWN to rotate Down.
  - Move hand LEFT/RIGHT to rotate Left/Right.

## Requirements
- **Platform**: Android (minSdk 21) or iOS.
  - **Note**: Windows Desktop is NOT supported for ML Kit Pose Detection. You must run this on an **Android Emulator** or a **Physical Device**.
- **Permissions**: Camera and Internet access.

## How to Run
1. Connect an Android device or start an Android Emulator (configure emulator to use Webcam).
2. Run the app:
   ```bash
   flutter run
   ```
3. Allow Camera permissions.
4. Position your hand in front of the camera.
5. Move your hand to rotate the cube!

## Troubleshooting
- **No detection**: Ensure lighting is good and your upper body/hand is visible. The model might download on first run (requires internet).
- **Camera rotation**: If the camera preview is rotated, the app attempts to handle it, but different layouts might affect it.
