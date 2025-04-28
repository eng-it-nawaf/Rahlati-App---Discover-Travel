import 'package:flutter/material.dart';
import 'package:discounttour/core/widgets/custom_app_bar.dart';
import 'package:discounttour/core/widgets/rating_bar.dart';
import 'package:discounttour/features/tour_details/widgets/features_tile.dart';
import 'package:discounttour/features/tour_details/widgets/details_card.dart';
import 'package:discounttour/features/home/models/tour_model.dart';
import 'package:discounttour/core/constants/app_colors.dart';

class TourDetailsScreen extends StatelessWidget {
  final TourModel tour;

  const TourDetailsScreen({required this.tour});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            flexibleSpace: _buildTourHeader(),
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildFeaturesSection(),
              _buildInfoCardsSection(),
              _buildDescriptionSection(),
              _buildGallerySection(),
              SizedBox(height: 24),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildTourHeader() {
    return Stack(
      children: [
        Image.network(
          tour.imageUrl,
          height: 350,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          height: 350,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.transparent,
                Colors.black.withOpacity(0.1),
              ],
            ),
          ),
        ),
        Positioned(
          top: 48,
          left: 24,
          right: 24,
          child: CustomAppBar(
            showBackButton: true,
            actions: [
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 24,
          left: 24,
          right: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tour.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white70, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Koh Chang Tai, Thailand',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  RatingBar(tour.rating.round()),
                  SizedBox(width: 8),
                  Text(
                    '${tour.rating}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 24),
            FeaturesTile(icon: Icons.wifi, label: 'Free Wi-Fi'),
            SizedBox(width: 16),
            FeaturesTile(icon: Icons.beach_access, label: 'Sand Beach'),
            SizedBox(width: 16),
            FeaturesTile(icon: Icons.card_travel, label: 'First Coastline'),
            SizedBox(width: 16),
            FeaturesTile(icon: Icons.local_dining, label: 'Bar & Restaurant'),
            SizedBox(width: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCardsSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          DetailsCard(
            icon: Icons.book_online,
            title: 'Booking',
            rating: 8.0,
            subtitle: 'Based on 30 reviews',
          ),
          DetailsCard(
            icon: Icons.room_service,
            title: 'Service',
            rating: 9.2,
            subtitle: 'Based on 45 reviews',
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut scelerisque arcu quis eros auctor, eu dapibus urna congue. Nunc nisi diam, semper maximus risus dignissim, semper maximus nibh. Sed finibus ipsum eu erat finibus efficitur.',
        style: TextStyle(
          fontSize: 15,
          height: 1.5,
          color: AppColors.textLight,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildGallerySection() {
    return Container(
      height: 240,
      margin: EdgeInsets.only(top: 24),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 16),
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                tour.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}