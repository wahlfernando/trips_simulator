import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trips_simulator/core/shared/theme/app_text_style.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_detail/trip_detail_bloc.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_detail/trip_detail_event.dart';
import 'package:trips_simulator/features/trips/presentation/bloc/trip_detail/trip_detail_state.dart';
import 'package:trips_simulator/features/trips/presentation/viewmodel/trips_view_model.dart';
import 'package:trips_simulator/features/trips/presentation/widgets/line_title_info.dart';

import '../../../../core/shared/theme/color_style.dart';

class TripDetailPage extends StatelessWidget {
  final String tripId;
  final TripsViewModel viewModel;

  const TripDetailPage({
    super.key,
    required this.tripId,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          viewModel.createTripDetailBloc()..add(TripDetailStarted(tripId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Detalhe da Viagem",
            style: AppTextStyle.titleCustonBar,
            textAlign: TextAlign.start,
          ),
          elevation: 1,
        ),
        body: BlocBuilder<TripDetailBloc, TripDetailState>(
          builder: (context, state) {
            if (state.status == TripDetailStatus.loading ||
                state.status == TripDetailStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == TripDetailStatus.failure) {
              return Center(
                child: Text(
                  state.errorMessage ?? 'Erro ao carregar os detalhes',
                ),
              );
            }
            final trip = state.trip!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: .center,
                    spacing: 8,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColors.black50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.car_repair, color: AppColors.white),
                      ),
                      Text(trip.lineName, style: AppTextStyle.textDetailCard),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text("Detalhes da viagem", style: AppTextStyle.text),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(16),
                      child: Column(
                        spacing: 12,
                        crossAxisAlignment: .start,
                        children: [
                          LineTitleInfo(
                            icon: Icons.auto_awesome_outlined,
                            textTitle: "ID da Viagem",
                            textInfo: trip.id,
                          ),
                          LineTitleInfo(
                            icon: Icons.electric_car_outlined,
                            textTitle: "Nome da Linha",
                            textInfo: trip.lineName,
                          ),
                          LineTitleInfo(
                            icon: Icons.share_arrival_time_outlined,
                            textTitle: "Horario Saida",
                            textInfo: trip.formattedDepartureTime,
                          ),
                          LineTitleInfo(
                            icon: Icons.star_border_rounded,
                            textTitle: "Status",
                            status: trip.status,
                            isStatus: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
