import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ARPreviewScreen extends StatefulWidget {
  final Map<String, String> customizations;

  const ARPreviewScreen({Key? key, required this.customizations}) : super(key: key);

  @override
  _ARPreviewScreenState createState() => _ARPreviewScreenState();
}

class _ARPreviewScreenState extends State<ARPreviewScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _controller = CameraController(
        cameras.first,
        ResolutionPreset.high,
      );

      _initializeControllerFuture = _controller!.initialize();
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Preview', style: TextStyle(color: Colors.orange)),
      ),
      body: _initializeControllerFuture == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                if (_controller != null) CameraPreview(_controller!),
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/mechanic_quotes', arguments: widget.customizations);
                    },
                    child: const Text('Place Order'),
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