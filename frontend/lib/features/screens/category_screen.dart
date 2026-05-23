import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/provider/request_provider.dart';
import 'package:frontend/features/screens/details_screen.dart';
import 'package:frontend/utilities/custom_button.dart';
import 'package:frontend/utilities/service_cards.dart';
import 'package:frontend/utilities/trust_card.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {

  int currentStep = 0;
  final int totalSteps = 3;

  @override
  Widget build(BuildContext context) {
    final request = ref.watch(requestProvider);
    final selectedCategory = request.category;
    double progress = (currentStep + 1) / totalSteps;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back,
                  color: Color.fromRGBO(30, 58, 138, 1.0),
                ),
              ),
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
            Text(
              "Choose a Service",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(30, 58, 138, 1.0),
              ),
            ),

            Text(
              "Select the type of service you need to get started with your request",
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 40),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ServiceCards(
                  isSelected: selectedCategory == "Cleaning",
                  icon: Icons.cleaning_services_outlined,
                  text: "Cleaning",
                  subtitle: "Home and office cleaning",
                  onTap: () {
                    ref.read(requestProvider.notifier).state = ref
                        .read(requestProvider)
                        .copyWith(category: "Cleaning");
                  },
                ),
                ServiceCards(
                  isSelected: selectedCategory == "Electrical",
                  icon: Icons.electrical_services,
                  text: "Electrical",
                  subtitle: "Repairs and installation",
                  onTap: () {
                    ref.read(requestProvider.notifier).state = ref
                        .read(requestProvider)
                        .copyWith(category: "Electrical");
                  },
                ),
                ServiceCards(
                  isSelected: selectedCategory == "Plumbing",
                  icon: Icons.plumbing_sharp,
                  text: "Plumbing",
                  subtitle: "Pipe repairs and plumbing",
                  onTap: () {
                    ref.read(requestProvider.notifier).state = ref
                        .read(requestProvider)
                        .copyWith(category: "Plumbing");
                  },
                ),
                ServiceCards(
                  isSelected: selectedCategory == "Mechanics",
                  icon: Icons.manage_accounts_outlined,
                  text: "Mechanics",
                  subtitle: "Vehicle maintenance and repairs",
                  onTap: () {
                    ref.read(requestProvider.notifier).state = ref
                        .read(requestProvider)
                        .copyWith(category: "Mechanics");
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            TrustCard(),

            const SizedBox(height: 80), // space for bottom button
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 50,
          child: CustomButton(
              text: 'Continue',
              pageFunction: selectedCategory == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => DetailsScreen()),
                      );
                    }, icon: Icons.arrow_forward,
            ),
        ),
      ),
    );
  }
}
