import 'package:tut_app/data/network/error_handler.dart';
import 'package:tut_app/data/response/responses.dart';

String cacheHomeKey = 'CACHE HOME KEY';
String cacheStoresDetailsKey = 'CACHE STORES DETAILS KEY';

abstract class LocalDataSource {
  Future<HomeResponse> homeResponse();
  Future<StoresDetailsResponse> storeDetailsResponse();

  Future<void> saveHomeToCache(HomeResponse homeResponse);
  Future<void> saveStoreDetailsToCache(StoresDetailsResponse storesDetailsResponse);

  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImpl extends LocalDataSource {
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> homeResponse() async{
    CachedItem? cachedItem = cacheMap[cacheHomeKey];

    if(cachedItem!=null && cachedItem.isValid(60000)){
      print('cache');

      return cachedItem.data;
    }
    else{
      print('not cache');
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }
  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    print(homeResponse);
    cacheMap[cacheHomeKey] = CachedItem(data: homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<StoresDetailsResponse> storeDetailsResponse() async {
    CachedItem? cachedItem = cacheMap[cacheStoresDetailsKey];

    if(cachedItem!=null && cachedItem.isValid(60000)){
      print('cache2');

      return cachedItem.data;
    }
    else{
      print('not cache');
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveStoreDetailsToCache(StoresDetailsResponse storesDetailsResponse) async{
    cacheMap[cacheStoresDetailsKey]=CachedItem(data:  storesDetailsResponse);
  }


}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem({required this.data});
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    int checkTime = DateTime.now().millisecondsSinceEpoch;
    bool isValid = checkTime - cacheTime < expirationTime;
    return isValid;
  }
}
