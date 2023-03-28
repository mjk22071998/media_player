import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class MediaListScreen extends StatefulWidget {
  const MediaListScreen({Key? key}) : super(key: key);

  @override
  _MediaListScreenState createState() => _MediaListScreenState();
}

class _MediaListScreenState extends State<MediaListScreen> {
  late Future<List<FileSystemEntity>> _mediaFiles;

  @override
  void initState() {
    super.initState();
    _mediaFiles = _getMediaFiles();
  }

  Future<List<FileSystemEntity>> _getMediaFiles() async {
    final Directory? appDirectory = await getExternalStorageDirectory();
    final List<FileSystemEntity> files = appDirectory!.listSync(
      recursive: true,
      followLinks: false,
    );

    final List<FileSystemEntity> mediaFiles = [];

    for (final file in files) {
      if (file is File && _isMediaFile(file)) {
        mediaFiles.add(file);
      }
    }

    return mediaFiles;
  }

  bool _isMediaFile(File file) {
    final String path = file.path;
    return path.endsWith('.mp4') ||
        path.endsWith('.mkv') ||
        path.endsWith('.webm') ||
        path.endsWith('.mp3') ||
        path.endsWith('.wav') ||
        path.endsWith('.ogg') ||
        path.endsWith('.flac');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Media'),
      ),
      body: FutureBuilder<List<FileSystemEntity>>(
        future: _mediaFiles,
        builder: (BuildContext context,
            AsyncSnapshot<List<FileSystemEntity>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No media files found.'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final file = snapshot.data![index];
                return ListTile(
                  leading: Icon(_isMediaFile(file as File)
                      ? Icons.movie
                      : Icons.music_note),
                  title: Text(file.path.split('/').last),
                  onTap: () {
                    Navigator.pop(context, file);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
