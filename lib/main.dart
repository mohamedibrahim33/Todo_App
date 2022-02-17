import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/cubit/states.dart';
import 'package:todo_app/layout/home_layout.dart';

import 'layout/cubit/cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AppBlocCubit()..createDatabase(),
      child: BlocConsumer<AppBlocCubit,AppStates>(
        listener: (context, state) {} ,
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}


