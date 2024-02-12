import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> popularMovies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
        super.key,
        required this.popularMovies,
        this.title,
        required this.onNextPage
      });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    scrollController.addListener(() {

      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if( this.widget.title != null)
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                this.widget.title!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),

          SizedBox(height: 5),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.popularMovies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => _MoviePoster( movie: widget.popularMovies[index], heroId: '${ widget.title }-$index-${widget.popularMovies[index].id}' ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;
  final String heroId;

  const _MoviePoster({required this.movie, required this.heroId});

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;

    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(movie.fullPosterImg),
                    width: 130,
                    height: 190,
                    fit: BoxFit.cover),
              ),
            ),
          ),

          SizedBox(height: 5),

          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
