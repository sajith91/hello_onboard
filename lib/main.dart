import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hello_onboard/listitem.dart';
import 'package:hello_onboard/provider/OnboardTheme.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SvgProvider;
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: OnBoardTheme.lightTheme,
      darkTheme: OnBoardTheme.darkTheme,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late int currentIndexPage;
  late int pageLength;
  late int currentPageValue;

  late PageController _pageController;

  late int _previousPage;

  bool _visible = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, keepPage: true)
      ..addListener(_onScroll);
    _previousPage = _pageController.initialPage;

    currentIndexPage = 0;
    currentPageValue = currentIndexPage + 1;

    pageLength = 3;
    super.initState();
  }

  void _onScroll() {
    setState(() {
      _visible = false;
    });

    int now = _pageController.page!.toInt();

    if (_previousPage > _pageController.page!) {
      if (_pageController.page! - now < 0.5) {
        setState(() {
          _visible = true;
        });
      } else {
        _visible = false;
      }
    } else {
      if (_pageController.page! - now > 0.5) {
        setState(() {
          _visible = true;
        });
      } else {
        _visible = false;
      }
    }

    if (_pageController.page?.toInt() == _pageController.page) {
      _previousPage = _pageController.page!.toInt();
      setState(() {
        _visible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: PageView.builder(
                controller: _pageController,
                itemCount: listItems.length,
                onPageChanged: (value) {
                  setState(() => {
                        currentIndexPage = value,
                        currentPageValue = currentIndexPage + 1
                      });
                },
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 24, bottom: 0),
                          child: Container(
                            child: SvgPicture.asset(
                              listItems[index].image,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: (MediaQuery.of(context).size.height) * 0.6,
                          ),
                        ),
                        Container(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                              child: AnimatedOpacity(
                                opacity: _visible ? 1.00 : 0.00,
                                duration: const Duration(milliseconds: 800),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 0, bottom: 12, top: 12),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: HexColor("#07ADFF"),
                                              ),
                                              color: HexColor("#07ADFF"),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12))),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 4,
                                                bottom: 4,
                                                left: 16,
                                                right: 16),
                                            child: Text(
                                              "$currentPageValue of $pageLength",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: HexColor("#FFFFFF")),
                                            ),
                                          )),
                                    ),
                                    Text(listItems[index].title,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(listItems[index].description,
                                        //style: walkthroughPageDetailTextStyle,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                  );
                })),
        _dots_Indicator(context),
        Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 8),
              child: TextButton(
                child: Text(
                  "Sign In",
                  style: TextStyle(fontSize: 18, color: HexColor("#FFFFFF")),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF07ADFF)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(16)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(35),
                                bottomRight: Radius.circular(35),
                                topLeft: Radius.circular(35),
                                bottomLeft: Radius.circular(35))))),
                onPressed: () {},
              ),
            ))
      ]),
    );
  }

  Widget _dots_Indicator(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 4),
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: currentIndexPage == 0 ? HexColor("#07ADFF") : null,
                  border: Border.all(color: HexColor("#07ADFF")),
                  shape: BoxShape.circle),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(right: 4),
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: currentIndexPage == 1 ? HexColor("#07ADFF") : null,
                    border: Border.all(color: HexColor("#07ADFF")),
                    shape: BoxShape.circle),
              )),
          Padding(
            padding: EdgeInsets.only(right: 4),
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: currentIndexPage == 2 ? HexColor("#07ADFF") : null,
                  border: Border.all(color: HexColor("#07ADFF")),
                  shape: BoxShape.circle),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return false;
  }
}
