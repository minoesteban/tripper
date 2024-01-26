import 'package:tripper/data/chat/chat_data_source.dart';
import 'package:tripper/data/chat/chat_repository.dart';
import 'package:tripper/data/map/mapper/point_of_interest_dto_mapper.dart';
import 'package:tripper/domain/map/point_of_interest.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._dataSource);

  final ChatDataSource _dataSource;

  PointOfInterestDTOMapper get pointOfInterestDTOMapper => const PointOfInterestDTOMapper();

  @override
  Future<List<PointOfInterest>> fetchPointsOfInterest(double latitude, double longitude) async {
    final dto = await _dataSource.fetchPointsOfInterest(latitude, longitude);
    return dto.points.map(pointOfInterestDTOMapper.to).toList();
  }
}
