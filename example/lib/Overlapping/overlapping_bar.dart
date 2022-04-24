import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';

import 'overLapping_view_model.dart';

class OverLappingBar extends StatelessWidget {
  const OverLappingBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('EveryDaySoft_Example'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: const OverLappingWidget(),
      ),
    );
  }
}

class OverLappingWidget extends StatefulWidget {
  const OverLappingWidget({Key? key}) : super(key: key);

  @override
  OverLappingBarState createState() => OverLappingBarState();
}

class OverLappingBarState extends State<OverLappingWidget>
    with TickerProviderStateMixin, OverLapCallBackLogic {
  OverLappingViewModel viewModel = OverLappingViewModel();

  @override
  void initState() {
    super.initState();
    callback = (type, {RadData? radData, double? width}) => {
          setState(() {
            double width = MediaQuery.of(context).size.width;
            switch (type) {
              case OverLapType.animationControllerInit:
                viewModel.animationInitState(context, width / 1.2);
                break;
              case OverLapType.buttonSet:
                viewModel.buttonSetState(callback, this);
                break;
            }
          })
        };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Transform.rotate(
            angle: (viewModel.indicator?.radData == RadData.horizontal
                    ? 360
                    : -90) *
                pi /
                180,
            child: Column(
              children: [
                viewModel.indicatorRowSet(viewModel.indicator,
                    MediaQuery.of(context).size.width / 1.2),
                viewModel.indicatorRowSet(viewModel.indicator2,
                    MediaQuery.of(context).size.width / 1.2),
              ],
            )),
        viewModel.buttonSet(callback),
      ],
    );
  }
}
