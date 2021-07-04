import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

Widget defaultTextEditing({
  @required TextEditingController controller,
  @required TextInputType type,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  bool isPassword = false,
  Function onChanged,
  Function onSubmitted,
  Function onShowPassword,
  Function validator,
  Function onTap,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: onShowPassword,
        ),
      ),
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      onTap: onTap,
    );

Widget defaultButton({
  @required String label,
  Color buttonColor = Colors.blue,
  Function onPressButton,
}) =>
    Container(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: buttonColor,
        splashColor: Colors.white,
        onPressed: onPressButton,
      ),
    );

Widget buildTaskItem(Map data, context) {
  return Dismissible(
    key: Key('${data['id']}'),
    direction: DismissDirection.horizontal,
    background: buildDismissableDirectionElement(
      backgroundColor: Colors.green,
      mainAxisAlignment: MainAxisAlignment.start,
      icon: data['status'] == 'archive' ? Icons.undo : Icons.archive,
      iconColor: Colors.grey[100],
      label: data['status'] == 'archive' ? 'Un Archive Task' : 'Archive Task',
      labelColor: Colors.grey[100],
    ),
    secondaryBackground: buildDismissableDirectionElement(
      backgroundColor: Colors.redAccent,
      mainAxisAlignment: MainAxisAlignment.end,
      icon: Icons.delete,
      iconColor: Colors.grey[100],
      label: 'Delete Task',
      labelColor: Colors.grey[100],
    ),
    confirmDismiss: (direction) async {
      return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (contextxx) {
            return direction == DismissDirection.startToEnd
                ? AlertDialog(
                    backgroundColor: Colors.grey[100],
                    title: Text(
                      data['status'] == 'archive'
                          ? 'un Archiving'
                          : 'Archiving',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    content: Text(
                      data['status'] == 'archive'
                          ? 'Are you sure you want to un archive this task?'
                          : 'Are you sure you want to archive this task?',
                    ),
                    actions: [
                      FlatButton(
                        child: Text(
                          'Sure',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          if (data['status'] == 'archive') {
                            AppCubit.get(context).updateDatabaseData(
                              status: 'new',
                              id: data['id'],
                            );
                          } else {
                            AppCubit.get(context).updateDatabaseData(
                              status: 'archive',
                              id: data['id'],
                            );
                          }
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'cancel',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                : AlertDialog(
                    backgroundColor: Colors.grey[100],
                    title: Text(
                      'WARNING!',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    content: Text('Are you sure you want to delete this task?'),
                    actions: [
                      FlatButton(
                        child: Text(
                          'Delete now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          AppCubit.get(context)
                              .deleteDataFromDatabase(id: data['id']);
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'cancel',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
          });
    },
    child: Container(
      width: double.infinity,
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              data['time'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data['title'],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                data['date'],
                style: TextStyle(
                  fontSize: 15.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == 1) {
                      if (data['status'] != 'done') {
                        AppCubit.get(context).updateDatabaseData(
                          status: 'done',
                          id: data['id'],
                        );
                      } else {
                        AppCubit.get(context).updateDatabaseData(
                          status: 'new',
                          id: data['id'],
                        );
                      }
                    } else if (value == 2) {
                      if (data['status'] != 'archive') {
                        AppCubit.get(context).updateDatabaseData(
                          status: 'archive',
                          id: data['id'],
                        );
                      } else {
                        AppCubit.get(context).updateDatabaseData(
                          status: 'new',
                          id: data['id'],
                        );
                      }
                    } else if (value == 3) {
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (contextx) {
                            return AlertDialog(
                              backgroundColor: Colors.grey[100],
                              title: Text(
                                'WARNING!',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              ),
                              content: Text(
                                  'Are you sure you want to delete this task?'),
                              actions: [
                                FlatButton(
                                  child: Text(
                                    'Delete now',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    AppCubit.get(context)
                                        .deleteDataFromDatabase(id: data['id']);
                                  },
                                ),
                                FlatButton(
                                  child: Text(
                                    'cancel',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    }
                  },
                  itemBuilder: (context) {
                    return <PopupMenuEntry>[
                      buildPopupMenuItem(
                        value: 1,
                        title: data['status'] == 'done'
                            ? 'Mark as un Done'
                            : 'Mark as Done',
                        icon:
                            data['status'] == 'done' ? Icons.undo : Icons.done,
                        iconColor: Colors.lightGreen,
                      ),
                      const PopupMenuDivider(
                        height: 2.0,
                      ),
                      buildPopupMenuItem(
                        value: 2,
                        title: data['status'] == 'archive'
                            ? 'Un Archive Task'
                            : 'Archive Task',
                        icon: data['status'] == 'archive'
                            ? Icons.unarchive
                            : Icons.archive,
                        iconColor: Colors.black26,
                      ),
                      const PopupMenuDivider(
                        height: 2.0,
                      ),
                      buildPopupMenuItem(
                        value: 3,
                        title: 'Delete Task',
                        icon: Icons.delete,
                        iconColor: Colors.redAccent,
                      ),
                    ];
                  },
                  color: Colors.grey[100],
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildPopupMenuItem({
  @required int value,
  @required String title,
  @required IconData icon,
  @required Color iconColor,
}) {
  return PopupMenuItem(
    value: value,
    child: ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget buildDismissableDirectionElement({
  @required Color backgroundColor,
  @required MainAxisAlignment mainAxisAlignment,
  @required IconData icon,
  @required Color iconColor,
  @required String label,
  @required Color labelColor,
}) {
  return Container(
    padding: EdgeInsets.only(
      left: 10,
    ),
    color: backgroundColor,
    child: Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 25.0,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          label,
          style: TextStyle(
            color: labelColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
      ],
    ),
  );
}
