import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:map_project_1/models/post_model.dart';

import 'package:map_project_1/screens/simple_map_screen.dart';
import 'package:map_project_1/service/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Google Maps"),
        centerTitle: true,
      ),
      body: 
      Column(children: [
        SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const SimpleMapScreen();
                }));
              },
              child: const Text("Atitus / Passo Fundo Shopping")),
          const SizedBox(
            height: 50,
          ),
        ]),
      ),
      _body(),
      ],)
      
    );
  }

  FutureBuilder _body() {
    final apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
      future: apiService.getPosts(),
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final PostModel posts = snapshot.data!;
          return _posts(posts);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

  Widget _posts(PostModel posts) {
    return Column(
            children: [
              Text(
                posts.value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10,),
              const Text(
                '- Chuck Norris',
              )
            ]
          );
        
        
      }

  }
