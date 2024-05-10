import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/subject.dart';
import '../models/tutor.dart';
import '../providers/dio_provider.dart';
import '../widgets/error_widget.dart';
import 'buttom_sheet.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(idUserProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            splashRadius: 1,
            icon: Icon(
              Icons.account_circle_outlined,
              size: 35,
              color: userId != null ? Colors.green : Colors.red,
            ),
            onPressed: () {
              context.goNamed(userId != null ? "profile" : "login");
            },
          ),
          //_buildFetchButton(ref),
        ],
        toolbarHeight: 50,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Container(
          height: 50,
          child: Image.asset(
            "assets/logo_text.png",
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
      body: RefreshIndicator(
          onRefresh: () {
            return ref.refresh(fetchTutorsInfo.future);
          },
          child:_buildTutorsListView(ref)),
    );
  }

  Widget _buildFetchButton(WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        final accessToken = prefs.getString('accessToken') ?? '';
        final refreshToken = prefs.getString('refreshToken') ?? '';
        final id = prefs.getInt('id');
        print(accessToken);
        print(refreshToken);
        print(id);
        // prefs.remove("id");
        print(ref.watch(idUserProvider));
      },
      child: const Text(
        'Вывести',
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildTutorsListView(WidgetRef ref) {
    return ref.watch(fetchTutorsInfo).when(
      data: (data) => ListView.separated(
        itemCount: data.tutorList.length,
        itemBuilder: (context, index) {
          final tutor = data.tutorList[index];
          return _buildTutorCard(tutor!, context);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8);
        },
      ),
      error: (error, stack) => ErrorScreen(errorMessage: error),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Color(0xDF290505),
        ),
      ),
    );
  }

  Widget _buildTutorCard(Tutor tutor, BuildContext context) {
    int lengthReviews = tutor.reviews?.length ?? 0;
    double? averageRating;
    if(lengthReviews != 0) {
      averageRating =
          tutor.reviews!.map((review) => review.rating!).reduce((a, b) => a + b) / lengthReviews;
    } else {
      averageRating = 0;
    }
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                tutor.image!= null?CachedNetworkImage(
                  imageUrl: 'http://0.0.0.0:8000${tutor.image}',
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => const Icon(Icons.person_2_sharp,size: 30,),
                  errorWidget: (context, url, error) => const Icon(Icons.person_2_sharp,size: 30,),
                )
                    : const Icon(Icons.person_2_sharp,size: 30,),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${tutor.lastName ?? ''} ${tutor.firstName ?? ''} ${tutor.middleName ?? ''}',
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildSubjectChips(tutor.subjects),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                if((tutor.reviews?.length??0)>0) showBottom(context, tutor);
              },
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    averageRating.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    ' (${tutor.reviews?.length.toString()})',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectChips(List<Subject>? subjects) {
    return Row(
      children: [
        if (subjects != null)
          ...subjects.map((subject) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(
                  label: Text(
                    '${subject.name}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              )),
      ],
    );
  }
}
