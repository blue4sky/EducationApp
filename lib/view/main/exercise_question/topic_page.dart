// ignore_for_file: prefer_const_constructors

import 'package:education_app/constant/r.dart';
import 'package:education_app/models/network_response.dart';
import 'package:education_app/models/bank_question_list.dart';
import 'package:education_app/repository/exercise_question_api.dart';
import 'package:education_app/view/main/exercise_question/quiz_page.dart';
import 'package:flutter/material.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({Key? key, required this.id}) : super(key: key);
  static String route = "paket_soal_page";
  final String id;

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  BankQuestionList? paketSoalList; // Global var
  getTopic() async {
    final mapelResult = await ExerciseQuestionApi().getExercise(widget.id);
    if (mapelResult.status == Status.success) {
      paketSoalList = BankQuestionList.fromJson(mapelResult.data!);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getTopic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colours.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Topics of The Subject",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select a topic",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: paketSoalList == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Wrap(
                        children:
                            List.generate(paketSoalList!.data!.length, (index) {
                          final currentPaketSoal = paketSoalList!.data![index];
                          return Container(
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: PaketSoalWidget(data: currentPaketSoal));
                        }).toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaketSoalWidget extends StatelessWidget {
  const PaketSoalWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final BankQuestionData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QuizPage(id: data.exerciseId!),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
              ),
              padding: EdgeInsets.all(12),
              child: Image.asset(R.assets.icNote, width: 14),
            ),
            SizedBox(height: 7),
            Text(
              data.exerciseTitle!,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            Text(
              "${data.jumlahDone}/${data.jumlahSoal} Questions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9,
                color: R.colours.greySubtitleHome,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
