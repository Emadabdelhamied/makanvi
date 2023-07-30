import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PusherEvent {
  String event;
  dynamic data;
  dynamic member;
  PusherEvent({required this.event, required this.data, this.member});

  Map<String, dynamic> toMap() {
    return {
      'event': event,
      'data': data,
    };
  }

  factory PusherEvent.fromMap(Map<String, dynamic> map) {
    return PusherEvent(
      event: map['event'],
      data: map['data'],
      member: map['members'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PusherEvent.fromJson(String source) =>
      PusherEvent.fromMap(json.decode(source));
}

class PusherClient {
  static PusherClient? client;
  WebSocketChannel? channel;
  String? socketid;
  String? authEndpoint;
  Map<String, dynamic>? authEndpointHeaders;
  Map<String, dynamic>? authEndpointbody;

  PusherClient initialize({
    String host = "pusher.com",
    required String cluster,
    required String appKey,
    Function(PusherEvent)? onEvent,
    String? authEndpoint,
    required int channelID,
    Map<String, dynamic>? authEndpointheaders,
    //  Map<String, dynamic>? authEndpointbody,
    int wsport = 80,
  }) {
    channel = WebSocketChannel.connect(
      Uri.parse(
          'ws://ws-$cluster.$host:$wsport/app/$appKey?client=pusher-channels-flutter&version=1.0.4&protocol=5'),
    );
    log('connected');
    this.authEndpoint = authEndpoint;
    authEndpointHeaders != null
        ? null
        : authEndpointHeaders = authEndpointheaders;
    authEndpointbody = authEndpointbody;
    StreamController controller = StreamController();
    channel?.stream.listen(
      (
        element,
      ) async {
        final event = PusherEvent.fromJson(element);
        onEvent?.call(event);

        if (event.event == "pusher:connection_established") {
          socketid = jsonDecode(event.data)['socket_id'];

          await subscribe("presence-chat.$channelID");
        }

        log("Pusher : " + element);
      },
      onDone: () {
        // log('Pusher :  disconected');
        // Future.delayed(const Duration(seconds: 5), () {
        // socketid = null;
        // initialize(
        // cluster: cluster,
        // appKey: appKey,
        // onEvent: onEvent,
        // wsport: wsport,
        // channelID: channelID,
        // authEndpoint: authEndpoint,
        // authEndpointheaders: authEndpointHeaders,
        // );
        // });
      },
    );
    client = this;
    return client!;
  }

  Future<void> subscribe(String channelName) async {
    Response? response;
    if (socketid != null) {
      if (client?.authEndpoint != null && client?.authEndpointHeaders != null) {
        final mydio = Dio(
          BaseOptions(
              baseUrl: '',
              receiveDataWhenStatusError: true,
              headers: client?.authEndpointHeaders),
        );
        try {
          print(client?.authEndpointHeaders);
          log(client!.socketid.toString());
          response = await mydio.post(client?.authEndpoint ?? "", data: {
            "channel_name": channelName,
            "socket_id": client?.socketid,
          });
        } on DioError catch (e) {
          log(e.response!.data.toString());
        }
      }
      client?.channel?.sink.add(jsonEncode({
        'event': 'pusher:subscribe',
        'data': {
          'channel': channelName,
          if (response != null) "auth": response.data['auth'],
          if (response != null) "channel_data": response.data['channel_data'],
        },
      }));
    }
  }

  unsubscribe(String channelName) {
    client?.channel?.sink.add(jsonEncode({
      'event': 'pusher:unsubscribe',
      'data': {
        'channel': channelName,
      },
    }));
  }

  channelTriger(String channelName, String eventName, dynamic data) {
    client?.channel?.sink.add(jsonEncode({
      'event': eventName,
      'channel': channelName,
      'data': data,
    }));
  }

  close() {
    // if (client?.socketid != null) {
    client?.channel?.sink.close();
    // }
  }
}
