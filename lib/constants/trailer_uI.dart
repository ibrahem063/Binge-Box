import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerWatch extends StatefulWidget {
  final String trailerytid;

  // Use a named parameter for better readability
  const TrailerWatch({super.key, required this.trailerytid});

  @override
  State<TrailerWatch> createState() => _TrailerWatchState();
}

class _TrailerWatchState extends State<TrailerWatch> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Convert YouTube URL or ID into a video ID
    final videoId = YoutubePlayer.convertUrlToId(widget.trailerytid);

    // If the videoId is valid (non-null), initialize the controller
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          enableCaption: true,
          autoPlay: false,
          mute: false,
          forceHD: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // If videoId is null, show a message to the user
    if (YoutubePlayer.convertUrlToId(widget.trailerytid) == null) {
      return const Center(
        child: Text('Invalid YouTube video ID'),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: YoutubePlayer(
        thumbnail: Image.network(
          "https://img.youtube.com/vi/${widget.trailerytid}/hqdefault.jpg",
          fit: BoxFit.cover,
        ),
        controller: _controller,
        aspectRatio: 16 / 9,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        bufferIndicator: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          ),
        ),
        bottomActions: const [
          CurrentPosition(),
          ProgressBar(
            isExpanded: true,
            colors: ProgressBarColors(
              playedColor: Colors.red,
              handleColor: Colors.red,
            ),
          ),
          RemainingDuration(),
          FullScreenButton(),
        ],
      ),
    );
  }
}
