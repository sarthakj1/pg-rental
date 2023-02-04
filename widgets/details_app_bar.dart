import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:house_rent/models/best_offer.dart';
import 'package:house_rent/models/house.dart';

class DetailsAppBar extends StatelessWidget {
  final BestOffer house;

  const DetailsAppBar({Key? key, required this.house}) : super(key: key);

  _handleNavigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: house.imageUrl,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          // Image.asset(
          //   house.imageUrl,
          //   fit: BoxFit.cover,
          //   height: double.infinity,
          // ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _handleNavigateBack(context),
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xffF5591F),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.keyboard_arrow_left_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
