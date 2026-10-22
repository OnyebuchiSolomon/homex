
Future<Map<String, String>> rawDataHeader([String? token]) async {

    return {
      'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) '
          'AppleWebKit/537.36 (KHTML, like Gecko) '
          'Chrome/117.0.0.0 Safari/537.36',
      'Accept': 'application/json',
      'Accept-Language': 'en-US,en;q=0.9',
      'Connection': 'keep-alive',
      'Content-Type': 'application/json',
      /* if (accessToken != null) */'Authorization': token!,
    };
  }



Future<Map<String, String>> formDataHeader([String? token]) async {
  // final accessToken = token ??
  //     injector.get<AccountViewModel>().token ??
    //  await StorageHandler.getAccessToken();
  return {
    'Content-Type': 'multipart/form-data',
    'Accept': 'application/json',
    /* if (accessToken != null) */'Authorization': token!,
  };
}
