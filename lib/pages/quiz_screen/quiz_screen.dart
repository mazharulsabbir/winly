import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:winly/widgets/common_leading.dart';

class QuizeScreen extends StatefulWidget {
  const QuizeScreen({Key? key}) : super(key: key);

  @override
  State<QuizeScreen> createState() => _QuizeScreenState();
}

class _QuizeScreenState extends State<QuizeScreen> {
  final String dummyQestion =
      'What attraction in montreal in one of the largest in the word?';

  final List<String> answes = [
    'Botanical Garden',
    'The science Building',
    'The olempic Stedium'
  ];

  int selectedIndex = 0;

  _timerWidget(BuildContext context) {
    innerPart(double persent) {
      return Stack(
        children: [
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width * persent * 0.01,
            decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
          const Positioned(right: 16, top: 6, child: Icon(PhosphorIcons.clock))
        ],
      );
    }

    return Container(
      height: 40,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: innerPart(80),
    );
  }

  _questionTitle() {
    return RichText(
        text: const TextSpan(children: [
      TextSpan(text: 'Question 1', style: TextStyle(fontSize: 25)),
      TextSpan(text: '/10', style: TextStyle(color: Colors.grey))
    ]));
  }

  _questionBody(String question) {
    return Text(
      question,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
    );
  }

  _answerPart(List<String> answers) {
    answerTile(bool isSelected, String data, int index) {
      const double circleraduis = 20;
      return GestureDetector(
        onTap: () {
          setState(() => selectedIndex = index);
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(13)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data,
                style: const TextStyle(fontSize: 16),
              ),
              isSelected
                  ? Container(
                      height: circleraduis,
                      width: circleraduis,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                      child: const Icon(
                        Icons.done,
                        size: 12,
                      ),
                    )
                  : Container(
                      height: circleraduis,
                      width: circleraduis,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.blueAccent, width: 2)),
                    )
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      itemBuilder: (_, index) {
        return answerTile(index == selectedIndex, answers[index], index);
      },
      separatorBuilder: (_, i) {
        return const SizedBox(
          height: 15,
        );
      },
      itemCount: answers.length,
      shrinkWrap: true,
    );
  }

  button() {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('Next'),
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(100, 50),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Play Game'),
        leading: const CommonLeading(),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // _timerWidget(context),
              // const SizedBox(
              //   height: 30,
              // ),
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: _questionTitle(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              _questionBody(dummyQestion),
              const Spacer(),
              _answerPart(answes),
              const SizedBox(
                height: 20,
              ),
              button()
            ],
          ),
        ),
      ),
    );
  }
}
