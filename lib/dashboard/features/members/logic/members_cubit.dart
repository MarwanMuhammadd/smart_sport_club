import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/member_model.dart';
import '../data/repositories/members_repository.dart';
import 'members_state.dart';

class MembersCubit extends Cubit<MembersState> {
  final MembersRepository _repository;
  StreamSubscription<List<MemberModel>>? _membersSubscription;
  List<MemberModel> _allMembers = [];

  MembersCubit({MembersRepository? repository})
      : _repository = repository ?? MembersRepository(),
        super(MembersInitial());

  void subscribeToMembers() {
    emit(MembersLoading());
    _membersSubscription?.cancel();

    _membersSubscription = _repository.getMembersStream().listen(
      (members) {
        _allMembers = members;
        emit(MembersLoaded(
          members: _allMembers,
          filteredMembers: _allMembers,
        ));
      },
      onError: (error) {
        emit(MembersError(error.toString()));
      },
    );
  }

  void searchMembers(String query) {
    if (state is MembersLoaded) {
      if (query.isEmpty) {
        emit(MembersLoaded(
          members: _allMembers,
          filteredMembers: _allMembers,
        ));
        return;
      }

      final lowerQuery = query.toLowerCase();
      final filteredList = _allMembers.where((member) {
        return member.name.toLowerCase().contains(lowerQuery) ||
               member.email.toLowerCase().contains(lowerQuery);
      }).toList();

      emit(MembersLoaded(
        members: _allMembers,
        filteredMembers: filteredList,
      ));
    }
  }

  @override
  Future<void> close() {
    _membersSubscription?.cancel();
    return super.close();
  }
}
