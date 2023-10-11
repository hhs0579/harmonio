import 'package:flutter/material.dart';
import 'package:harmonio/player.dart';
import 'package:harmonio/song.dart';
import 'color.dart';

class playList extends StatelessWidget {
  playList({super.key});
  List<Song> playlist = [
    Song(
      title: '인생의 회전목마',
      artist: '히사이시 조',
      albumArtUrl: 'assets/images/5.png',
      audioUrl:
          'http://www.usherin.co.kr/mp3/2022/Listening_Inter/TEST1/TEST1-set1-1-C.Accounting%20department(336p).mp3',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorList.primary,
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60, left: 20),
              alignment: Alignment.topLeft,
              child: Text(
                '노래 목록',
                style: TextStyle(
                    fontFamily: 'jal', color: ColorList.text, fontSize: 30),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: height * 0.85,
                      decoration: BoxDecoration(
                          color: ColorList.text,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 15,
                    right: 15,
                    top: 60,
                    child: Container(
                        height: height * 0.75,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: ColorList.primary, width: 3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ListView.builder(
                          itemCount: playlist.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${playlist.length}',
                                    style: TextStyle(
                                        fontFamily: 'jal',
                                        color: ColorList.primary,
                                        fontSize: 28),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Image.asset(playlist[index].albumArtUrl),
                                ],
                              ),
                              title: Text(
                                playlist[index].title,
                                style: TextStyle(
                                    fontFamily: 'jal',
                                    color: ColorList.primary,
                                    fontSize: 20),
                              ),
                              subtitle: Text(
                                playlist[index].artist,
                                style: TextStyle(
                                    fontFamily: 'jal',
                                    color: ColorList.primary,
                                    fontSize: 14),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MusicPlayerScreen(
                                          playlist: playlist)),
                                );
                              },
                            );
                          },
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
