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
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'To Do List',
                            style: themeData.textTheme.titleLarge,
                          ),
                          const Icon(
                            CupertinoIcons.share,
                            color: Colors.white,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: TextField(
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  CupertinoIcons.search,
                                  color: secondaryTextColor,
                                ),
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
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Container(
                  decoration:
                      BoxDecoration(color: themeData.colorScheme.background),
                  child: Column(
                    children: [const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Today',
                                style: themeData.textTheme.titleSmall
                                    ?.copyWith(fontSize: 17),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                width: 70,
                                height: 3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(28),
                                    color: themeData.colorScheme.primary),
                              )
                            ],
                          ),
                          MaterialButton(
                            onPressed: () {},
                            color: const Color(0xFFEAEFF5),
                            textColor: secondaryTextColor,
                            elevation: 0,
                            child: const Row(
                              children: [
                                Text('Delete All'),
                                Icon(CupertinoIcons.delete_solid)
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: StreamBuilder<List<Task>>(
                  stream: objectbox.getTasks(),
                  builder: (context, snapshot) => ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
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
                MaterialPageRoute(builder: (context) => const EditTaskScreen()),
              );
            },
            label: const Row(
              children: [
                Text('Add New Task'),
                SizedBox(
                  width: 4,
                ),
                Icon(Icons.add_circle_outline)
              ],
            ),
          )),
    );
  }
}

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.index});
  final int index;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    late Color selectedPriorityColor;
final entity =  objectbox.taskBox.getAll()[widget.index];
switch (entity.priority){
  case(0):
    selectedPriorityColor = lowPriorityColor;
  break;
  case(1):
    selectedPriorityColor = normalPriorityColor;
  break;
    case(2):
    selectedPriorityColor = highPriorityColor;
  break;
}
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 3, 16, 0),
      child: Stack(
        children: [
          ListTile(
            tileColor: themeData.colorScheme.onPrimary,
            leading: Checkbox(
                shape: const CircleBorder(),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                }),
            title: Expanded(
                child: Text(
              entity.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
          ),
        Positioned(right: 0,bottom: 0,top: 0,child: Container(width: 6,decoration: BoxDecoration(color:selectedPriorityColor ),))],
      ),
    );
  }
}
