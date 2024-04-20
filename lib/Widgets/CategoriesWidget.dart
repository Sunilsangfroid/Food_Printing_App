import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
        child: Row(
          children: [
            // Single Item
            _buildCategoryItem("assets/images/fast_food.png", "Fast Food"),
            _buildCategoryItem("assets/images/sweet.png", "Sweet"),
            _buildCategoryItem(
                "assets/images/south_indian.png", "South Indian"),
            _buildCategoryItem("assets/images/icecream.png", "Icecream"),
            _buildCategoryItem("assets/images/frenchfries.jpg", "French Fries"),
            _buildCategoryItem("assets/images/sandwich.jpg", "Sandwich"),
            _buildCategoryItem(
                "assets/images/chholebhature.jpg", "Chhole Bhature"),
            _buildCategoryItem("assets/images/poha.jpg", "Poha"),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String imagePath, String categoryName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 100,
        height: 130,
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
