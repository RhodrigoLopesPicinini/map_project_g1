import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:map_project_1/models/post_model.dart';
import 'package:map_project_1/screens/google_offices_map.dart';

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
              child: const Text("Passo Fundo/Atitus")),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const GoogleOfficesMap();
                }));
              },
            child: const Text("Escritórios da Google")
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
          final List<PostModel> posts = snapshot.data!;
          return _posts(posts);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

  Widget _posts(List<PostModel> posts) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context,index) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(10),
           border: Border.all(color: Colors.black38,width: 1),
          ),
          child: 
          SingleChildScrollView(child: Column(
            children: [
              Text(
                posts[index].title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                posts[index].body,
              )
            ]
          ),
          )
        );
      },
    );
  }
}
