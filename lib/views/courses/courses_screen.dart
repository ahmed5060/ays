import 'package:courses_app/providers/courses_provider.dart';
import 'package:courses_app/views/courses/widgets/top_bar_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/courses_list_widget.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await Provider.of<CoursesProvider>(context, listen: false).getCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Column(
        children: [
          TopBarInfoWidget(),
          SizedBox(
            height: 20,
          ),
          CoursesListWidget()
        ],
      ),
    );
  }
}
