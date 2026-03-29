import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/data.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import 'profile_detail_screen.dart';
import 'profiles_filters.dart';

class ProfilesScreen extends StatefulWidget {
  const ProfilesScreen({super.key});

  @override
  State<ProfilesScreen> createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends State<ProfilesScreen> {
  final TextEditingController _searchController = TextEditingController();
  late ProfilesFilterState _filters;

  @override
  void initState() {
    super.initState();
    _filters = ProfilesFilterState.fromUsers(totalUsers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<UserProfile> get _filteredUsers => _filters.apply(totalUsers);

  void _updateFilters(ProfilesFilterState Function(ProfilesFilterState filters) update) {
    setState(() {
      _filters = update(_filters);
    });
  }

  void _onSearchChanged(String value) {
    _updateFilters((filters) => filters.copyWith(searchQuery: value));
  }

  void _onProfessionToggled(String profession) {
    _updateFilters((filters) => filters.toggleProfession(profession));
  }

  void _onLocationToggled(String location) {
    _updateFilters((filters) => filters.toggleLocation(location));
  }

  void _onAgeChanged(RangeValues values) {
    _updateFilters(
      (filters) => filters.copyWith(
        selectedMinAge: values.start,
        selectedMaxAge: values.end,
      ),
    );
  }

  void _onSalaryChanged(RangeValues values) {
    _updateFilters(
      (filters) => filters.copyWith(
        selectedMinSalary: values.start,
        selectedMaxSalary: values.end,
      ),
    );
  }

  void _clearFilters() {
    _searchController.clear();
    _updateFilters((filters) => filters.clear());
  }

  @override
  Widget build(BuildContext context) {
    final isWideFooter = MediaQuery.of(context).size.width > 700;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF9F3E8),
            AppColors.warmWhite,
            Color(0xFFF3EBDD),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const _ProfilesHero(),
            _ProfilesContent(
              users: _filteredUsers,
              filters: _filters,
              searchController: _searchController,
              onSearchChanged: _onSearchChanged,
              onProfessionToggled: _onProfessionToggled,
              onLocationToggled: _onLocationToggled,
              onAgeChanged: _onAgeChanged,
              onSalaryChanged: _onSalaryChanged,
              onClearFilters: _clearFilters,
            ),
            AppFooter(isWide: isWideFooter),
          ],
        ),
      ),
    );
  }
}

class _ProfilesHero extends StatelessWidget {
  const _ProfilesHero();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 40),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(
            'Distinguished Profiles',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              fontSize: 42,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              height: 1.05,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfilesContent extends StatelessWidget {
  const _ProfilesContent({
    required this.users,
    required this.filters,
    required this.searchController,
    required this.onSearchChanged,
    required this.onProfessionToggled,
    required this.onLocationToggled,
    required this.onAgeChanged,
    required this.onSalaryChanged,
    required this.onClearFilters,
  });

  final List<UserProfile> users;
  final ProfilesFilterState filters;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onProfessionToggled;
  final ValueChanged<String> onLocationToggled;
  final ValueChanged<RangeValues> onAgeChanged;
  final ValueChanged<RangeValues> onSalaryChanged;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    final filtersBar = ProfilesFilterBar(
      filters: filters,
      onProfessionToggled: onProfessionToggled,
      onLocationToggled: onLocationToggled,
      onAgeChanged: onAgeChanged,
      onSalaryChanged: onSalaryChanged,
      onClearFilters: onClearFilters,
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProfilesSearchBar(
          controller: searchController,
          onChanged: onSearchChanged,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const Spacer(),
            Text(
              '${users.length} of ${totalUsers.length} profiles',
              style: GoogleFonts.cinzel(
                fontSize: 10,
                letterSpacing: 2.8,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _ProfilesGrid(users: users),
      ],
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 980;

          if (!isWide) {
            return Column(
              children: [
                filtersBar,
                const SizedBox(height: 24),
                content,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 320,
                child: _ScrollableFiltersPane(child: filtersBar),
              ),
              const SizedBox(width: 28),
              Expanded(child: content),
            ],
          );
        },
      ),
    );
  }
}

class _ScrollableFiltersPane extends StatelessWidget {
  const _ScrollableFiltersPane({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final viewportHeight = mediaQuery.size.height;
    final safeHeight = viewportHeight - mediaQuery.padding.vertical;
    final paneHeight = (safeHeight - 32).clamp(420.0, 760.0);

    return SizedBox(
      height: paneHeight,
      child: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}

class _ProfilesSearchBar extends StatelessWidget {
  const _ProfilesSearchBar({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return purplePanel(
      padding: const EdgeInsets.all(18),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: GoogleFonts.cormorantGaramond(
          fontSize: 22,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: 'Search profiles by name',
          hintStyle: GoogleFonts.cormorantGaramond(
            fontSize: 22,
            color: AppColors.textMuted,
            fontStyle: FontStyle.italic,
          ),
          prefixIcon: const Icon(Icons.search, color: AppColors.goldDeep),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.62),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            borderSide: BorderSide(
              color: AppColors.border.withValues(alpha: 0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            borderSide: BorderSide(
              color: AppColors.gold.withValues(alpha: 0.85),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfilesGrid extends StatelessWidget {
  const _ProfilesGrid({required this.users});

  final List<UserProfile> users;

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return purplePanel(
        padding: const EdgeInsets.all(28),
        child: Center(
          child: Text(
            'No profiles match the selected filters.',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 22,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return Column(
      children: users
          .map((user) => Padding(
                padding: const EdgeInsets.only(bottom: 22),
                child: _buildCard(context, user),
              ))
          .toList(),
    );
  }
}

Widget _buildCard(BuildContext context, UserProfile user) {
  return ProfileCard(
    user: user,
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ProfileDetailScreen(user: user)),
    ),
  );
}
