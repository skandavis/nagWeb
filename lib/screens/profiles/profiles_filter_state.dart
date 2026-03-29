import '../../models/models.dart';

class ProfilesFilterState {
  ProfilesFilterState({
    required this.searchQuery,
    required this.selectedProfessions,
    required this.selectedLocations,
    required this.minAvailableAge,
    required this.maxAvailableAge,
    required this.selectedMinAge,
    required this.selectedMaxAge,
    required this.minAvailableSalary,
    required this.maxAvailableSalary,
    required this.selectedMinSalary,
    required this.selectedMaxSalary,
    required this.professions,
    required this.locations,
  });

  factory ProfilesFilterState.fromUsers(List<UserProfile> users) {
    final ages = users.map((user) => user.age).toList()..sort();
    final professions = users.map((user) => user.profession).toSet().toList()
      ..sort();
    final locations = users.map((user) => user.location).toSet().toList()
      ..sort();
    final salaries = users.map((user) => user.salary).toList()
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
      selectedMinAge: minAge.toDouble(),
      selectedMaxAge: maxAge.toDouble(),
      minAvailableSalary: minSalary,
      maxAvailableSalary: maxSalary,
      selectedMinSalary: minSalary.toDouble(),
      selectedMaxSalary: maxSalary.toDouble(),
      professions: professions,
      locations: locations,
    );
  }

  final String searchQuery;
  final List<String> selectedProfessions;
  final List<String> selectedLocations;
  final int minAvailableAge;
  final int maxAvailableAge;
  final double selectedMinAge;
  final double selectedMaxAge;
  final int minAvailableSalary;
  final int maxAvailableSalary;
  final double selectedMinSalary;
  final double selectedMaxSalary;
  final List<String> professions;
  final List<String> locations;

  ProfilesFilterState copyWith({
    String? searchQuery,
    List<String>? selectedProfessions,
    List<String>? selectedLocations,
    double? selectedMinAge,
    double? selectedMaxAge,
    double? selectedMinSalary,
    double? selectedMaxSalary,
  }) {
    return ProfilesFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedProfessions: selectedProfessions ?? this.selectedProfessions,
      selectedLocations: selectedLocations ?? this.selectedLocations,
      minAvailableAge: minAvailableAge,
      maxAvailableAge: maxAvailableAge,
      selectedMinAge: selectedMinAge ?? this.selectedMinAge,
      selectedMaxAge: selectedMaxAge ?? this.selectedMaxAge,
      minAvailableSalary: minAvailableSalary,
      maxAvailableSalary: maxAvailableSalary,
      selectedMinSalary: selectedMinSalary ?? this.selectedMinSalary,
      selectedMaxSalary: selectedMaxSalary ?? this.selectedMaxSalary,
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
      selectedMinAge: minAvailableAge.toDouble(),
      selectedMaxAge: maxAvailableAge.toDouble(),
      minAvailableSalary: minAvailableSalary,
      maxAvailableSalary: maxAvailableSalary,
      selectedMinSalary: minAvailableSalary.toDouble(),
      selectedMaxSalary: maxAvailableSalary.toDouble(),
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
        .where((user) => user.age >= selectedMinAge.round())
        .where((user) => user.age <= selectedMaxAge.round())
        .where((user) => user.salary >= selectedMinSalary.round())
        .where((user) => user.salary <= selectedMaxSalary.round())
        .toList();
  }
}
