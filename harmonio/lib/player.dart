import 'package:flutter/material.dart';
import 'package:harmonio/song.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerScreen extends StatefulWidget {
  final List<Song> playlist;
  final int initialIndex;

  const MusicPlayerScreen(
      {super.key, required this.playlist, this.initialIndex = 0});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayer audioPlayer;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    audioPlayer = AudioPlayer();
    _loadSong(widget.playlist[currentIndex].audioUrl);
  }

  _loadSong(String url) async {
    await audioPlayer.setUrl(url);
  }

  _playNext() {
    if (currentIndex + 1 < widget.playlist.length) {
      currentIndex++;
      _loadSong(widget.playlist[currentIndex].audioUrl);
      audioPlayer.play();
    }
  }

  _playPrevious() {
    if (currentIndex - 1 >= 0) {
      currentIndex--;
      _loadSong(widget.playlist[currentIndex].audioUrl);
      audioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playlist[currentIndex].title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.playlist[currentIndex].artist),
            IconButton(
              icon: const Icon(Icons.skip_previous),
              onPressed: _playPrevious,
            ),
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {
                audioPlayer.play();
              },
            ),
            IconButton(
              icon: const Icon(Icons.pause),
              onPressed: () {
                audioPlayer.pause();
              },
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: _playNext,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
