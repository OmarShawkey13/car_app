import 'package:car_app/core/theme/colors.dart';
import 'package:car_app/core/theme/text_styles.dart';
import 'package:car_app/core/utils/constants/assets_helper.dart';
import 'package:car_app/core/utils/constants/primary/primary_button.dart';
import 'package:car_app/core/utils/constants/routes.dart';
import 'package:car_app/core/utils/constants/spacing.dart';
import 'package:car_app/core/utils/extensions/context_extension.dart';
import 'package:car_app/features/on_boarding/data/model/on_boarding_model.dart';
import 'package:car_app/features/on_boarding/presentation/widget/on_boarding_page_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnBoardingModel> pages = [
    OnBoardingModel(
      image: AssetsHelper.onBoardingImage1,
      title: 'Welcome to\nQent',
      description: '',
    ),
    OnBoardingModel(
      image: AssetsHelper.onBoardingImage2,
      title: 'Lets Start\nA New Experience\nWith Car rental.',
      description:
          'Discover your next adventure with Qent. we’re here to\nprovide you with a seamless car rental experience.\nLet’s get started on your journey.',
    ),
  ];

  bool get isLastPage => _currentPage == pages.length - 1;

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
              ),
              child: Stack(
                key: ValueKey<int>(_currentPage),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(pages[_currentPage].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.black.withValues(alpha: 0.82),
                          Colors.black.withValues(alpha: 0.2),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  verticalSpace20,
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: pages.length,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, index) {
                        final page = pages[index];
                        return OnBoardingPageItem(
                          title: page.title,
                          description: page.description,
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? const Color(0xff9CA3AF)
                              : ColorsManager.strokeColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  verticalSpace20,
                  PrimaryButton(
                    onPressed: () {
                      isLastPage
                          ? context.pushReplacement<Widget>(Routes.loginRoute)
                          : _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                    },
                    withBorder: true,
                    label: Text(
                      isLastPage ? 'Get Started' : 'Next',
                      style: TextStylesManager.bold18,
                    ),
                  ),
                  verticalSpace12,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
