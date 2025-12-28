import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/trip_list/trip_list_bloc.dart';
import '../bloc/trip_list/trip_list_event.dart';
import '../bloc/trip_list/trip_list_state.dart';
import '../../../../core/components/filter_chip_button.dart';
import '../../../../core/enums/trip_filter.dart';
import '../../../../core/shared/theme/color_style.dart';

class TripFilterChips extends StatelessWidget {
  const TripFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripListBloc, TripListState>(
      builder: (context, state) {
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Icon(Icons.filter_list, color: AppColors.black80, size: 30),
            FilterChipButton(
              label: 'Todas',
              isSelected: state.selectedFilter == TripFilter.todas,
              onTap: () => context.read<TripListBloc>().add(
                ChangeFilterEvent(TripFilter.todas),
              ),
            ),
            FilterChipButton(
              label: 'Agendadas',
              isSelected: state.selectedFilter == TripFilter.agendadas,
              onTap: () => context.read<TripListBloc>().add(
                ChangeFilterEvent(TripFilter.agendadas),
              ),
            ),
            FilterChipButton(
              label: 'Em Andamento',
              isSelected: state.selectedFilter == TripFilter.emAndamento,
              onTap: () => context.read<TripListBloc>().add(
                ChangeFilterEvent(TripFilter.emAndamento),
              ),
            ),
            FilterChipButton(
              label: 'Finalizadas',
              isSelected: state.selectedFilter == TripFilter.finalizadas,
              onTap: () => context.read<TripListBloc>().add(
                ChangeFilterEvent(TripFilter.finalizadas),
              ),
            ),
          ],
        );
      },
    );
  }
}
