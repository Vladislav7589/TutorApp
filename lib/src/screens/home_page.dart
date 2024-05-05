import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/dio_provider.dart';



class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userId = ref.watch(idUserProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          userId != null ? IconButton(
            splashRadius: 1,
            icon: Icon(Icons.account_circle_outlined, size: 35, color: Colors.green),
            onPressed: () {
              context.goNamed("profile");
            },
          )
          : IconButton(
            splashRadius: 1,
            icon:  Icon(Icons.account_circle_outlined, size: 35, color: Colors.red),
            onPressed: () {
               context.goNamed("login");
            },
          ),
          ElevatedButton(
            onPressed: ()   async {
              final prefs = await SharedPreferences.getInstance();
              final accessToken = prefs.getString('accessToken') ?? '';
              final refreshToken = prefs.getString('refreshToken') ?? '';
              final id = prefs.getInt('id') ;
              print(accessToken);
              print(refreshToken);
              print(id);
              //prefs.remove("id");
              print(userId);
            },
            child: const Text(
              'Вывести',
              style: TextStyle(color: Colors.red),
            ),
          ),
          ],
          toolbarHeight: 50,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Container(
          height: 50,
          child: Image.asset(
            "assets/logo_text.png",
            fit: BoxFit.fitHeight,
          ),
        )
      ),
      body: ref.watch(fetchTutorsInfo).when(
          data: (data) => RefreshIndicator(
            onRefresh: ()  {
              return ref.refresh(fetchTutorsInfo.future);
            },
            child: ListView.separated(
              itemCount: data.tutorList.length,
              itemBuilder: (context, index) {
                final tutor = data.tutorList[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${tutor?.lastName ?? ''} ${tutor?.firstName ?? ''} ${tutor?.middleName ?? ''}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Предметы:',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            for (final subject in tutor?.subjects ?? [])
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Chip(
                                  label: Text(
                                    '${subject.name}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            SizedBox(width: 4),
                            Text(
                              '4.5',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              ' (${tutor?.reviews?.length.toString()} отзывов)',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) {
              return Container();
            },
            ),
          ),
          error: (error, stack) => Text('ошибка: ${error.toString()} ${stack.toString()}'),
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: Color(0xDF290505),
            ),
          )),
    );
  }
}


