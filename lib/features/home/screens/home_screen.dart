import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:discounttour/core/constants/app_colors.dart';
import 'package:discounttour/features/home/models/country_model.dart';
import 'package:discounttour/features/home/models/tour_model.dart';
import 'package:discounttour/features/home/widgets/country_card.dart';
import 'package:discounttour/features/home/widgets/tour_card.dart';
import 'package:discounttour/routes/route_names.dart';
import 'package:discounttour/core/providers/app_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    if (appProvider.isLoading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            _buildAppBar(),
            _buildHeroSlider(appProvider.featuredTours),
          ];
        },
        body: _buildBody(context, appProvider),
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 0,
      floating: true,
      pinned: true,
      snap: false,
      elevation: 4,
      backgroundColor: AppColors.surface,
      title: Text(
        'Rahlati',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: AppColors.textPrimary),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.favorite_border, color: AppColors.textPrimary),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.notifications_none, color: AppColors.textPrimary),
          onPressed: () {},
        ),
      ],
    );
  }

  SliverToBoxAdapter _buildHeroSlider(List<TourModel> featuredTours) {
    return SliverToBoxAdapter(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 220,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 0.9,
          autoPlayInterval: Duration(seconds: 5),
        ),
        items: featuredTours.map((tour) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                  BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                  )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        tour.imageUrl,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        bottom: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tour.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.white, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  tour.location,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AppProvider provider) {
    return RefreshIndicator(
      onRefresh: () => provider.loadData(),
      color: AppColors.primary,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            sliver: SliverToBoxAdapter(
              child: _buildSearchBar(),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            sliver: SliverToBoxAdapter(
              child: _buildSectionHeader(
                title: 'Popular Destinations',
                onSeeAll: () {},
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 16),
            sliver: _buildCountriesList(provider.countries, provider.tours),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            sliver: SliverToBoxAdapter(
              child: _buildSectionHeader(
                title: 'Recommended Tours',
                onSeeAll: () {},
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: _buildToursList(provider.tours),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Where do you want to go?',
          hintStyle: TextStyle(color: AppColors.textSecondary),
          prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required String title, VoidCallback? onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: Text(
              'See all',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCountriesList(List<CountryModel> countries, List<TourModel> tours) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 180,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: countries.length,
          separatorBuilder: (_, __) => SizedBox(width: 12),
          itemBuilder: (context, index) {
            return CountryCard(
              country: countries[index],
              onTap: () => _navigateToTourDetails(context, tours[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildToursList(List<TourModel> tours) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: TourCard(
              tour: tours[index],
              onTap: () => _navigateToTourDetails(context, tours[index]),
              onBook: () => _navigateToBooking(context, tours[index]),
            ),
          );
        },
        childCount: tours.length,
      ),
    );
  }

  void _navigateToTourDetails(BuildContext context, TourModel tour) {
    Navigator.pushNamed(context, RouteNames.tourDetails, arguments: tour);
  }

  void _navigateToBooking(BuildContext context, TourModel tour) {
    Navigator.pushNamed(context, RouteNames.booking, arguments: tour);
  }
}