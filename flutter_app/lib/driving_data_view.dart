import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/driving_data_process.dart';
import 'package:flutter_app/score_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors/sensors.dart';

import 'UI/app_theme.dart';

class DrivingDataView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DrivingDataViewState();
  }
}

class _DrivingDataViewState extends State<DrivingDataView>
    with SingleTickerProviderStateMixin {
  Position position;
  StreamSubscription<Position> _positionStreamSubscription;
  AccelerometerEvent event;
  StreamSubscription<AccelerometerEvent> _streamSubscriptions;

  AnimationController _controller;
  Animation<double> animation;
  int clickTime=0;
  bool drivingCondition = false;
  final _positions = <Position>[];
  final _accelerometerEvent = <AccelerometerEvent>[];

  DrivingDataProcess dataProcess = new DrivingDataProcess();

  List<Map<String,double>> _storeList = <Map<String,double>>[]; //list after first filter
  List<Map<String,double>> _finalList = <Map<String,double>>[]; //list after second filter

  StreamSubscription<AccelerometerEvent> get streamSubscriptions =>
      _streamSubscriptions;

  final positionStream = Geolocator.getPositionStream();

  @override
  Widget build(BuildContext context) {
    return new Transform(
      transform: new Matrix4.translationValues(0.0, 30 * (1.0 - 0.5), 0.0),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topRight: Radius.circular(8.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: AppTheme.grey.withOpacity(0.2),
                  offset: Offset(1.1, 1.1),
                  blurRadius: 10.0),
            ],
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 4),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  width: 2,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 2),
                                        child: Text(
                                          'Acc_X',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.1,
                                            color:
                                                AppTheme.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 28,
                                            height: 28,
                                            child: Image.asset(
                                                "assets/images/tab_3.png"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, bottom: 3),
                                            child: Text(
                                              _cardTextAccX(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: AppTheme.darkerText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  width: 2,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 2),
                                        child: Text(
                                          'Acc_Y',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.1,
                                            color:
                                                AppTheme.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 28,
                                            height: 28,
                                            child: Image.asset(
                                                "assets/images/tab_3.png"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, bottom: 3),
                                            child: Text(
                                              _cardTextAccY(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: AppTheme.darkerText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  width: 2,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 2),
                                        child: Text(
                                          'Acc_Z',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.1,
                                            color:
                                                AppTheme.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 28,
                                            height: 28,
                                            child: Image.asset(
                                                "assets/images/tab_3.png"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, bottom: 3),
                                            child: Text(
                                              _cardTextAccZ(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: AppTheme.darkerText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  width: 2,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 2),
                                        child: Text(
                                          'Longitude',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.1,
                                            color:
                                            AppTheme.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 28,
                                            height: 28,
                                            child: Image.asset(
                                                "assets/images/tab_3.png"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, bottom: 3),
                                            child: Text(
                                              _cardTextLong(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: AppTheme.darkerText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 48,
                                  width: 2,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, bottom: 2),
                                        child: Text(
                                          'Latitude',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: AppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            letterSpacing: -0.1,
                                            color:
                                            AppTheme.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 28,
                                            height: 28,
                                            child: Image.asset(
                                                "assets/images/tab_3.png"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, bottom: 3),
                                            child: Text(
                                              _cardTextLat(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: AppTheme.darkerText,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Center(
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: AppTheme.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(100.0),
                                          ),
                                          border: new Border.all(
                                              width: 4,
                                              color: AppTheme.nearlyDarkBlue
                                                  .withOpacity(0.2)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            // ignore: deprecated_member_use
                                            MaterialButton(
                                              child: _buttonText(),
                                              color: _buttonColor(),
                                              onPressed: _toggleListening,
                                              padding: EdgeInsets.all(20),
                                              shape: CircleBorder(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CustomPaint(
                                        child: SizedBox(
                                          width: 108,
                                          height: 108,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 8),
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 5000),
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval((1 / 9) * 1, 1.0, curve: Curves.fastOutSlowIn)));

    _controller.forward();
  }


  String _cardTextAccX() {
    if (event != null) {
      return 'Acc_X:   ${event.x.roundToDouble()}';
    } else {
      return 'Acc: wait';
    }
  }

  String _cardTextAccY() {
    if (event != null) {
      return 'Acc_Y:    ${event.y.roundToDouble()}';
    } else {
      return 'Acc: wait';
    }
  }

  String _cardTextAccZ() {
    if (event != null) {
      return 'Acc_Z:    ${event.z.roundToDouble()}';
    } else {
      return 'Acc: wait';
    }
  }

  String _cardTextLong() {
    if (event != null) {
      return 'Longitude:    ${position.longitude.roundToDouble()}';
    } else {
      return 'Longitude: wait';
    }
  }

  String _cardTextLat() {
    if (event != null) {
      return 'Latitude:    ${position.latitude.roundToDouble()}';
    } else {
      return 'Latitude: wait';
    }
  }

  void _toggleListeningGPS() {
    _positionStreamSubscription =
        positionStream.listen((position) => setState(() {
              _positions.add(position);
              this.position = position;
            }));
  }

  void _toggleListeningAcc() {
    double timeStamp;
    double lastTime = 0;

    _streamSubscriptions =
        accelerometerEvents.listen((AccelerometerEvent event) {
          if(mounted) {
            setState(() {
              this.event = event;
              _accelerometerEvent.add(event);

              if (_storeList.isNotEmpty) lastTime = _storeList.last['time'];
              timeStamp = currentMillSecond();
              Map<String, double> _mapList = new Map<String, double>();
              _mapList = {
                'time': timeStamp,
                'latitude': position.latitude,
                'longitude': position.longitude,

                'x': event.x,
                'y': event.y,
                'z': event.z};
              if (lastTime + 100 <= timeStamp) {
                //keep the 100 millisecond time slot
                _storeList.add(
                    _mapList); //each time new piece of data generated, added to _storeList
              }
            });
          }
    });
  }


  /// gets current time
  double currentMillSecond() {
    return new DateTime.now().millisecondsSinceEpoch.toDouble();
  }

//TODO: have bugs
  void _toggleListening() {

    if (drivingCondition == false) {
      _toggleListeningGPS();
      _toggleListeningAcc();
      drivingCondition = true;
    } else {
      _pauseStream();
      drivingCondition = false;
    }

  }


  Color _buttonColor() {
    return _isListeningPosition() ? Colors.red : Colors.green;
  }

  bool _isListeningPosition() => !(_positionStreamSubscription == null ||
      _positionStreamSubscription.isPaused);



  void _pauseStream() { 
    _positionStreamSubscription.pause();
    _streamSubscriptions.pause();

    print("paused");

    //processing data in DrivingDataProcess class
    _finalList = dataProcess.firstFilter(_storeList);
    //dataProcess.storeListToCSV(_finalList);
    //dataProcess.readFromFile();

    _popUpScore(_finalList);
  }

  Text _buttonText() {

    return _isListeningPosition()
        ? Text('stop',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: AppTheme.fontName,
          fontWeight: FontWeight.normal,
          fontSize: 24,
          letterSpacing: 0.0,
          color: AppTheme.nearlyDarkBlue,
        ))
        : Text('start',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: AppTheme.fontName,
          fontWeight: FontWeight.normal,
          fontSize: 24,
          letterSpacing: 0.0,
          color: AppTheme.nearlyDarkBlue,
        ));


  }

  Future<dynamic> _popUpScore(List<Map<String,double>> _storeList) {
    return showDialog(
        context: context,
        builder: (BuildContext context) =>
            Score(list: _storeList));
  }

  @override
  void dispose() {

    if (_positionStreamSubscription != null) {
      _positionStreamSubscription.cancel();
      _positionStreamSubscription = null;
    }

    super.dispose();
  }







}
