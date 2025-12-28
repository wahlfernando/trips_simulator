import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trips_simulator/core/shared/theme/app_text_style.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_bloc.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_event.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_list/trip_list_state.dart';
import 'package:trips_simulator/features/trips/presentation/viewmodel/trips_view_model.dart';
import 'package:trips_simulator/features/trips/presentation/widgets/failure_page.dart';
import 'package:trips_simulator/features/trips/presentation/widgets/success_page.dart';
import 'package:trips_simulator/core/enums/trip_list_status.dart';

class TripListPage extends StatelessWidget {
  final TripsViewModel viewModel;

  const TripListPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => viewModel.createTripListBloc()..add(TripListRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Lista de Viagens", style: AppTextStyle.titleCustonBar),
              Text(
                'Gerencie e acompanhe todas as viagens',
                style: AppTextStyle.textTitleCommon,
              ),
            ],
          ),
          elevation: 1,
        ),
        body: BlocBuilder<TripListBloc, TripListState>(
          builder: (context, state) {
            switch (state.status) {
              case TripListStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case TripListStatus.failure:
                return FailurePage(state: state);
              case TripListStatus.empty:
                return const Center(child: Text('Nenhuma viagem encontrada'));
              case TripListStatus.success:
                return SuccessPage(state: state);
              case TripListStatus.initial:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
