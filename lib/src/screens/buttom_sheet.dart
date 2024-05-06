import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rating_summary/rating_summary.dart';

import '../widgets/card_review.dart';

void showBottom(BuildContext ctx) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    context: ctx,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 2 / 3,
      minChildSize: 0.1,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => reviews(scrollController),
    ),
  );
}

Widget reviews (ScrollController scrollController) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 50,
        height: 5,
        margin: const EdgeInsets.only(top: 10, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black26,
        ),
      ),
      Expanded(
        child: Column(
          children: [
            const RatingSummary(
              label: "Отзывы",
              counter: 13,
              average: 3.846,
              showAverage: true,
              counterFiveStars: 5,
              counterFourStars: 4,
              counterThreeStars: 2,
              counterTwoStars: 1,
              counterOneStars: 1,
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: 7,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15, top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //_furnitureImage(furniture.images[0]),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text("Сергей", style: h4Style),
                                        Text("20.05.24", style: h5Style.copyWith(fontSize: 12)),
                                      ],
                                    ),
                                    RatingBar.builder(
                                      itemPadding: EdgeInsets.zero,
                                      itemSize: 20,
                                      initialRating: 4,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      glow: false,
                                      ignoreGestures: true,
                                      itemBuilder: (_, __) => const Icon(
                                        Icons.star,
                                        size: 2.0,
                                        color: AppColor.lightOrange,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                    "Очень большое описаниеОченьбольшое описаниеОчень большое описаниеОчень большое описаниеОчень большое описаниеОчень большоеописаниеОчень большое описаниеОчень большое описаниеОчень большое описаниеОчень большое описаниеОчень большое описание ",
                                    style: h5Style.copyWith(fontSize: 12),
                                    overflow: TextOverflow.visible
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ),
          ],
        ),
      ),
    ],
  );
}