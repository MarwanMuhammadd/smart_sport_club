import '../data/models/member_model.dart';

abstract class MembersState {}

class MembersInitial extends MembersState {}

class MembersLoading extends MembersState {}

class MembersLoaded extends MembersState {
  final List<MemberModel> members;
  final List<MemberModel> filteredMembers;

  MembersLoaded({
    required this.members,
    required this.filteredMembers,
  });
}

class MembersError extends MembersState {
  final String message;

  MembersError(this.message);
}
