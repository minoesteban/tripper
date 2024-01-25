import 'package:tripper/data/chat/chat_data_source.dart';
import 'package:tripper/data/chat/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._dataSource);

  final ChatDataSource _dataSource;

  @override
  Future<String> fetchPointsOfInterest(double latitude, double longitude) async {
    return await _dataSource.fetchPointsOfInterest(latitude, longitude);
  }
}
