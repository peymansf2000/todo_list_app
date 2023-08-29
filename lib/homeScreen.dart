import 'package:flutter/cupertino.dart';
import 'package:todo_list_app/main.dart';
import 'package:todo_list_app/models.dart';

import 'editTaskScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return SafeArea(
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Column(
            children: [
              Container(
                height: 124,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  themeData.colorScheme.primary,
                  themeData.colorScheme.primaryContainer
                ])),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'To Do List',
                            style: themeData.textTheme.titleLarge,
                          ),
                          Icon(
                            CupertinoIcons.share,
                            color: Colors.white,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: TextField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(CupertinoIcons.search,color: secondaryTextColor,),
                                hintText: 'Search Tasks',
                                filled: true,
                                fillColor: themeData.colorScheme.onPrimary,
                                border: InputBorder.none),
                          ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text('Today',style: themeData.textTheme.titleSmall?.copyWith(fontSize: 17),),Container(margin: EdgeInsets.only(top: 4),width: 70,height: 3,decoration: BoxDecoration(borderRadius: BorderRadius.circular(28),color: themeData.colorScheme.primary),)],),MaterialButton(onPressed: (){},color: Color(0xFFEAEFF5),textColor: secondaryTextColor,elevation: 0,child: Row(
                  children: [
                    Text('Delete All'),Icon(CupertinoIcons.delete_solid)
                  ],
                ),)],),
              )
              ,
              Flexible(
                child: StreamBuilder<List<Task>>(
                  stream: objectbox.getTasks(),
                  builder: (context, snapshot) => ListView.builder(
                    itemBuilder: (context, index) => TaskCard(
                      index: index,
                    ),
                    itemCount: objectbox.taskBox.count(),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditTaskScreen()),
              );
            },
            label: Row(
              children: [
                const Text('Add New Task'),SizedBox(width: 4,),
              Icon(Icons.add_circle)],
            ),
          )),
    );
  }
}

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.index});
  final index;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
  final themeData = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 3, 16, 0),
      child: ListTile(
        tileColor: themeData.colorScheme.onPrimary,
        leading: Checkbox(
            shape: const CircleBorder(),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            }),
        title: Expanded(child: Text(objectbox.taskBox.getAll()[widget.index].name,maxLines: 1,overflow: TextOverflow.ellipsis,)),
      ),
    );
  }
}
