import 'package:animeworld/models/anime_category.dart';
import 'package:animeworld/views/anime_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _animeTabs = animeCategories
      .map((animecategory) => Tab(
            text: animecategory.title,
          ))
      .toList();
      final _screen =animeCategories.map((animeCategory) => AnimeGridView(category:animeCategory)).toList();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
          appBar: AppBar(
        title: Text('Anime Categories'),
        bottom: TabBar(
          tabs: _animeTabs,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorWeight: 4,
          indicatorColor: Colors.blue,
          labelColor: Colors.red,
        ),
      ),
      body: TabBarView(children: _screen,),
      ),
      
    );
  }
}
