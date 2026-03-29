import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/data.dart';
import '../../models/models.dart';
import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import 'profiles_filters.dart';
import 'profile_detail_screen.dart';

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

  List<UserProfile> get _filteredUsers {
    return _filters.apply(totalUsers);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const _ProfilesHeader(),
          _ProfilesContent(
            users: _filteredUsers,
            filters: _filters,
            searchController: _searchController,
            onSearchChanged: (value) {
              setState(() {
                _filters = _filters.copyWith(searchQuery: value);
              });
            },
            onProfessionToggled: (profession) {
              setState(() {
                _filters = _filters.toggleProfession(profession);
              });
            },
            onLocationToggled: (location) {
              setState(() {
                _filters = _filters.toggleLocation(location);
              });
            },
            onAgeChanged: (value) {
              setState(() {
                _filters = _filters.copyWith(selectedMaxAge: value);
              });
            },
            onSalaryChanged: (value) {
              setState(() {
                _filters = _filters.copyWith(selectedMinSalary: value);
              });
            },
            onClearFilters: () {
              setState(() {
                _searchController.clear();
                _filters = _filters.clear();
              });
            },
          ),
          AppFooter(isWide: MediaQuery.of(context).size.width > 700),
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
  final ValueChanged<double> onAgeChanged;
  final ValueChanged<double> onSalaryChanged;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 980;
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
              const SizedBox(height: 18),
              Text(
                '${users.length} of ${totalUsers.length} profiles',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 18,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 18),
              _ProfilesGrid(users: users),
            ],
          );

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
              SizedBox(width: 300, child: filtersBar),
              const SizedBox(width: 32),
              Expanded(child: content),
            ],
          );
        },
      ),
    );
  }
}

class _ProfilesHeader extends StatelessWidget {
  const _ProfilesHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 80, 40, 60),
      child: Column(
        children: [
          const SectionEyebrow(text: 'people available'),
          const SizedBox(height: 20),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                text: 'Distinguished ',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 36,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
              ),
              TextSpan(
                text: 'Profiles',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 36,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: AppColors.themeColor,
                ),
              ),
            ]),
          ),
        ],
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
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: GoogleFonts.cormorantGaramond(
          fontSize: 20,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: 'Search profiles by name',
          hintStyle: GoogleFonts.cormorantGaramond(
            fontSize: 20,
            color: AppColors.textMuted,
            fontStyle: FontStyle.italic,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textMuted,
          ),
          filled: true,
          fillColor: AppColors.ivory,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: BorderSide(
              color: AppColors.gold.withValues(alpha: 0.6),
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
      return Text(
        'No profiles match the selected filters.',
        style: GoogleFonts.cormorantGaramond(
          fontSize: 24,
          color: AppColors.textSecondary,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return Column(
      children: users
          .map((u) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _buildCard(context, u),
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
