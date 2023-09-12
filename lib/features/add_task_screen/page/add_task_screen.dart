import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksapp/data/model/task_model.dart';
import 'package:tasksapp/features/add_task_screen/bloc/add_task_bloc.dart';

import '../widget/custom_text_form_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController titleCtrl;
  late TextEditingController descriptionCtrl;
  late GlobalKey<FormState> _formKey;
  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController();
    descriptionCtrl = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    descriptionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTaskBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Add Tasks',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: BlocConsumer<AddTaskBloc, AddTaskState>(
          listener: (context, state) {
            if (state is AddingTaskSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Your task has been successfully added.')));
            }
            if (state is AddingTaskError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the title';
                                }
                                return null;
                              },
                              controller: titleCtrl,
                              label: 'Title',
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CustomTextFormField(
                              controller: descriptionCtrl,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the description';
                                }
                                return null;
                              },
                              label: 'Description',
                              maxLines: 30,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (!(_formKey.currentState!.validate())) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please fill the details properly.'),
                                    ),
                                  );
                                  return;
                                }
                                context.read<AddTaskBloc>().add(
                                      AddingTaskEvent(
                                        task: TaskModel(
                                          title: titleCtrl.text,
                                          description: descriptionCtrl.text,
                                        ),
                                      ),
                                    );
                              },
                              child: Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Center(
                                  child: Text(
                                    'Add Task',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
