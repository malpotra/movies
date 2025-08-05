import 'package:flutter/material.dart';
import 'package:movies_app/view_models/favourites_view_model.dart';
import 'package:movies_app/view_models/home_view_model.dart';
import 'package:provider/provider.dart';


class TrendingPage extends StatefulWidget {
  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  final HomeViewModel _homePageViewModel = HomeViewModel();
  bool _isLoading = false;
  final PageController _pageController = PageController();
  bool get isLoading => _isLoading;
  List<dynamic> trendingMovies = [];
  List<dynamic> moviesInTheater = [];
  int _limit = 20;
  int _trendingPage = 1;

  @override
  void initState() {
    super.initState();
    _loadMorePages(_trendingPage);
    _pageController.addListener(() {

      if (_pageController.page != null && _pageController.page!.round() >= trendingMovies.length -2 
        && !_isLoading) {
        print('fetching more movies');
        _loadMorePages(_trendingPage);
      }
    });
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadMorePages(int page) async {
    try {
      if (_isLoading) return;

      setState(() {
        _isLoading = true;
      });
      List<dynamic> movies = await _homePageViewModel.fetchTrendingMovies("en-US", page);
      setState(() {
        _trendingPage++;
        trendingMovies.addAll(movies);
        _isLoading = false;
      });

    } catch (e ) {
      print('Error occurred when fetching more movies ${e}');
      setState(() {
        _isLoading = false;
      });
    }
  }


 
  @override
  Widget build(BuildContext context) {
    final favoritesViewModel  = Provider.of<FavouritesViewModel>(context);

    return (isLoading) ? CircularProgressIndicator(
      padding: EdgeInsets.fromLTRB(125,200,125,200),
    )
      : LayoutBuilder(builder: (context,contraints) {
        final double screenWidth = contraints.maxWidth;
        final double screenHeight = contraints.maxHeight;
        print(screenHeight*0.4);
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // margin: EdgeInsets.fromLTRB(screenWidth*0.05, screenHeight*0.05, screenWidth*0.05, screenHeight*0.05),
              // padding: EdgeInsets.fromLTRB(0, screenHeight*0.05, 0, screenHeight*0.05),
              height: screenHeight*0.9,
              width: screenWidth*0.9,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _limit, // Number of "pages" or items to swipe
                itemBuilder: (BuildContext context, int index) {
                  var movie = trendingMovies[index];
                  bool isFav = favoritesViewModel.isFavMovie(movie['title'].toString());
                  return Column(
                    children: [
                      Image.network(
                        // title: Text(movie['title']),
                          height: screenHeight*0.8,
                          width: screenWidth*0.9,
                          'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
                      ),
                      SizedBox(
                        height: screenHeight*0.1,
                        width: screenWidth*0.9,
                        child: Row(
                          children: [
                            IconButton(onPressed: ()=>{ 
                              setState(() {
                                if (isFav) {
                                  favoritesViewModel.remove(movie['title'].toString());
                                } else {
                                  favoritesViewModel.add(movie['title'].toString());
                                }
                              })
                            },  
                            icon: Icon(isFav ? Icons.favorite:Icons.favorite_border)),
                            Text ('${movie['title']}')
                          ],
                        ),
                      )
                    ],
                  );
                },
              )  
            ),
            // Container(
            //   margin: EdgeInsets.fromLTRB(screenWidth*0.05, screenHeight*0.05, screenWidth*0.05, screenHeight*0.05),
            //   height: screenHeight*0.4,
            //   width: screenWidth*0.9,
            //   child: Card(
            //     child: Text('Now playing'),
            //   )
            // )
              
          ],
        );
      },
    );

  }
}