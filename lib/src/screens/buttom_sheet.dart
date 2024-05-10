import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:rating_summary/rating_summary.dart';

import '../models/tutor.dart';
import '../widgets/card_review.dart';

void showBottom(BuildContext ctx, Tutor tutor) {
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
      builder: (context, scrollController) => ReviewsWidget( tutor: tutor, scrollController: scrollController,),
    ),
  );
}
