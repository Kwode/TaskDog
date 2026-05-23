import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/provider/request_provider.dart';
import 'package:frontend/features/screens/summary_screen.dart';
import 'package:frontend/utilities/book_tile.dart';
import 'package:frontend/utilities/custom_button.dart';
import 'package:frontend/services/api_service.dart';
import 'dart:async';

import 'package:frontend/utilities/urgency_utils.dart';

import '../../utilities/typing_dots.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  const DetailsScreen({super.key});

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  int currentStep = 1;
  final int totalSteps = 3;

  Timer? debounce;

  final ApiService apiService = ApiService();

  String? urgency;
  double? confidence;
  bool isLoading = false;

  Future<void> analyzeDescription(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final result = await apiService.analyzeText(text);
      print(result);

      setState(() {
        urgency = result["urgency"];
        confidence = result["confidence"];
        isLoading = false;
      });

      ref.read(requestProvider.notifier).state =
          ref.read(requestProvider).copyWith(
            urgency: urgency,
          );
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      print(e);
    }
  }

  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentStep + 1) / totalSteps;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TaskDog",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(30, 58, 138, 1.0),
                ),
              ),
              Icon(Icons.question_mark_outlined, color: Colors.grey),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "STEP ${currentStep + 1} of $totalSteps"
                )
              ],
            ),
            SizedBox(height: 6,),
            LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(height: 30),
            //title
            Text(
              "Request Details",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(30, 58, 138, 1.0),
              ),
            ),
            //subtext
            Text(
              "Describe the issue and choose your preferred schedule",
              style: TextStyle(fontSize: 15, color: Colors.grey[700]),
            ),

            SizedBox(height: 40),
            //describe text
            Text(
              "Describe your issue",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),
            //textfield
            TextField(
              controller: descriptionController,
              onChanged: (value) {
                ref.read(requestProvider.notifier).state =
                    ref.read(requestProvider).copyWith(
                      description: value,
                    );

                if (debounce?.isActive ?? false) {
                  debounce!.cancel();
                }

                debounce = Timer(
                  Duration(milliseconds: 800),
                      () async {
                    if (value.length > 15) {
                      await analyzeDescription(value);
                    }
                  },
                );
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(16),
                hintText:
                    "Example: My kitchen sink is leaking badly and there is some water damage under the cabinet",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              maxLines: 6,
              minLines: 4,
            ),
            SizedBox(height: 15),
            //suggested urgency suggestions
            if (isLoading)
              Chip(
                backgroundColor: Colors.blue.withOpacity(0.15),
                avatar: Icon(Icons.auto_awesome, color: Colors.blue),
                label: const TypingDots(),
              ),

            if (urgency != null && confidence != null)
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Chip(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: getUrgencyColor(urgency),
                  avatar: Icon(Icons.auto_awesome, color: Colors.white),
                  label: Text(
                    "$urgency • ${(confidence! * 100).toStringAsFixed(0)}%",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            SizedBox(height: 40),
            //schedule text
            Text(
              "Schedule",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            //date - utility
            BookTile(
              icon: Icons.calendar_month,
              title: 'DATE',
              subtitle: 'SELECT DATE',
            ),
            SizedBox(height: 10),
            //time - utility
            BookTile(
              icon: Icons.timer_sharp,
              title: 'TIME',
              subtitle: 'SELECT TIME',
            ),
          ],
        ),
      ),
      //continue button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 50,
          child: CustomButton(
            text: 'Continue',
            pageFunction: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SummaryScreen()),
              );
            },
            icon: Icons.arrow_forward,
          ),
        ),
      ),
    );
  }
}
