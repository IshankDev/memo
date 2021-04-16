import 'package:memo/domain/models/collection.dart';
import 'package:memo/data/serializers/collection_serializer.dart';
import 'package:memo/data/gateways/document_database_gateway.dart';

abstract class CollectionRepository {
  Future<List<Collection>> getAllCollections();
}

class CollectionRepositoryImpl implements CollectionRepository {
  CollectionRepositoryImpl(this._db);

  final DocumentDatabaseGateway _db;
  final _collectionSerializer = CollectionSerializer();
  final _collectionStore = 'collections';

  @override
  Future<List<Collection>> getAllCollections() async {
    final rawCollections = await _db.getAll(store: _collectionStore);
    return rawCollections.map(_collectionSerializer.from).toList();
  }
}