import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'media_list_screen.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  _MainActivityState createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  File? _selectedMediaFile;
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (_selectedMediaFile != null) {
      _controller = VideoPlayerController.file(_selectedMediaFile!)
        ..initialize().then((_) {
          _controller!.play();
          setState(() {});
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Player'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_controller != null && _controller!.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
            if (_selectedMediaFile != null)
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Now playing: ${_selectedMediaFile!.path.split('/').last}',
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
            if (_controller != null && _controller!.value.isInitialized)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous),
                      onPressed: () {
                        // TODO: Implement skipping to previous media file.
                      },
                    ),
                    IconButton(
                      icon: Icon(_controller!.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow),
                      onPressed: () {
                        setState(() {
                          _controller!.value.isPlaying
                              ? _controller!.pause()
                              : _controller!.play();
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next),
                      onPressed: () {
                        // TODO: Implement skipping to next media file.
                      },
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Choose Media'),
              onPressed: () async {
                final selectedMediaFile = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MediaListScreen(),
                  ),
                );
                if (selectedMediaFile != null) {
                  setState(() {
                    _selectedMediaFile = selectedMediaFile;
                    _controller =
                        VideoPlayerController.file(_selectedMediaFile!)
                          ..initialize().then((_) {
                            _controller!.play();
                            setState(() {});
                          });
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}
