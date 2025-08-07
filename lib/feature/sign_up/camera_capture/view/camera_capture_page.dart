import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class CameraCapturePage extends StatefulWidget {
  final CameraDescription camera;

  const CameraCapturePage({super.key, required this.camera});

  // For named route builder
  static Widget builder(BuildContext context) {
    final camera = ModalRoute.of(context)!.settings.arguments as CameraDescription;
    return CameraCapturePage(camera: camera);
  }

  @override
  State<CameraCapturePage> createState() => _CameraCapturePageState();
}

class _CameraCapturePageState extends State<CameraCapturePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isTakingPicture = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<String> _takePicture() async {
    final Directory extDir = await getTemporaryDirectory();
    final String dirPath = '${extDir.path}/Pictures/ekyc';
    await Directory(dirPath).create(recursive: true);

    final String filePath = path.join(
      dirPath,
      '${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    if (!_controller.value.isInitialized) {
      throw Exception('Camera is not initialized');
    }

    if (_controller.value.isTakingPicture) {
      return '';
    }

    try {
      final XFile picture = await _controller.takePicture();
      await picture.saveTo(filePath);
      return filePath;
    } catch (e) {
      debugPrint('Error taking picture: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                SizedBox.expand(child: CameraPreview(_controller)),

                // Rectangle guideline
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                // Capture button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: FloatingActionButton(
                      heroTag: 'captureBtn',
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.camera_alt, color: Colors.black),
                      onPressed: () async {
                        if (_isTakingPicture) return;
                        setState(() => _isTakingPicture = true);

                        final filePath = await _takePicture();

                        setState(() => _isTakingPicture = false);

                        if (filePath.isNotEmpty && mounted) {
                          Navigator.pop(context, filePath);
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
