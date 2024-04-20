
import 'package:flutter/material.dart';

class UI22 extends StatefulWidget {
  @override
  _UI22State createState() => _UI22State();
}

class _UI22State extends State<UI22> {
  List<bool> isTypeSelected = [false, false, false, true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 2.0,
        centerTitle: true,
        title: const Text(
          "Feedback",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            const Text(
              "Please select the type of the feedback",
              style: TextStyle(
                color: Color(0xFFC5C5C5),
              ),
            ),
            const SizedBox(height: 25.0),
            GestureDetector(
              child: buildCheckItem(
                  title: "Login trouble", isSelected: isTypeSelected[0]),
              onTap: () {
                setState(() {
                  isTypeSelected[0] = !isTypeSelected[0];
                });
              },
            ),
            GestureDetector(
              child: buildCheckItem(
                  title: "Phone number related", isSelected: isTypeSelected[1]),
              onTap: () {
                setState(() {
                  isTypeSelected[1] = !isTypeSelected[1];
                });
              },
            ),
            GestureDetector(
              child: buildCheckItem(
                  title: "Personal profile", isSelected: isTypeSelected[2]),
              onTap: () {
                setState(() {
                  isTypeSelected[2] = !isTypeSelected[2];
                });
              },
            ),
            GestureDetector(
              child: buildCheckItem(
                  title: "Other issues", isSelected: isTypeSelected[3]),
              onTap: () {
                setState(() {
                  isTypeSelected[3] = !isTypeSelected[3];
                });
              },
            ),
            GestureDetector(
              child: buildCheckItem(
                  title: "Suggestions", isSelected: isTypeSelected[4]),
              onTap: () {
                setState(() {
                  isTypeSelected[4] = !isTypeSelected[4];
                });
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            buildFeedbackForm(),
            const SizedBox(height: 20.0),
            buildNumberField(),
            const Spacer(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      backgroundColor:  MaterialStateProperty.all<Color>(Color(0xFFE5E5E5)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  buildNumberField() {
    return TextField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0.0),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 1.0,
                    color: Color(0xFFC5C5C5),
                  ),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "+60",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC5C5C5),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.cyan,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
          ],
        ),
        hintStyle: const TextStyle(
          fontSize: 14.0,
          color: Color(0xFFC5C5C5),
        ),
        hintText: "Phone Number",
        border: const OutlineInputBorder(),
      ),
    );
  }

  buildFeedbackForm() {
    return Container(
      height: 200,
      child: Stack(
        children: [
          const TextField(
            maxLines: 10,
            decoration: InputDecoration(
              hintText: "Please briefly describe the issue",
              hintStyle: TextStyle(
                fontSize: 13.0,
                color: Color(0xFFC5C5C5),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFE5E5E5),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1.0,
                    color: Color(0xFFA6A6A6),
                  ),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E5E5),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.add,
                        color: Color(0xFFA5A5A5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  const Text(
                    "Upload screenshot (optional)",
                    style: TextStyle(
                      color: Color(0xFFC5C5C5),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCheckItem({required String title, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.circle,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          const SizedBox(width: 10.0),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.grey),
          ),
        ],
      ),
    );
  }
}
