import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final Enum currentFilter;
  final List<Enum> filters;
  final Function(Enum) onFilterSelected;

  const FilterBar({
    super.key,
    required this.currentFilter,
    required this.filters,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: filters
            .map(
              (f) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(f.name[0].toUpperCase() + f.name.substring(1)),
                  selected: currentFilter == f,
                  onSelected: (_) => onFilterSelected(f),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
