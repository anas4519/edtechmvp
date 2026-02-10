import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tuf_app_mvp/features/lld/lld_topics_screen.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/course.dart';
import '../dsa/dsa_sheet_screen.dart';
import 'bloc/home_cubit.dart';
import 'widgets/featured_carousel.dart';
import 'widgets/course_card.dart';
import 'widgets/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateToCourse(BuildContext context, Course course) {
    if (course.id == 'dsa') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const DsaSheetScreen()));
    } else if (course.id == 'lld') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const LldTopicsScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: theme.scaffoldBackgroundColor,
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/tuf_logo.png',
                    height: 48,
                    width: 48,
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.menu_rounded),
                  onPressed: () {},
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.only(top: 20, bottom: 16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkSurface
                        : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? AppColors.darkBorder
                          : AppColors.lightBorder,
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Featured',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      FeaturedCarousel(
                        courses: state.featuredCourses,
                        onCourseTap: (course) =>
                            _navigateToCourse(context, course),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // DSA Section
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const SectionHeader(title: 'Data Structures And Algorithms'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.dsaCourses.length,
                      itemBuilder: (context, index) {
                        final course = state.dsaCourses[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: CourseCard(
                            course: course,
                            onTap: () => _navigateToCourse(context, course),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Design Section
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const SectionHeader(title: 'Design'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: state.designCourses.length,
                      itemBuilder: (context, index) {
                        final course = state.designCourses[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: CourseCard(
                            course: course,
                            onTap: () => _navigateToCourse(context, course),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Bottom spacing
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        );
      },
    );
  }
}
