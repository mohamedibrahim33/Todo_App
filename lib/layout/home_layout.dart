import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/cubit/cubit.dart';
import 'package:todo_app/modules/create_task.dart';

import '../shared/components.dart';
import 'cubit/states.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppBlocCubit cubit = AppBlocCubit.get(context);
    return BlocConsumer<AppBlocCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigateTo(context, CreateTask());
              },
              child: const Icon(
                Icons.add,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.bottomNavigationBarChange(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'archived',
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        });
  }
}
