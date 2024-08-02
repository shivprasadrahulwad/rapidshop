import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:eshop/constants/global_variables.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map(
        (i) {
          return Builder(
            builder: (BuildContext context) => Container(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  i,
                  fit: BoxFit.cover,
                  height: 200,
                  width: 400,
                ),
              ),
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 0.9,
        height: 200,
        enableInfiniteScroll: true, // Disable infinite scrolling
        scrollDirection: Axis.horizontal, // Allow horizontal scrolling only
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
      ),
    );
  }
}



class CarouselImageshort extends StatelessWidget {
  const CarouselImageshort({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map(
        (i) {
          return Builder(
            builder: (BuildContext context) => Container(
              width: MediaQuery.of(context).size.width, // Set width to full width of screen
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  i,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 1.0, // Ensure images occupy full width of screen
        enableInfiniteScroll: true, // Enable infinite scrolling
        scrollDirection: Axis.horizontal,
        height: 100 ,// Allow horizontal scrolling only
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
      ),
    );
  }
}
