import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:life_shared/life_shared.dart';

part 'store_like_model.g.dart';

@JsonSerializable(includeIfNull: false)
final class StoreLikeModel extends BaseFirebaseModel<StoreLikeModel>
    with Equatable {
  const StoreLikeModel({
    this.uid = '',
    this.createdAt,
    this.documentId = '',
  });

  const StoreLikeModel.empty() : this();

  final String uid;

  @JsonKey(
    toJson: FirebaseTimeParse.serverTimestampToJson,
    fromJson: FirebaseTimeParse.datetimeFromTimestamp,
  )
  final DateTime? createdAt;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String documentId;

  @override
  Map<String, dynamic> toJson() => _$StoreLikeModelToJson(this);

  @override
  StoreLikeModel fromJson(Map<String, dynamic> json) =>
      _$StoreLikeModelFromJson(json);

  @override
  StoreLikeModel fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) return const StoreLikeModel.empty();
    return fromJson(data).copyWith(
      uid: snapshot.id,
      documentId: snapshot.id,
    );
  }

  StoreLikeModel copyWith({
    String? uid,
    DateTime? createdAt,
    String? documentId,
  }) {
    return StoreLikeModel(
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      documentId: documentId ?? this.documentId,
    );
  }

  @override
  List<Object?> get props => [uid, createdAt, documentId];
}
