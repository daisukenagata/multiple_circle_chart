import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multiple_circle_chart/OverlappingBar/overlapping_data.dart';

import 'overlapping_view_model.dart';

class OverLappingBar extends StatelessWidget {
  OverLappingBar({Key? key}) : super(key: key);
  final OverLappingViewModel viewModel = OverLappingViewModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: viewModel.model.fold = Scaffold(
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
        body: OverLappingWidget(viewModel: viewModel),
      ),
    );
  }
}

class OverLappingWidget extends StatefulWidget {
  const OverLappingWidget({Key? key, required this.viewModel})
      : super(key: key);
  final OverLappingViewModel viewModel;

  @override
  OverLappingBarState createState() => OverLappingBarState();
}

class OverLappingBarState extends State<OverLappingWidget>
    with TickerProviderStateMixin, OverLapCallBackLogic {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 1.2;
    var dta = widget.viewModel.model.radData;
    var length = widget.viewModel.model.globalKeyList.length - 1;
    var iList = widget.viewModel.model.indicatorList;
    var gList = widget.viewModel.model.globalKeyList;
    var scale = widget.viewModel.model.scale;
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(right: 10 * scale * 3)),
                  Transform.rotate(
                      angle: (dta == RadData.horizontal ? 0 : -90) * pi / 180,
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 70)),
                          for (var i = 0; i <= length; i++)
                            widget.viewModel.rowSet(iList[i], width, gList[i]),
                          const Padding(padding: EdgeInsets.only(bottom: 70)),
                        ],
                      )),
                  Padding(padding: EdgeInsets.only(left: 50 * scale * 3)),
                ],
              )),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            widget.viewModel.sliderSet(OverLapType.slider, callback, 2,
                widget.viewModel.model.scale, this),
            widget.viewModel.sliderSet(OverLapType.graphWidth, callback, 30,
                widget.viewModel.model.sizeHeight, this),
            widget.viewModel.buttonSet(callback, this),
            const Padding(padding: EdgeInsets.only(bottom: 20)),
          ],
        ),
      ],
    );
  }

  @override
  OverLapCallBack? callback(type, {OverLappingBarState? vsync, double? value}) {
    setState(() {
      switch (type) {
        case OverLapType.graph:
          double width = MediaQuery.of(context).size.width / 1.2;
          widget.viewModel.model.graphCount = 10;
          widget.viewModel.animationInitState(context, width);
          break;
        case OverLapType.slider:
          widget.viewModel.model.scale = value ?? 0;
          widget.viewModel.model.animationController?.forward();
          break;
        case OverLapType.graphWidth:
          widget.viewModel.model.sizeHeight = value ?? 0;
          widget.viewModel.model.animationController?.forward();
          break;
      }
    });
    return null;
  }
}
