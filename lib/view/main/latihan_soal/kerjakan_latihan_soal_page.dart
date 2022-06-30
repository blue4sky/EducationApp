import 'package:education_app/models/kerjakan_soal_list.dart';
import 'package:education_app/models/network_response.dart';
import 'package:education_app/repository/latihan_soal_api.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class KerjakanLatihanSoalPage extends StatefulWidget {
  const KerjakanLatihanSoalPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<KerjakanLatihanSoalPage> createState() =>
      _KerjakanLatihanSoalPageState();
}

class _KerjakanLatihanSoalPageState extends State<KerjakanLatihanSoalPage>
    with SingleTickerProviderStateMixin {
  KerjakanSoalList? soalList;
  getQuestionList() async {
    final result = await LatihanSoalApi().postQuestionList(widget.id);
    if (result.status == Status.success) {
      soalList = KerjakanSoalList.fromJson(result.data!);
      _controller = TabController(length: soalList!.data!.length, vsync: this);
      setState(() {});
    }
  }

  TabController? _controller;

  @override
  void initState() {
    super.initState();
    getQuestionList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latihan Soal"),
      ),
      // Next Button or Submit Button
      bottomNavigationBar: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Selanjutnya"))
          ],
        ),
      ),
      body: soalList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                // TabBar No Soal
                Container(
                  child: TabBar(
                    controller: _controller,
                    tabs: List.generate(
                        soalList!.data!.length,
                        (index) => Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )),
                  ),
                ),
                // TabBarView Quest and Choices
                Expanded(
                  child: Container(
                    child: TabBarView(
                        controller: _controller,
                        children: List.generate(
                          soalList!.data!.length,
                          (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Soal No ${index + 1}"),
                              if (soalList!.data![index].questionTitle != null)
                                Text(soalList!.data![index].questionTitle!),
                              if (soalList!.data![index].questionTitleImg !=
                                  null)
                                Image.network(
                                    soalList!.data![index].questionTitleImg!),
                            ],
                          ),
                        ).toList()),
                  ),
                ),
              ],
            ),
    );
  }
}
