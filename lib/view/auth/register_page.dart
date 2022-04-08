import 'package:education_app/constant/r.dart';
import 'package:education_app/view/main/main_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

// enum -> naming Constant value
enum Gender { lakiLaki, perempuan }

class _RegisterPageState extends State<RegisterPage> {
  List<String> classSlta = ["10", "11", "12", "Gap Year", "Umum"];
  String? kelas = "10";
  String? gender = "";

  setGender(Gender type) {
    if (type == Gender.lakiLaki) {
      gender = "Laki-laki";
    } else {
      gender = "Perempuan";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yuk isi data diri"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // From left to right
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nama Lengkap",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(
                  color: const Color(0XFFD6D6D6),
                ),
              ),
              height: 50,
              child: const TextField(
                enabled: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Write here...",
                  hintStyle: TextStyle(color: Color(0XFFAAAAAA)),
                ),
              ),
            ),
            SizedBox(height: 10),
            const Text(
              "Jenis Kelamin",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 5),

            // Either Laki-Laki or Perempuan
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setGender(Gender.lakiLaki);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: gender == "Laki-laki"
                          ? R.colors.primary
                          : Colors.white,
                      border: Border.all(
                        color: gender == "Laki-laki"
                            ? R.colors.primary
                            : const Color(0XFFD6D6D6),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: (32),
                      vertical: (12),
                    ),
                    child: Text(
                      "Laki-laki",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color:
                            gender == "Laki-laki" ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    setGender(Gender.perempuan);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: gender == "Perempuan"
                          ? R.colors.primary
                          : Colors.white,
                      border: Border.all(
                        color: gender == "Perempuan"
                            ? R.colors.primary
                            : const Color(0XFFD6D6D6),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: (32),
                      vertical: (12),
                    ),
                    child: Text(
                      "Perempuan",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color:
                            gender == "Perempuan" ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Kelas",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0XFFD6D6D6),
                    ),
                  ),
                  height: 50,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      icon: const Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      hint: const Text(
                        "pilih kelas",
                        style: TextStyle(
                          color: Color(0XFFAAAAAA),
                        ),
                      ),
                      items: classSlta
                          .map((e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      value: kelas,
                      onChanged: (String? val) {
                        kelas = val;
                        setState(() {
                          // validation();
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.blue,
                  fixedSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(color: R.colors.primary),
                  ), 
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "DAFTAR",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
