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
            _buildCategoryItem("assets/images/fast_food.png", "Fast Food", context),
            _buildCategoryItem("assets/images/sweet.png", "Sweet", context),
            _buildCategoryItem(
                "assets/images/south_indian.png", "South Indian", context),
            _buildCategoryItem("assets/images/icecream.png", "Icecream", context),
            _buildCategoryItem("assets/images/frenchfries.jpg", "French Fries", context),
            _buildCategoryItem("assets/images/sandwich.jpg", "Sandwich", context),
            _buildCategoryItem(
                "assets/images/chholebhature.jpg", "North Indian", context),
            _buildCategoryItem("assets/images/poha.jpg", "Poha", context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String imagePath, String categoryName, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 100,
        height: 130,
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, "/category",arguments: categoryName.toLowerCase());
              },
              child: Container(
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
