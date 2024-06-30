/*import 'package:dio/dio.dart';

const BASEURL = 'https://beta.mrdekk.ru/todo';

void fetchData(String token) async {
  Dio dio = Dio();

  dio.interceptors.add(InterceptorsWrapper(
    onError: (DioError e, handler) {
      if (e.error is DioErrorType) {
        handler.next(e);
      } else {
        if (e.response != null && e.response!.statusCode == 401) {
          // handle unauthorized error
        }
        // handle other errors
        throw e;
      }
    },
  ));

  dio.onHttpClientCreate = (client) {
    client.badCertificateCallback = (cert, host, port) => true;
  };

  try {
    Response response = await dio.get('$BASEURL', options: Options(headers: {'Authorization': 'Bearer $token'}));
    print('Data received: ${response.data}');
  } catch (e) {
    print('Failed to fetch data. Error: $e');
  }
}



  Future<dynamic> updateElementOnList(String id, dynamic data, int revision) async {
    final response = await http.put(
      Uri.parse('$BASEURL/list/$id'),
      headers: {'X-Last-Known-Revision': revision.toString()},
      body: jsonEncode(data)
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['element'];
    } else {
      throw Exception('Failed to update element on list');
    }
  }

  Future<dynamic> deleteElementFromList(String id) async {
    final response = await http.delete(Uri.parse('$BASEURL/list/$id'));
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['element'];
    } else {
      throw Exception('Failed to delete element from list');
    }
  }


  Future<List<dynamic>> getListFromServer() async {
    final response = await http.get(Uri.parse('$BASEURL/list'));
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['list'];
    } else {
      throw Exception('Failed to load list');
    }
  }

  Future<List<dynamic>> updateListOnServer(int revision) async {
    final response = await http.patch(
      Uri.parse('$BASEURL/list'),
      headers: {'X-Last-Known-Revision': revision.toString()}
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['list'];
    } else {
      throw Exception('Failed to update list');
    }
  }

  Future<dynamic> getElementFromServer(String id) async {
    final response = await http.get(Uri.parse('$BASEURL/list/$id'));
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['element'];
    } else {
      throw Exception('Failed to load element');
    }
  }

  Future<dynamic> addElementToList(dynamic data, int revision) async {
    final response = await http.post(
      Uri.parse('$BASEURL/list'),
      headers: {'X-Last-Known-Revision': revision.toString()},
      body: jsonEncode(data)
    );
    
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['element'];
    } else {
      throw Exception('Failed to add element to list');
    }
  }

  void main() {
    fetchData('Bruithwir');
  }*/
