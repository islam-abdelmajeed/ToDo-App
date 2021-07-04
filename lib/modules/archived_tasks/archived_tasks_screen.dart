import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/components/reusable_components.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) => ListView.separated(
        itemBuilder: (context, index) =>
            buildTaskItem(AppCubit.get(context).archivedTasks[index], context),
        separatorBuilder: (context, index) => SizedBox(
          height: 10.0,
        ),
        itemCount: AppCubit.get(context).archivedTasks.length,
      ),
    );
  }
}
