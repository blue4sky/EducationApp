import 'package:education_app/models/subject_list.dart';
import 'package:education_app/view/main/exercise_question/home_page.dart';
import 'package:education_app/view/main/exercise_question/topic_page.dart';
import 'package:flutter/material.dart';

class SubjectPage extends StatelessWidget {
  const SubjectPage({Key? key, required this.mapel}) : super(key: key);
  static String route = "mapel_page";

  final SubjectList mapel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Select a subject",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 20,
        ),
        child: ListView.builder(
            itemCount: mapel.data!.length,
            itemBuilder: ((context, index) {
              final currentMapel = mapel.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TopicPage(id: currentMapel.courseId!),
                  ));
                },
                child: TopicWidget(
                  title: currentMapel.courseName!,
                  totalPacket: currentMapel.jumlahMateri!,
                  totalDone: currentMapel.jumlahDone!,
                ),
              );
            })),
      ),
    );
  }
}
