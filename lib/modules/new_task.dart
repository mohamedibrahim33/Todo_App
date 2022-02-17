import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../shared/components.dart';

class NewTasksScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<AppBlocCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var tasks = AppBlocCubit.get(context).newTasks;

        return tasksBuilder(
          tasks: tasks,
        );
      },
    );
  }
}