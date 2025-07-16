import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ub_flutter/utils/data.dart';
import 'package:ub_flutter/utils/layout/default_layout.dart';
import 'package:ub_flutter/utils/router/router.dart';
import 'package:ub_flutter/utils/view/button/normal/button.dart';

class TestHomeScreen extends StatefulWidget {
  const TestHomeScreen({super.key});

  @override
  State<TestHomeScreen> createState() => _TestHomeScreenState();
}

class _TestHomeScreenState extends State<TestHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'Home',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: ListView.separated(
            itemBuilder: (context, index) {
              final value = UbTestRoute.testValues[index];
              return UbButton(
                title: '${index + 1}. Go to ${value.name}',
                onPressed: () {
                  context.goNamed(value.name);
                },
              );
            },
            separatorBuilder: (context, index){
              return const SizedBox(height: 8);
            },
            itemCount: UbTestRoute.testValues.length,
          ),
        ));
  }
}
