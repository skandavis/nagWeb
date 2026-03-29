import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../../widgets/widgets.dart';
import 'profiles_filter_state.dart';

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
  final ValueChanged<RangeValues> onAgeChanged;
  final ValueChanged<RangeValues> onSalaryChanged;
  final VoidCallback onClearFilters;

  @override
  State<ProfilesFilterBar> createState() => _ProfilesFilterBarState();
}

class _ProfilesFilterBarState extends State<ProfilesFilterBar> {
  bool closeProfile = false;
  bool closeLocation = false;

  @override
  Widget build(BuildContext context) {
    return purplePanel(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Filter Profiles',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 28,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              TextButton(
                onPressed: widget.onClearFilters,
                child: Text(
                  'Clear',
                  style: GoogleFonts.cinzel(
                    fontSize: 9,
                    color: AppColors.imperialPurple,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _FilterExpandableHeader(
            title: 'Profession',
            isCollapsed: closeProfile,
            onTap: () => setState(() => closeProfile = !closeProfile),
          ),
          if (!closeProfile)
            ...widget.filters.professions.map(
              (profession) => _CheckboxFilterOption(
                label: profession,
                selected:
                    widget.filters.selectedProfessions.contains(profession),
                onTap: () => widget.onProfessionToggled(profession),
              ),
            ),
          const SizedBox(height: 18),
          _FilterExpandableHeader(
            title: 'Location',
            isCollapsed: closeLocation,
            onTap: () => setState(() => closeLocation = !closeLocation),
          ),
          if (!closeLocation)
            ...widget.filters.locations.map(
              (location) => _CheckboxFilterOption(
                label: location,
                selected: widget.filters.selectedLocations.contains(location),
                onTap: () => widget.onLocationToggled(location),
              ),
            ),
          const SizedBox(height: 20),
          _FilterSliderCard(
            title: 'Age Range',
            minLabel: '${widget.filters.selectedMinAge.round()}',
            maxLabel: '${widget.filters.selectedMaxAge.round()}',
            description:
                'Only profiles age ${widget.filters.selectedMinAge.round()} to ${widget.filters.selectedMaxAge.round()} will be shown.',
            slider: SliderTheme(
              data: _purpleSliderTheme(context),
              child: RangeSlider(
                min: widget.filters.minAvailableAge.toDouble(),
                max: widget.filters.maxAvailableAge.toDouble(),
                divisions: widget.filters.maxAvailableAge -
                    widget.filters.minAvailableAge,
                values: RangeValues(
                  widget.filters.selectedMinAge.clamp(
                    widget.filters.minAvailableAge.toDouble(),
                    widget.filters.maxAvailableAge.toDouble(),
                  ),
                  widget.filters.selectedMaxAge.clamp(
                    widget.filters.minAvailableAge.toDouble(),
                    widget.filters.maxAvailableAge.toDouble(),
                  ),
                ),
                labels: RangeLabels(
                  widget.filters.selectedMinAge.round().toString(),
                  widget.filters.selectedMaxAge.round().toString(),
                ),
                onChanged: widget.onAgeChanged,
              ),
            ),
          ),
          const SizedBox(height: 18),
          _FilterSliderCard(
            title: 'Salary Range',
            minLabel: '\$${widget.filters.selectedMinSalary.round()}',
            maxLabel: '\$${widget.filters.selectedMaxSalary.round()}',
            description:
                'Only profiles with salary \$${widget.filters.selectedMinSalary.round()} to \$${widget.filters.selectedMaxSalary.round()} will be shown.',
            slider: SliderTheme(
              data: _purpleSliderTheme(context),
              child: RangeSlider(
                min: widget.filters.minAvailableSalary.toDouble(),
                max: widget.filters.maxAvailableSalary.toDouble(),
                divisions: widget.filters.maxAvailableSalary -
                    widget.filters.minAvailableSalary,
                values: RangeValues(
                  widget.filters.selectedMinSalary.clamp(
                    widget.filters.minAvailableSalary.toDouble(),
                    widget.filters.maxAvailableSalary.toDouble(),
                  ),
                  widget.filters.selectedMaxSalary.clamp(
                    widget.filters.minAvailableSalary.toDouble(),
                    widget.filters.maxAvailableSalary.toDouble(),
                  ),
                ),
                labels: RangeLabels(
                  widget.filters.selectedMinSalary.round().toString(),
                  widget.filters.selectedMaxSalary.round().toString(),
                ),
                onChanged: widget.onSalaryChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliderThemeData _purpleSliderTheme(BuildContext context) {
    return SliderTheme.of(context).copyWith(
      activeTrackColor: AppColors.imperialPurple,
      inactiveTrackColor: AppColors.cream,
      thumbColor: AppColors.gold,
      overlayColor: AppColors.gold.withValues(alpha: 0.14),
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
    );
  }
}

class _FilterExpandableHeader extends StatelessWidget {
  const _FilterExpandableHeader({
    required this.title,
    required this.isCollapsed,
    required this.onTap,
  });

  final String title;
  final bool isCollapsed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(child: _FilterSectionTitle(title: title)),
            Icon(
              isCollapsed ? Icons.expand_more : Icons.expand_less,
              size: 20,
              color: AppColors.goldDeep,
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterSliderCard extends StatelessWidget {
  const _FilterSliderCard({
    required this.title,
    required this.minLabel,
    required this.maxLabel,
    required this.description,
    required this.slider,
  });

  final String title;
  final String minLabel;
  final String maxLabel;
  final String description;
  final Widget slider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FilterSectionTitle(title: title),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SliderValueChip(label: minLabel),
              _SliderValueChip(label: maxLabel),
            ],
          ),
          slider,
          Text(
            description,
            style: GoogleFonts.cormorantGaramond(
              fontSize: 17,
              color: AppColors.textSecondary,
              height: 1.35,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SliderValueChip extends StatelessWidget {
  const _SliderValueChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.cormorantGaramond(
        fontSize: 18,
        color: AppColors.textMuted,
        fontWeight: FontWeight.w700,
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
      style: GoogleFonts.playfairDisplay(
        fontSize: 22,
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.imperialPurple.withValues(alpha: 0.1)
              : Colors.white.withValues(alpha: 0.42),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              size: 18,
              color: selected ? AppColors.imperialPurple : AppColors.textMuted,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 18,
                  color: selected
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
