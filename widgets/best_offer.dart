// import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:house_rent/constant.dart' as constant;
import 'package:house_rent/models/best_offer.dart';
import 'package:house_rent/models/house.dart';
import 'package:house_rent/screens/details/details.dart';

class BestOfferScreen extends StatefulWidget {
  const BestOfferScreen({Key? key}) : super(key: key);

  @override
  State<BestOfferScreen> createState() => _BestOfferScreenState();
}

class _BestOfferScreenState extends State<BestOfferScreen> {
  final _dio = Dio(
    BaseOptions(
      baseUrl: constant.URISTRING,
      connectTimeout: 1000,
      receiveTimeout: 1000,
    ),
  );

  List<BestOffer> _bestOffer = [];

  @override
  void initState() {
    super.initState();
    _handleFetchRoomDetails();
  }

  // var offerData = [];
  _handleFetchRoomDetails() async {
    try {
      var response = await _dio.get("fetchRoom");
      var bestOffers = (response.data['data'] as List<dynamic>)
          .map(
            (e) => BestOffer.fromMap(e),
          )
          .toList();
      setState(() {
        _bestOffer = bestOffers;
      });
    } catch (e) {
      print(e);
    }
  }

  _handleNavigateToDetails(BuildContext context, BestOffer house) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Details(house: house),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Best Offer',
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var offer = _bestOffer[index];
              return InkWell(
                onTap: () => {
                  _handleNavigateToDetails(
                    context,
                    offer,
                  ),
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: offer.imageUrl,
                            height: 80,
                            width: 150,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                offer.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                offer.address,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // const Positioned(
                      //     right: 0,
                      //     child: CircleIconButton(
                      //       iconUrl: 'assets/icons/heart.svg',
                      //       color: Colors.grey,
                      //     ))
                    ],
                  ),
                ),
              );
            },
            itemCount: _bestOffer.length,
          )
        ],
      ),
    );
  }
}
