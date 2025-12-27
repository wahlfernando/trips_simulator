import '../../../../core/shared/helpers/helpers.dart';
import '../../domain/dto/trip.dto.dart';
import '../../domain/entities/trip.dart';
import '../models/trip_model.dart';

class TripMapper {
  static TripDto fromAPIToDTO(Map<String, dynamic> data) {
    return TripDto(
      id: data['id'] as String,
      lineName: data['lineName'] as String,
      departureTime: data['departureTime'] as String,
      status: data['status'] as String,
    );
  }

  static TripDto fromModelToDTO(TripModel model) {
    return TripDto(
      id: model.id,
      lineName: model.lineName,
      departureTime: model.departureTime,
      status: model.status,
    );
  }

  static Trip fromDTOToEntity(TripDto dto) {
    return Trip(
      id: dto.id,
      lineName: dto.lineName,
      departureTime: DateTime.parse(dto.departureTime),
      status: Helpers.statusFromString(dto.status),
    );
  }

  static TripDto fromEntityToDTO(Trip entity) {
    return TripDto(
      id: entity.id,
      lineName: entity.lineName,
      departureTime: entity.departureTime.toIso8601String(),
      status: Helpers.statusToString(entity.status),
    );
  }

  static Map<String, Object?> fromDTOToDB(TripDto dto) {
    return {
      'id': dto.id,
      'line_name': dto.lineName,
      'departure_time': dto.departureTime,
      'status': dto.status,
    };
  }

  static Trip fromDBToEntity(Map<String, dynamic> data) {
    return Trip(
      id: data['id'] as String,
      lineName: data['line_name'] as String,
      departureTime: DateTime.parse(data['departure_time'] as String),
      status: Helpers.statusFromString(data['status'] as String),
    );
  }

  static List<Trip> fromDTOListToEntityList(List<TripDto> dtos) {
    return dtos.map(fromDTOToEntity).toList();
  }

  static List<Trip> fromModelListToEntityList(List<TripModel> models) {
    return models
        .map((model) => fromDTOToEntity(fromModelToDTO(model)))
        .toList();
  }
}
