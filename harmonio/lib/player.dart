import 'package:flutter/material.dart';
import 'package:harmonio/color.dart';
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

class _MusicPlayerScreenState extends State<MusicPlayerScreen>
    with WidgetsBindingObserver {
  late AudioPlayer audioPlayer;
  int currentIndex = 0;
  bool isPlaying = false;

  double currentSliderValue = 0.0;
  double maxSliderValue = 1.0;

  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    currentIndex = widget.initialIndex;
    audioPlayer = AudioPlayer();

    audioPlayer.positionStream.listen((duration) {
      if (mounted) {
        // 여기에 mounted 확인 추가
        setState(() {
          currentSliderValue = duration.inSeconds.toDouble();
        });
      }
    });

    audioPlayer.durationStream.listen((duration) {
      if (mounted) {
        // 여기에 mounted 확인 추가
        setState(() {
          maxSliderValue = duration?.inSeconds.toDouble() ?? 1.0;
        });
      }
    });

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

  _togglePlayPause() {
    if (isPlaying) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        audioPlayer.pause();
        break;
      case AppLifecycleState.resumed:
        // 필요하면 audioPlayer.play()를 여기서 호출하여 재생을 계속할 수 있습니다.
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorList.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: ColorList.text, width: 6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(24), // 값을 24로 변경하였습니다.
                          // 필요에 따라 이 값을 조절하여 둥글게 만들 수 있습니다.
                          child: Image.asset(
                            widget.playlist[currentIndex].albumArtUrl,
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.playlist[currentIndex].title,
                      style: TextStyle(
                          fontFamily: 'jal',
                          color: ColorList.text,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.playlist[currentIndex].artist,
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'jal',
                        color: ColorList.text,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Slider(
                      activeColor: ColorList.text,
                      inactiveColor: ColorList.text,
                      value: currentSliderValue,
                      min: 0.0,
                      max: maxSliderValue,
                      onChanged: (value) {
                        audioPlayer.seek(Duration(seconds: value.toInt()));
                        setState(() {
                          currentSliderValue = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(
                              Duration(seconds: currentSliderValue.toInt())),
                          style: TextStyle(color: ColorList.text),
                        ),
                        Text(
                            _formatDuration(
                                Duration(seconds: maxSliderValue.toInt())),
                            style: TextStyle(color: ColorList.text)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: _playPrevious,
                            child: Image.asset('assets/images/1.png')),
                        InkWell(
                          onTap: _togglePlayPause,
                          child: isPlaying
                              ? Image.asset('assets/images/3.png')
                              : Image.asset('assets/images/4.png'),
                        ),
                        InkWell(
                            onTap: _playNext,
                            child: Image.asset('assets/images/2.png'))
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: const [],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: width * 0.42,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorList.text,
                      ),
                      child: Text(
                        '재생목록',
                        style: TextStyle(
                            fontFamily: 'jal',
                            color: ColorList.primary,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: width * 0.42,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorList.text,
                      ),
                      child: Text(
                        '차트',
                        style: TextStyle(
                            fontFamily: 'jal',
                            color: ColorList.primary,
                            fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
