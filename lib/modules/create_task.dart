import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../shared/components.dart';

class CreateTask extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBlocCubit, AppStates>(
        listener: (context, state) {},
    builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('create new task'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    defaultFormField(
                      controller: titleController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'row title is empty';
                        }
                        return null;
                      },
                      label: 'task title',
                      prefix: Icons.title,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: timeController,
                      type: TextInputType.datetime,
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          timeController.text = value!.format(context);
                        });
                      },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'row time is empty';
                        }
                        return null;
                      },
                      label: 'time title',
                      prefix: Icons.watch_later,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                      controller: dateController,
                      type: TextInputType.datetime,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.parse('2022-12-22'),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse('2022-12-30'),
                        ).then((value) {
                          dateController.text = DateFormat.yMMMd().format(value!);
                        }).catchError((error) {
                          print('$error');
                        });
                      },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'row date is empty';
                        }
                        return null;
                      },
                      label: 'date time',
                      prefix: Icons.calendar_today,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 200.0,
                      child: MaterialButton(
                        onPressed: () {
                          if(formKey.currentState!.validate()){
                            AppBlocCubit.get(context).insertToDatabase(
                              title: titleController.text,
                              date: dateController.text,
                              time: timeController.text,
                            ).then((value) {
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: const Text(
                          'Create',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    );
  }
}
