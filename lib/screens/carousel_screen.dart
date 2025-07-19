import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class IntroCarouselScreen extends StatefulWidget {
  const IntroCarouselScreen({super.key});

  @override
  State<IntroCarouselScreen> createState() => _IntroCarouselScreenState();
}

class _IntroCarouselScreenState extends State<IntroCarouselScreen> {
  final _controller = CarouselSliderController();

  static const List<String> images = [
    'assets/images/intro1.png',
    'assets/images/intro2.png',
    'assets/images/intro3.png',
    'assets/images/intro4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// --- Carousel ---
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CarouselSlider.builder(
                    controller: _controller,
                    unlimitedMode: true,          // loops back to first slide
                    enableAutoSlider: true,
                    autoSliderDelay: const Duration(seconds: 3),
                    slideTransform: const DefaultTransform(),
                    itemCount: images.length,
                    slideBuilder: (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.broken_image,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  /// left / right arrows
                  Positioned(
                    left: 8,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: _controller.previousPage,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: _controller.nextPage,
                    ),
                  ),
                ],
              ),
            ),

            /// --- Buttons ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context,'/select-campus'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A1B9A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Log In'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup-college'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF6A1B9A),
                        side: const BorderSide(color: Color(0xFF6A1B9A)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Sign Up College'),
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
