
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:tutor_app/src/providers/dio_provider.dart';

import '../models/tutor.dart';
import '../widgets/card_review.dart';
import '../models/tutor.dart';
import 'error_widget.dart';

class ReviewsWidget extends ConsumerWidget {
  ScrollController scrollController;
  Tutor tutor;
  ReviewsWidget({super.key, required this.scrollController,required this.tutor});
  String? formatDateTime(String? dateTimeString) {
    if (dateTimeString != null) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      DateFormat formatter = DateFormat('dd.MM.yyyy HH:mm'); // Формат даты и времени
      return formatter.format(dateTime);
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int lengthReviews = tutor.reviews?.length ?? 0;
    double averageRating = tutor.reviews!.map((review) => review.rating!).reduce((a, b) => a + b) / lengthReviews;

    int counts1 = 0;
    int counts2 = 0;
    int counts3 = 0;
    int counts4 = 0;
    int counts5 = 0;

    tutor.reviews?.forEach((review) {
      if (review.rating != null) {
        switch(review.rating ){
          case 1: counts1++; break;
          case 2: counts2++; break;
          case 3: counts3++; break;
          case 4: counts4++; break;
          case 5: counts5++; break;
        }
      }
    });
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

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
              RatingSummary(
                label: "Отзывы",
                counter: tutor.reviews?.length??0,
                average: averageRating??0,
                showAverage: true,
                counterFiveStars: counts5,
                counterFourStars: counts4,
                counterThreeStars: counts3,
                counterTwoStars: counts2,
                counterOneStars: counts1,
              ),
              Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: tutor.reviews?.length ?? 0,
                    itemBuilder: (_, index) {
                      int? student_id = tutor.reviews?[index].studentId;
                      String? formattedDateTime = formatDateTime(tutor.reviews?[index].dateAndTime);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ref.watch(fetchUserInfo(student_id!)).when(
                                data: (user) => Expanded(
                                  child: Padding(
                                    padding:  EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    user?.image!= null?CachedNetworkImage(
                                                      imageUrl: 'http://0.0.0.0:8000${user!.image}',
                                                      fit: BoxFit.cover,
                                                      imageBuilder: (context, imageProvider) => CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        backgroundImage: imageProvider,
                                                      ),
                                                      placeholder: (context, url) => const Icon(Icons.person_2_sharp,size: 30,),
                                                      errorWidget: (context, url, error) => const Icon(Icons.person_2_sharp,size: 30,),
                                                    )
                                                        : const Icon(Icons.person_2_sharp,size: 30,),
                                                    SizedBox(width: 8,),
                                                    Text('${user?.firstName}', style: h6Style),
                                                  ],
                                                ),
                                                Text("$formattedDateTime", style: h5Style.copyWith(fontSize: 12)),
                                              ],
                                            ),
                                            RatingBar.builder(
                                              itemPadding: EdgeInsets.zero,
                                              itemSize: 25,
                                              initialRating: tutor.reviews![index].rating!.toDouble(),
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
                                            "${tutor.reviews?[index].feedback}",
                                            style: h5Style.copyWith(fontSize: 12),
                                            overflow: TextOverflow.visible
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              error: (error, stack) => ErrorScreen(errorMessage: error),
                              loading: () => const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xDF290505),
                                ),
                              ),
                            ),
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
}



const h4Style = TextStyle(
    fontFamily: "Poppins",
    fontSize: 15,
    fontWeight: FontWeight.bold,
    color: Colors.black);

const h5Style = TextStyle(
    fontFamily: "Poppins",
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: Colors.black);

const h6Style = TextStyle(
    fontFamily: "Poppins",
    fontSize: 25,
    fontWeight: FontWeight.w300,
    color: Colors.black);

class AppColor {
  const AppColor._();

  static const lightOrange = Color(0xFFFAA33C);
  static const lightBlack = Color(0xFF101725);
}
