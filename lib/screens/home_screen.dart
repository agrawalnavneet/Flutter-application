import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:findoc_assignment/blocs/home/home_bloc.dart';
import 'package:findoc_assignment/blocs/home/home_event.dart';
import 'package:findoc_assignment/blocs/home/home_state.dart';
import 'package:findoc_assignment/blocs/auth/auth_bloc.dart';
import 'package:findoc_assignment/blocs/auth/auth_event.dart';
import 'package:findoc_assignment/models/image_item.dart';
import 'package:findoc_assignment/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    
    // Load exactly 10 images (0-9)
    context.read<HomeBloc>().add(LoadImages());
  }

  void _logout() {
    context.read<AuthBloc>().add(LogoutRequested());
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gallery',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: _logout,
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial || state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomeFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load images',
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(LoadImages());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Retry',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is HomeSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(RefreshImages());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.images.length,
                itemBuilder: (context, index) {
                  final image = state.images[index];
                  return _buildImageCard(image, context);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildImageCard(ImageItem image, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = screenWidth - 16; // Reduced padding from 32 to 16
    final imageHeight = imageWidth / image.aspectRatio;

    return Container(
      margin: const EdgeInsets.only(bottom: 12), // Reduced from 24 to 12
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8), // Reduced from 12 to 8
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08), // Reduced opacity
            spreadRadius: 0.5, // Reduced from 1
            blurRadius: 4, // Reduced from 8
            offset: const Offset(0, 1), // Reduced from 2 to 1
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)), // Reduced from 12 to 8
            child: Image.network(
              _apiService.getRandomImageUrl(imageWidth.toInt(), imageHeight.toInt(), image.id),
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: imageWidth,
                  height: imageHeight,
                  color: Colors.grey[200],
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: imageWidth,
                  height: imageHeight,
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(
                      Icons.error_outline,
                      size: 32, // Reduced from 48 to 32
                      color: Colors.grey,
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(12), // Reduced from 16 to 12
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Image ${image.id}',
                  style: GoogleFonts.montserrat(
                    fontSize: 16, // Reduced from 18 to 16
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6), // Reduced from 8 to 6
                
                // Description
                Text(
                  'Photographer: Coder',
                  style: GoogleFonts.montserrat(
                    fontSize: 12, // Reduced from 14 to 12
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2), // Reduced from 4 to 2
                Text(
                  'Dimensions: ${image.width} × ${image.height}',
                  style: GoogleFonts.montserrat(
                    fontSize: 10, // Reduced from 12 to 10
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 