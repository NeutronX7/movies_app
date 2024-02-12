import 'package:flutter/material.dart';
import 'package:peliculas/widgets/casting_cards.dart';

import '../models/models.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //TODO cambiar luego por una instancia de movie
    final Movie movie =
        ModalRoute
            .of(context)
            !.settings
            .arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(delegate: SliverChildListDelegate([
            _PosterAndTitle(
              movie: movie
            ),
            _OverView(description: movie.overview),
            _OverView(description: movie.overview),
            _OverView(description: movie.overview),
            CastingCards( movie.id )
            ])
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          color: Colors.black12,
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only( bottom: 10, left: 10, right: 10),
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle({
    super.key,
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme
        .of(context)
        .textTheme;

    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
                //width: 110,
              ),
            ),
          ),

          SizedBox(width: 20),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                    movie.title,
                    style: textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2
                ),
                Text(
                  movie.originalTitle,
                  style: textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2
                ),

                Row(
                  children: [
                    Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(movie.voteAverage.toString(), style: textTheme.caption)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {

  final String description;

  const _OverView({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        description,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

