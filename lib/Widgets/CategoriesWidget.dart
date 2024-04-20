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
            _buildCategoryItem("assets/images/fast_food.png"),
            _buildCategoryItem("assets/images/burger.jpg"),
            _buildCategoryItem("assets/images/alooparatha.jpg"),
            _buildCategoryItem("assets/images/biryani.jpg"),
            _buildCategoryItem("assets/images/frenchfries.jpg"),
            _buildCategoryItem("assets/images/sandwich.jpg"),
            _buildCategoryItem("assets/images/chholebhature.jpg"),
            _buildCategoryItem("assets/images/poha.jpg"),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
        ),
      ),
    );
  }
}
