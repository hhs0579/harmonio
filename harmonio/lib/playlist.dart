import 'package:flutter/material.dart';
import 'package:harmonio/player.dart';
import 'package:harmonio/song.dart';

import 'color.dart';

class playList extends StatelessWidget {
  playList({super.key});
  List<Song> playlist = [
    Song(
        title: '하울의 움직이는 성',
        artist: '히사이시 조',
        albumArtUrl:
            'https://image.bugsm.co.kr/album/images/200/80035/8003552.jpg?version=20190223130953.0',
        audioUrl: 'http://www.usherin.co.kr/mp3/2022/Listening_Inter/TEST1/TEST1-set1-1-C.Accounting%20department(336p).mp3'),
    // ... 다른 노래들
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
                              leading:
                                  Image.network(playlist[index].albumArtUrl),
                              title: Text(playlist[index].title),
                              subtitle: Text(playlist[index].artist),
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
