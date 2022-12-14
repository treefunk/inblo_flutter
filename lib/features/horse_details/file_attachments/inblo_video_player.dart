import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inblo_app/constants/app_constants.dart';
import 'package:inblo_app/models/attached_file.dart';
import 'package:video_player/video_player.dart';

class InbloVideoPlayer extends StatefulWidget {
  InbloVideoPlayer({
    super.key,
    required this.dirString,
    required this.attachedFile,
  });

  String dirString;
  AttachedFile attachedFile;

  @override
  State<InbloVideoPlayer> createState() => _InbloVideoPlayerState();
}

class _InbloVideoPlayerState extends State<InbloVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  String _getVideoUrl(String dirString) {
    return AppConstants.apiUrl + dirString + widget.attachedFile.filePath!;
  }

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    bool isRemote = widget.attachedFile.id != null;
    if (isRemote) {
      _controller =
          VideoPlayerController.network(_getVideoUrl(widget.dirString));
    } else {
      print("Detected file..");
      print(widget.attachedFile.toJson());
      _controller =
          VideoPlayerController.file(File(widget.attachedFile.filePath!));
    }

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller),
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        ElevatedButton(
          onPressed: () {
            // Wrap the play or pause in a call to `setState`. This ensures the
            // correct icon is shown.
            setState(() {
              // If the video is playing, pause it.
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                // If the video is paused, play it.
                _controller.play();
              }
            });
          },
          // Display the correct icon depending on the state of the player.
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        )
      ],
    );
  }
}
