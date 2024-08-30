import 'package:flutter/material.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import '../widgets/onboarding_page_widget.dart';
import 'custom_navigation_bar.dart';

class OnboardingScreen extends StatefulWidget {
  final OnboardingViewModel viewModel;
  final VoidCallback onComplete;  // Add this callback

  OnboardingScreen({required this.viewModel, required this.onComplete});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemCount: widget.viewModel.onboardingPages.length,
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(
                    model: widget.viewModel.onboardingPages[index],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: widget.onComplete,  // Skip onboarding
                    child: Text(
                      'skip',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  Row(
                    children: List.generate(
                      widget.viewModel.onboardingPages.length,
                          (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? Colors.redAccent
                              : Colors.white30,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward, color: Colors.redAccent),
                    onPressed: () {
                      if (_currentPage < widget.viewModel.onboardingPages.length - 1) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        widget.onComplete();  // Complete onboarding and navigate to home screen
                      }
                    },
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