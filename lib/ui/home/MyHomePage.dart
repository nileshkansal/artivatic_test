import 'package:artivatic_test/provider/HomeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomeWidgets.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    var provider = Provider.of<HomeProvider>(context, listen: false);
    provider.callAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (BuildContext context, HomeProvider homeProvider, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(homeProvider.showTitle()),
          actions: [
            IconButton(
              onPressed: () {
                homeProvider.callAPI();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            searchBox(context, homeProvider),
            dataList(context, homeProvider),
          ],
        ),
      );
    });
  }
}