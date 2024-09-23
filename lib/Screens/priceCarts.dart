import 'package:flutter/material.dart';

class PriceCarts extends StatefulWidget {
  @override
  _PriceCartsState createState() => _PriceCartsState();
}

class _PriceCartsState extends State<PriceCarts> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  double _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Ellipse3.png'),
            alignment: Alignment.topRight,
            scale: 1.1,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title at the top-left corner
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 35, bottom: 10),
                  child: Text(
                    'Lawyer Digital Library',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 22,
                      color: const Color(0xff042334),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              // Scrollable Package Cards with Animation
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 3, // Number of packages (Basic, Standard, Premium)
                  itemBuilder: (context, index) {
                    double scale = _currentPage == index
                        ? 1.0
                        : (_currentPage - index).abs() < 1
                            ? 0.8 + (1 - (_currentPage - index).abs()) * 0.2
                            : 0.8; // Scaling logic

                    return Transform.scale(
                      scale: scale,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: _buildCard(index),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Dot indicators
              _buildDotIndicators(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Build individual card based on the index
  Widget _buildCard(int index) {
    List<String> planNames = ['Basic', 'Standard', 'Premium'];
    List<String> prices = ['₨ 200/mo', '₨ 1500/mo', '₨ 3000/mo']; // Prices in PKR

    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0x80FFFFFF), // White with 50% opacity
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xff41BFAA), // Border color
          width: 2, // Border width
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3), // Changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          // Plan name (e.g., Basic, Standard, Premium)
          Text(
            planNames[index],
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: const Color(0xff042334),
            ),
          ),
          const SizedBox(height: 20),
          // Icon related to pricing
          Icon(
            Icons.attach_money,
            size: 70,
            color: const Color(0xff41BFAA),
          ),
          const SizedBox(height: 20),
          // Price Text
          Text(
            prices[index],
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 15,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              color: const Color(0xff41BFAA),
            ),
          ),
          const SizedBox(height: 20),
          // Plan details (features for lawyers)
          _buildFeatureText('Store Case Files'),
          _buildFeatureText('Track Case Progress'),
          _buildFeatureText('Secure Document Storage'),
          _buildFeatureText('Client Communication Tools'),
          _buildFeatureText('Calendar for Appointments'),
          const SizedBox(height: 40),
          // Custom Button
          CustomButton(
            btnText: 'Select Plan',
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // Helper function to build feature texts in consistent styling
  Widget _buildFeatureText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          color: Color(0xff042334),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Build dot indicators
  Widget _buildDotIndicators() {
    int dotCount = 3; // Number of plans
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(dotCount, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage.round() == index
                ? const Color(0xff41BFAA) // Active color
                : Colors.grey, // Inactive color
          ),
        );
      }),
    );
  }
}

class CustomButton extends StatefulWidget {
  final String btnText;
  final VoidCallback onPressed;

  CustomButton({required this.btnText, required this.onPressed});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            fixedSize: Size(200, 50), // Reduced size
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            primary: _isHovered ? Colors.black : Color(0xFF4DB6AC),
          ),
          child: Text(
            widget.btnText,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}
