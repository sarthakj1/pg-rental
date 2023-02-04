import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_rent/models/best_offer.dart';
import 'package:house_rent/utils/color.dart';

class HouseInfo extends StatelessWidget {
  final BestOffer house;
  const HouseInfo({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              _MenuInfo(
                imageUrl: 'assets/icons/bedroom.svg',
                content: house.bedroom,
              ),
              _MenuInfo(
                imageUrl: 'assets/icons/bathroom.svg',
                content: house.bathroom,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _MenuInfo(
                imageUrl: 'assets/icons/kitchen.svg',
                content: house.kitchen,
              ),
              _MenuInfo(
                imageUrl: 'assets/icons/home.svg',
                content: house.vacant,
              ),
              _MenuInfo(
                imageUrl: 'assets/icons/parking.svg',
                content: house.parking,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _MenuInfo extends StatelessWidget {
  final String imageUrl;
  final String content;

  const _MenuInfo({
    Key? key,
    required this.imageUrl,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          SvgPicture.asset(imageUrl, color: orangeColors),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 12,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
