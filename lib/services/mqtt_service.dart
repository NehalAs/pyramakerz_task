import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  MqttClient? client;
  String broker = '192.168.8.184'; // Replace with your broker address
  String topic = 'speech_topic';

  void connect() async {
    client = MqttServerClient(broker, 'flutter_client');
    client!.port = 1883; // Default port for MQTT
    client!.logging(on: true); // Optional, for debugging

    // final connMessage = MqttConnectMessage()
    //     .withClientIdentifier('flutter_client')
    //     .startClean(); // Start a clean session

    try {
      print('Connecting to the broker...');
      await client!.connect();
      print('Connected to the broker!');

      // Subscribe to a topic
      client!.subscribe(topic, MqttQos.atMostOnce);
    } catch (e) {
      print('Error: $e');
    }
  }

  // Publish a message to the broker
  void publishMessage(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);

    client!.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);

    print('Published message: $message');
  }

  // Disconnect from the broker
  void disconnect() {
    client!.disconnect();
    print('Disconnected from the broker');
  }
}
