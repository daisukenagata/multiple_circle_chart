import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';

import 'overlapping_view_model.dart';

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
  Widget build(BuildContext context) {
    var dta = viewModel.lastIndicator?.radData;
    double width = MediaQuery.of(context).size.width / 1.2;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Transform.rotate(
            angle: (dta == RadData.horizontal ? 360 : -90) * pi / 180,
            child: Column(
              children: [
                viewModel.indicatorRowSet(
                    viewModel.indicator, width, viewModel.globalKey),
                viewModel.indicatorRowSet(
                    viewModel.indicator2, width, viewModel.globalKey2),
                viewModel.indicatorRowSet(
                    viewModel.indicator3, width, viewModel.globalKey3),
                viewModel.indicatorRowSet(
                    viewModel.lastIndicator, width, viewModel.lastGlobalKey),
              ],
            )),
        viewModel.buttonSet(callback, this),
      ],
    );
  }

  @override
  OverLapCallBack? callback(OverLapType type) {
    setState(() {
      double width = MediaQuery.of(context).size.width;
      switch (type) {
        case OverLapType.animationControllerInit:
          viewModel.graphCount = 4;

          /// 2 is this number.
          viewModel.animationInitState(context, width / 1.2);
          break;
      }
    });
    return null;
  }
}
