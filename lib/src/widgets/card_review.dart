
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
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

class AppColor {
  const AppColor._();

  static const lightOrange = Color(0xFFFAA33C);
  static const lightBlack = Color(0xFF101725);
}
