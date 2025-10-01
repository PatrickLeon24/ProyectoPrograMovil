import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'item_genero_controller.dart';

class ItemGeneroPage extends StatelessWidget {
  ItemGeneroController control = Get.put(ItemGeneroController());

  Widget _buildBody(BuildContext context) {
    return SafeArea(child: Text('ItemGenero Page'));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: null,
        body: _buildBody(context),
      ),
    );
  }
}
