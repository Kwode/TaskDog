import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/provider/request_provider.dart';
import 'package:frontend/utilities/confirmation_tiles.dart';
import 'package:frontend/utilities/custom_button.dart';

class SummaryScreen extends ConsumerStatefulWidget {
  const SummaryScreen({super.key});

  @override
  ConsumerState<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends ConsumerState<SummaryScreen> {

  int currentStep = 2;
  final int totalSteps = 3;

  @override
  Widget build(BuildContext context) {
    double progress = (currentStep + 1) / totalSteps;
    final request = ref.watch(requestProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TaskDog",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(30, 58, 138, 1.0),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
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
              "Confirm Request",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(30, 58, 138, 1.0),
              ),
            ),
            //subtext
            Text(
              "Review your details before submitting",
              style: TextStyle(fontSize: 15, color: Colors.grey[700]),
            ),

            SizedBox(height: 30),

            ConfirmationTiles(
              icon: Icons.plumbing,
              title: request.category ?? "Not Selected",
              subtitle: 'SERVICE CATEGORY',
            ),

            SizedBox(height: 10),

            ConfirmationTiles(
              icon: Icons.description,
              title: request.description ?? "Description...",
              subtitle: 'DESCRIPTION',
            ),

            SizedBox(height: 40),
            //describe text
            CustomButton(
              text: 'Submit Request',
              pageFunction: () {},
              icon: Icons.send,
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Back",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
