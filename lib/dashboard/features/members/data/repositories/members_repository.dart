import '../data_sources/members_remote_data_source.dart';
import '../models/member_model.dart';

class MembersRepository {
  final MembersRemoteDataSource _remoteDataSource;

  MembersRepository({MembersRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? MembersRemoteDataSource();

  Stream<List<MemberModel>> getMembersStream() {
    return _remoteDataSource.getMembersStream();
  }
}
