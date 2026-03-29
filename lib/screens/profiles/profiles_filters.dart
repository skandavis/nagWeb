import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/models.dart';
import '../../theme/app_colors.dart';

class ProfilesFilterState {
  ProfilesFilterState({
    required this.searchQuery,
    required this.selectedProfessions,
    required this.selectedLocations,
    required this.minAvailableAge,
    required this.maxAvailableAge,
    required this.selectedMaxAge,
    required this.minAvailableSalary,
    required this.maxAvailableSalary,
    required this.selectedMinSalary,
    required this.professions,
    required this.locations,
  });

  factory ProfilesFilterState.fromUsers(List<UserProfile> users) {
    final ages = users.map((user) => user.age).toList()..sort();
    final professions = users.map((user) => user.profession).toSet().toList()
      ..sort();
    final locations = users.map((user) => user.location).toSet().toList()
      ..sort();
    final salaries = users.map((user) => _salaryValue(user.salary)).toList()
      ..sort();

    final minAge = ages.isEmpty ? 18 : ages.first;
    final maxAge = ages.isEmpty ? 18 : ages.last;
    final minSalary = salaries.isEmpty ? 0 : salaries.first;
    final maxSalary = salaries.isEmpty ? 0 : salaries.last;

    return ProfilesFilterState(
      searchQuery: '',
      selectedProfessions: const [],
      selectedLocations: const [],
      minAvailableAge: minAge,
      maxAvailableAge: maxAge,
      selectedMaxAge: maxAge.toDouble(),
      minAvailableSalary: minSalary,
      maxAvailableSalary: maxSalary,
      selectedMinSalary: minSalary.toDouble(),
      professions: professions,
      locations: locations,
    );
  }

  final String searchQuery;
  final List<String> selectedProfessions;
  final List<String> selectedLocations;
  final int minAvailableAge;
  final int maxAvailableAge;
  final double selectedMaxAge;
  final int minAvailableSalary;
  final int maxAvailableSalary;
  final double selectedMinSalary;
  final List<String> professions;
  final List<String> locations;

  ProfilesFilterState copyWith({
    String? searchQuery,
    List<String>? selectedProfessions,
    List<String>? selectedLocations,
    double? selectedMaxAge,
    double? selectedMinSalary,
  }) {
    return ProfilesFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedProfessions: selectedProfessions ?? this.selectedProfessions,
      selectedLocations: selectedLocations ?? this.selectedLocations,
      minAvailableAge: minAvailableAge,
      maxAvailableAge: maxAvailableAge,
      selectedMaxAge: selectedMaxAge ?? this.selectedMaxAge,
      minAvailableSalary: minAvailableSalary,
      maxAvailableSalary: maxAvailableSalary,
      selectedMinSalary: selectedMinSalary ?? this.selectedMinSalary,
      professions: professions,
      locations: locations,
    );
  }

  ProfilesFilterState toggleProfession(String profession) {
    final nextSelectedProfessions = List<String>.from(selectedProfessions);

    if (nextSelectedProfessions.contains(profession)) {
      nextSelectedProfessions.remove(profession);
    } else {
      nextSelectedProfessions.add(profession);
    }

    return copyWith(selectedProfessions: nextSelectedProfessions);
  }

  ProfilesFilterState toggleLocation(String location) {
    final nextSelectedLocations = List<String>.from(selectedLocations);

    if (nextSelectedLocations.contains(location)) {
      nextSelectedLocations.remove(location);
    } else {
      nextSelectedLocations.add(location);
    }

    return copyWith(selectedLocations: nextSelectedLocations);
  }

  ProfilesFilterState clear() {
    return ProfilesFilterState(
      searchQuery: '',
      selectedProfessions: const [],
      selectedLocations: const [],
      minAvailableAge: minAvailableAge,
      maxAvailableAge: maxAvailableAge,
      selectedMaxAge: maxAvailableAge.toDouble(),
      minAvailableSalary: minAvailableSalary,
      maxAvailableSalary: maxAvailableSalary,
      selectedMinSalary: minAvailableSalary.toDouble(),
      professions: professions,
      locations: locations,
    );
  }

  List<UserProfile> apply(List<UserProfile> users) {
    final normalizedQuery = searchQuery.trim().toLowerCase();

    return users
        .where(
          (user) =>
              normalizedQuery.isEmpty ||
              user.name.toLowerCase().contains(normalizedQuery),
        )
        .where(
          (user) =>
              selectedProfessions.isEmpty ||
              selectedProfessions.contains(user.profession),
        )
        .where(
          (user) =>
              selectedLocations.isEmpty ||
              selectedLocations.contains(user.location),
        )
        .where((user) => user.age <= selectedMaxAge.round())
        .where((user) => _salaryValue(user.salary) >= selectedMinSalary.round())
        .toList();
  }

  static int _salaryValue(String salary) {
    return int.tryParse(salary.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
  }
}

class ProfilesFilterBar extends StatefulWidget {
  const ProfilesFilterBar({
    super.key,
    required this.filters,
    required this.onProfessionToggled,
    required this.onLocationToggled,
    required this.onAgeChanged,
    required this.onSalaryChanged,
    required this.onClearFilters,
  });

  final ProfilesFilterState filters;
  final ValueChanged<String> onProfessionToggled;
  final ValueChanged<String> onLocationToggled;
  final ValueChanged<double> onAgeChanged;
  final ValueChanged<double> onSalaryChanged;
  final VoidCallback onClearFilters;

  @override
  State<ProfilesFilterBar> createState() => _ProfilesFilterBarState();
}

class _ProfilesFilterBarState extends State<ProfilesFilterBar> {
  bool closeProfile = false;
  bool closeLocation = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.warmWhite,
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Filter Profiles',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              TextButton(
                onPressed: widget.onClearFilters,
                child: Text(
                  'Clear',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 14,
                    color: AppColors.themeColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
              onTap: () {
                setState(() {
                  closeProfile = !closeProfile;
                });
              },
              child: Row(
                children: [
                  const _FilterSectionTitle(title: 'Profession'),
                  const SizedBox(width: 8),
                  Icon(
                    closeProfile ? Icons.expand_more : Icons.expand_less,
                    size: 20,
                    color: AppColors.textMuted,
                  ),
                ],
              )),
          if (!closeProfile)
            ...widget.filters.professions.map(
              (profession) => _CheckboxFilterOption(
                label: profession,
                selected:
                    widget.filters.selectedProfessions.contains(profession),
                onTap: () => widget.onProfessionToggled(profession),
              ),
            ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              setState(() {
                closeLocation = !closeLocation;
              });
            },
            child: Row(
              children: [
                const _FilterSectionTitle(title: 'Location'),
                const SizedBox(width: 8),
                Icon(
                  closeLocation ? Icons.expand_more : Icons.expand_less,
                  size: 20,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
          if (!closeLocation)
            ...widget.filters.locations.map(
              (location) => _CheckboxFilterOption(
                label: location,
                selected: widget.filters.selectedLocations.contains(location),
                onTap: () => widget.onLocationToggled(location),
              ),
            ),
          const SizedBox(height: 12),
          const _FilterSectionTitle(title: 'Maximum Age'),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.filters.minAvailableAge}',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 18,
                  color: AppColors.textMuted,
                ),
              ),
              Text(
                '${widget.filters.selectedMaxAge.round()}',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 18,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.themeColor,
              inactiveTrackColor: AppColors.cream,
              thumbColor: AppColors.gold,
              overlayColor: AppColors.gold.withValues(alpha: 0.1),
              trackHeight: 3,
            ),
            child: Slider(
              min: widget.filters.minAvailableAge.toDouble(),
              max: widget.filters.maxAvailableAge.toDouble(),
              divisions: widget.filters.maxAvailableAge -
                  widget.filters.minAvailableAge,
              value: widget.filters.selectedMaxAge.clamp(
                widget.filters.minAvailableAge.toDouble(),
                widget.filters.maxAvailableAge.toDouble(),
              ),
              label: widget.filters.selectedMaxAge.round().toString(),
              onChanged: widget.onAgeChanged,
            ),
          ),
          Text(
            'Only profiles age ${widget.filters.selectedMaxAge.round()} and below will be shown.',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          const _FilterSectionTitle(title: 'Minimum Salary'),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${widget.filters.minAvailableSalary}',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 18,
                  color: AppColors.textMuted,
                ),
              ),
              Text(
                '\$${widget.filters.selectedMinSalary.round()}',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 18,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.themeColor,
              inactiveTrackColor: AppColors.cream,
              thumbColor: AppColors.gold,
              overlayColor: AppColors.gold.withValues(alpha: 0.1),
              trackHeight: 3,
            ),
            child: Slider(
              min: widget.filters.minAvailableSalary.toDouble(),
              max: widget.filters.maxAvailableSalary.toDouble(),
              divisions: widget.filters.maxAvailableSalary -
                  widget.filters.minAvailableSalary,
              value: widget.filters.selectedMinSalary.clamp(
                widget.filters.minAvailableSalary.toDouble(),
                widget.filters.maxAvailableSalary.toDouble(),
              ),
              label: widget.filters.selectedMinSalary.round().toString(),
              onChanged: widget.onSalaryChanged,
            ),
          ),
          Text(
            'Only profiles with salary ${widget.filters.selectedMinSalary.round()} and above will be shown.',
            style: GoogleFonts.cormorantGaramond(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterSectionTitle extends StatelessWidget {
  const _FilterSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.cormorantGaramond(
        fontSize: 20,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _CheckboxFilterOption extends StatelessWidget {
  const _CheckboxFilterOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_box : Icons.check_box_outline_blank,
              size: 20,
              color: selected ? AppColors.themeColor : AppColors.textMuted,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 16,
                  color: selected
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
