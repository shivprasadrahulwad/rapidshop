import 'package:flutter/material.dart';
import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/features/admin/screens/fshop_screen.dart';
import 'package:eshop/features/admin/screens/shop_screen.dart';
import 'package:eshop/features/home/screens/category_deals_screen.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);


  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(left: 20 , right: 20),
        child: Row(
          children: List.generate(GlobalVariables.categoryImages.length, (index) {
            return GestureDetector(
              onTap: () => navigateToCategoryPage(
                context,
                GlobalVariables.categoryImages[index]['title']!,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        GlobalVariables.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  Text(
                    GlobalVariables.categoryImages[index]['title']!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          }).expand((widget) => [
            widget,
            const Spacer(), // Add a Spacer after each category
          ]).toList()..removeLast(), // Remove the last Spacer
        ),
      ),
    );
  }
}







class Grocery extends StatelessWidget {
  final String userId; // Include userId in the Grocery class

  const Grocery({Key? key, required this.userId}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, Map<String, dynamic> category) {
    Navigator.pushNamed(
      context,
      ShopScreen.routeName,
      arguments: {
        'category': category,
        'userId': userId,
      },
    ); // Passing category details and userId when navigating
  }

  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> categoryRows = [];

    final chunkSize = 3;
    for (var i = 0; i < GlobalVariables.groceryImages.length; i += chunkSize) {
      final chunk = GlobalVariables.groceryImages.skip(i).take(chunkSize).toList();
      categoryRows.add(
        chunk.map((category) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(context, category),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  // decoration: BoxDecoration(
                  //   color: Colors.grey[200], // Change color as needed
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      category['image']!,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                SizedBox(height: 4), // Add space between container and text
                Flexible(
                  child: Container(
                    width: 80,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      category['title']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: categoryRows.map((row) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: row,
              ),
            ),
          );
        }).toList(),
        
      ),
    );
  }
}


class Beauty extends StatelessWidget {
  final String userId; // Include userId in the Grocery class

  const Beauty({Key? key, required this.userId}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, Map<String, dynamic> category) {
    Navigator.pushNamed(
      context,
      ShopScreen.routeName,
      arguments: {
        'category': category,
        'userId': userId,
      },
    ); // Passing category details and userId when navigating
  }

  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> categoryRows = [];

    final chunkSize = 3;
    for (var i = 0; i < GlobalVariables.beautyImages.length; i += chunkSize) {
      final chunk = GlobalVariables.beautyImages.skip(i).take(chunkSize).toList();
      categoryRows.add(
        chunk.map((category) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(context, category),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  // decoration: BoxDecoration(
                  //   color: Colors.grey[200], // Change color as needed
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      category['image']!,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
                SizedBox(height: 4), // Add space between container and text
                Flexible(
                  child: Container(
                    width: 80,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      category['title']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: categoryRows.map((row) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: row,
              ),
            ),
          );
        }).toList(),
        
      ),
    );
  }
}





class BeautyCategories extends StatelessWidget {
  final String userId; // Include userId in the Grocery class

  const BeautyCategories({Key? key, required this.userId}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, Map<String, dynamic> category) {
    Navigator.pushNamed(
      context,
   FshopScreen.routeName,
      arguments: {
        'category': category,
        'userId': userId,
      },
    ); // Passing category details and userId when navigating
  }

  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> categoryRows = [];

    final chunkSize = 3;
    for (var i = 0; i < GlobalVariables.beautyImages.length; i += chunkSize) {
      final chunk = GlobalVariables.beautyImages.skip(i).take(chunkSize).toList();
      categoryRows.add(
        chunk.map((category) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(context, category),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    // color: Colors.grey[400], // Change color as needed
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      category['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    )
                  ),
                ),
                SizedBox(height: 4), // Add space between container and text
                Flexible(
                  child: Container(
                    width: 80,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      category['title']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Medium'
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: categoryRows.map((row) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: row,
              ),
            ),
          );
        }).toList(),
        
      ),
    );
  }
}



class GroceryCategories extends StatelessWidget {
  final String shopCode; // Include shopCode in the Grocery class

  const GroceryCategories({Key? key, required this.shopCode}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, Map<String, dynamic> category) {
    Navigator.pushNamed(
      context,
      FshopScreen.routeName,
      arguments: {
        'category': category,
        'shopCode': shopCode,
      },
    ); // Passing category details and shopCode when navigating
  }

  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> categoryRows = [];

    final chunkSize = 3;
    for (var i = 0; i < GlobalVariables.groceryImages.length; i += chunkSize) {
      final chunk = GlobalVariables.groceryImages.skip(i).take(chunkSize).toList();
      categoryRows.add(
        chunk.map((category) {
          return GestureDetector(
            onTap: () => navigateToCategoryPage(context, category),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    // color: Colors.grey[400], // Change color as needed
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      category['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    )
                  ),
                ),
                SizedBox(height: 4), // Add space between container and text
                Flexible(
                  child: Container(
                    width: 80,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      category['title']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Medium'
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: categoryRows.map((row) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: row,
              ),
            ),
          );
        }).toList(),
        
      ),
    );
  }
}


