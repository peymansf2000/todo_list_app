// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:todo_list_app/main.dart';
// import 'package:todo_list_app/models.dart';
// import 'package:todo_list_app/objectbox.dart';

Color lowPriorityColor = const Color(0xff3BE1F1);
Color normalPriorityColor = const Color(0xffF09819);
Color highPriorityColor = primaryColor;

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController _controller = TextEditingController();
  int selectedPriority = 0;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        backgroundColor: themeData.colorScheme.background,
        foregroundColor: themeData.colorScheme.onSurface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 1,
                  child: PriorityCard(
                    label: 'Low',
                    color: lowPriorityColor,
                    priority: 0,
                    onTap: () {
                      setState(() {
                        selectedPriority = 0;
                      });
                    },
                    isSelected: selectedPriority == 0,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  flex: 1,
                  child: PriorityCard(
                    label: 'Normal',
                    color: normalPriorityColor,
                    priority: 1,
                    onTap: () {
                      setState(() {
                        selectedPriority = 1;
                      });
                    },
                    isSelected: selectedPriority == 1,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  flex: 1,
                  child: PriorityCard(
                    label: 'High',
                    color: highPriorityColor,
                    priority: 2,
                    onTap: () {
                      setState(() {
                        selectedPriority = 2;
                      });
                    },
                    isSelected: selectedPriority == 2,
                  ),
                )
              ],
            ),
            Expanded(
              child: TextField(keyboardType: TextInputType.multiline, maxLines: null,scrollPhysics: const ClampingScrollPhysics(),maxLength: 300,
                decoration: const InputDecoration(counterText: '',labelText:'Add a Task for Today...' ,
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    // hintText: 'Add a Task for Today...'
                    ),
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            objectbox.addTask(
                name: _controller.text, priority: selectedPriority);
            Navigator.pop(context);
          },
          label: const Row(
            children: [
              Text('Save Task'),
              SizedBox(
                width: 3,
              ),
              Icon(Icons.check_circle_outline_outlined)
            ],
          )),
    ));
  }
}

class PriorityCard extends StatelessWidget {
  const PriorityCard({
    super.key,
    required this.label,
    required this.priority,
    required this.color,
    required this.onTap,
    required this.isSelected,
  });
  final String label;
  final int priority;
  final Color color;
  final void Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(
                width: 2, color: secondaryTextColor.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(4)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text(label),
          //  _CheckBoxShape(
          //         value: isSelected,
          //         color: color,
          //       ),

          Checkbox(
            value: isSelected,
            onChanged: (bool? value) {
              onTap();
            },
            fillColor: MaterialStateProperty.all(color),
            shape: const CircleBorder(),
            side: BorderSide(color: color, width: 10),
            activeColor: color,
            focusColor: color,
            overlayColor: MaterialStateProperty.all(color),
            hoverColor: color,
          )
        ]),
      ),
    );
  }
}

// class _CheckBoxShape extends StatelessWidget {
//   final bool value;
//   final Color color;

//   const _CheckBoxShape({required this.value, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     final ThemeData themeData = Theme.of(context);
//     return Container(
//       width: 16,
//       height: 16,
//       decoration:
//           BoxDecoration(borderRadius: BorderRadius.circular(12), color: color),
//       child: value
//           ? Icon(
//               CupertinoIcons.check_mark,
//               size: 12,
//               color: themeData.colorScheme.onPrimary,
//             )
//           : null,
//     );
//   }
// }
