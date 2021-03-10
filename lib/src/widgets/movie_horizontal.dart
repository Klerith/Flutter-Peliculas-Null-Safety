import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';


class MovieHorizontal extends StatelessWidget {

  final List<Pelicula>? peliculas;
  final Function siguientePagina;

  MovieHorizontal({ required this.peliculas, required this.siguientePagina });

  final _pageController = new PageController(
    // initialPage: 1,
    viewportFraction: 0.3
  );


  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {

      if ( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ){
        siguientePagina();
      }

    });


    return Container(
      height: _screenSize.height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        itemCount: peliculas!.length,
        itemBuilder: ( context, i ) => _tarjeta(context, peliculas![i] ),
      ),
    );


  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {


    final tarjeta = Container(
        margin: EdgeInsets.only(left: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage( pelicula.getPosterImg() ),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              width: 120,
              child: Text(
                pelicula.title!,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              ),
            )
          ],
        ),
      );

    return GestureDetector(
      child: tarjeta,
      onTap: (){

        Navigator.pushNamed(context, 'detalle', arguments: pelicula );

      },
    );

  }



}
