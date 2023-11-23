import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  final Map<String, String>? workoutDetails;

  const PlayerScreen({Key? key, this.workoutDetails}) : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.workoutDetails?['videoUrl'] ?? '',
    )..initialize().then((_) {
        _controller.setLooping(true); // Set the video to loop
        _controller.play(); // Start playing the video
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the video controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Player'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.workoutDetails?['title'] ?? 'No Title',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement functionality for starting the workout
                // For example, you might want to start or pause the video here
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              child: Text(_controller.value.isPlaying
                  ? 'Pause Workout'
                  : 'Start Workout'),
            ),
          ],
        ),
      ),
    );
  }
}
