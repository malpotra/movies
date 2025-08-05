import 'package:flutter/material.dart';
import 'package:movies_app/view_models/favourites_view_model.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var favoritesViewModelState = Provider.of<FavouritesViewModel>(context);
    return Center(
      child: favoritesViewModelState.favorites.length == 0 ?
        Text('No Favorites Selected Yet..')
      :
        ListView(
      children: [
        for (var fav in favoritesViewModelState.favorites)
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('${fav}'),
          ),
      ],
    ),);
  }
}
