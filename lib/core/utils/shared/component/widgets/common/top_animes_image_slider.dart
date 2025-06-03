import 'package:animeworld/core/utils/shared/component/widgets/common/top_anime_picture.dart';
import 'package:animeworld/core/utils/shared/constants/app_colors.dart';
import 'package:animeworld/features/screens/animescreen/anime_details_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../helpers/models/anime.dart';

class TopAnimeImageSlider extends StatefulWidget {
  const TopAnimeImageSlider({super.key, required this.animes});
  final Iterable<Anime> animes;

  @override
  State<TopAnimeImageSlider> createState() => _TopAnimeImageSliderState();
}

class _TopAnimeImageSliderState extends State<TopAnimeImageSlider> {
  int _currentPageIndex = 0;
  final CarouselController _controller =CarouselController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 298,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
       const   Row(children: [Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text('Employee Details',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700),),
          ),],),
          const SizedBox(height: 5,),
          Flexible(
            flex: 10,
            child:CarouselSlider.builder(
              carouselController: _controller,
              itemCount: widget.animes.length,
              itemBuilder: (context, index, realindex) {
                final anime = widget.animes.elementAt(index);
                
            
                return TopAnimePicture(anime: anime);
              },
              options: CarouselOptions(
                enlargeFactor: 0.22,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                aspectRatio: 16 / 9,
                viewportFraction: 0.50,
                autoPlay: true,
                enlargeCenterPage: true,
                initialPage: _currentPageIndex,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          AnimatedSmoothIndicator(
            activeIndex: _currentPageIndex,
            count: widget.animes.length,
            effect: CustomizableEffect(
                activeDotDecoration: DotDecoration(
                    rotationAngle: 180,
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.blueColor,
                    width: 28,
                    height: 8.0),
                dotDecoration: DotDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.blueColor,
                    width: 28,
                    height: 8.0)),
          )
        ],
      ),
    );
  }
}

