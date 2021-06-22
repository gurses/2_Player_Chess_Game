import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2 Player Chess',
      theme: new ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentAd = FacebookBannerAd(
        placementId: "675759903094349_675760276427645",
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("Banner Ad: $result -->  $value");
        },
      );
    });
    FacebookAudienceNetwork.init(
        testingId: "37b1da9d-b48c-4103-a393-2e095e734bd6");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("2 Player Chess"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ChessBoard(
              onMove: (move) {
                print(move);
              },
              onCheckMate: (color) {
                print(color);
              },
              onDraw: () {},
              size: MediaQuery.of(context).size.width,
              enableUserMoves: true,
              boardType: BoardType.brown,
            ),
            Flexible(
              child: Align(
                alignment: Alignment(0, 1),
                child: _currentAd,
              ),
              fit: FlexFit.tight,
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
