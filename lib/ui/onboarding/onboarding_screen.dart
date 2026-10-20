import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/local_storage.dart';
import '../app_routes.dart';
import 'models/onboarding_item.dart';
import 'widgets/onboarding_bottom_controls.dart';
import 'widgets/onboarding_header.dart';
import 'widgets/onboarding_page_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  final List<OnboardingItem> _items = OnboardingItem.items;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _items.length) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finishOnboarding();
    }
  }

  Future<void> _finishOnboarding() async {
    await AppLocalStorage.completeOnboarding();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRoutes.registration);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isLastPage = _currentPage == _items.length;
    final bool isMaterialSelectionPage =
        _currentPage == OnboardingPageView.materialSelectionPage;

    final Color backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: SizedBox(
                  width: double.infinity,
                  height: constraints.maxHeight,
                  child: Column(
                    children: [
                      // Header with logo and Skip button
                      OnboardingHeader(
                        onSkip: _finishOnboarding,
                        isLastPage: isLastPage,
                      ),

                      Expanded(
                        child: OnboardingPageView(
                          controller: _pageController,
                          items: _items,
                          currentPage: _currentPage,
                          onPageChanged: (index) =>
                              setState(() => _currentPage = index),
                          onFinish: _finishOnboarding,
                        ),
                      ),

                      if (!isMaterialSelectionPage)
                        OnboardingBottomControls(
                          controller: _pageController,
                          pageCount: _items.length + 1,
                          isLastPage: isLastPage,
                          onNext: _onNext,
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
