import 'package:economics_app/home_page/pages/paper_one_questions_page/paper_one_questions_repository/paper_one_questions_data.dart';
import 'package:economics_app/home_page/pages/paper_one_questions_page/question_detail_page.dart';
import 'package:flutter/material.dart';


class PaperOneQuestionsPage extends StatefulWidget {
  const PaperOneQuestionsPage({super.key});

  @override
  State<PaperOneQuestionsPage> createState() => _PaperOneQuestionsPageState();
}

class _PaperOneQuestionsPageState extends State<PaperOneQuestionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paper 1 Questions')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: paperOneQuestionsData.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final question = paperOneQuestionsData[index];

          return Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                // Navigate to the new specific Question Detail Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionDetailPage(
                      question: question, // Pass the whole object
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    question.question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
