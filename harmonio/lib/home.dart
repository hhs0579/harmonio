import 'package:flutter/material.dart';
import 'package:harmonio/color.dart';
import 'package:harmonio/playlist.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  Text(
                    'Harmonio',
                    style: TextStyle(
                        fontFamily: 'jal', color: ColorList.text, fontSize: 50),
                  ),
                  Text(
                    '직접 만들어 연주하는 하모니오 오르골',
                    style: TextStyle(color: ColorList.text),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: width * 0.8,
                  height: 60,
                  decoration: BoxDecoration(
                      color: ColorList.text,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Icon(
                          Icons.music_note,
                          size: 35,
                          color: ColorList.icons,
                        ),
                      ),
                      Text(
                        '노래제작',
                        style: TextStyle(
                            fontFamily: 'jal',
                            color: ColorList.primary,
                            fontSize: 24),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => playList()));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: width * 0.8,
                    height: 60,
                    decoration: BoxDecoration(
                        color: ColorList.text,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Icon(
                            Icons.album,
                            size: 35,
                            color: ColorList.icons,
                          ),
                        ),
                        Text(
                          '노래 불러오기',
                          style: TextStyle(
                              fontFamily: 'jal',
                              color: ColorList.primary,
                              fontSize: 24),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: width * 0.8,
                  height: 60,
                  decoration: BoxDecoration(
                      color: ColorList.text,
                      borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Icon(
                          Icons.settings,
                          size: 35,
                          color: ColorList.icons,
                        ),
                      ),
                      Text(
                        '세팅',
                        style: TextStyle(
                            fontFamily: 'jal',
                            color: ColorList.primary,
                            fontSize: 24),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
