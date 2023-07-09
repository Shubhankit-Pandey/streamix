import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:streamix/providers/user_provider.dart';

import '../config.dart';
import '../providers/user_provider.dart';

class BroadcastScreen extends StatefulWidget {
  final bool isBroadcaster;
  final String channelId;
  const BroadcastScreen(
      {required this.channelId, required this.isBroadcaster, super.key});

  @override
  State<BroadcastScreen> createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> {
  late final RtcEngine _engine;
  List<int> uid = [];
  @override
  void initState() {
    super.initState();
    _initEngine();
  }

  void _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(appId: appId));
    _addListeners();
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine
        .setChannelProfile(ChannelProfileType.channelProfileLiveBroadcasting);
    if (widget.isBroadcaster) {
      _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    } else {
      _engine.setClientRole(role: ClientRoleType.clientRoleAudience);
    }

    _joinChannel();
  }

  void _addListeners() {
    _engine.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (connection, elapsed) {
        debugPrint('join Channel Success $connection $elapsed');
      },
      onUserJoined: (connection, remoteUid, elapsed) {
        debugPrint('join Channel Success $remoteUid $elapsed');
        setState(() {
          uid.add(remoteUid);
        });
      },
      onUserOffline: (connection, remoteUid, reason) {
        debugPrint('user offline $remoteUid $reason');
        setState(() {
          uid.removeWhere((element) => element == remoteUid);
        });
      },
      onLeaveChannel: (connection, stats) {
        debugPrint('leaveChannel $stats');
        setState(() {
          uid.clear();
        });
      },
    ));
  }

  void _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }

    await _engine.joinChannelWithUserAccount(
      token: tempToken,
      channelId: 'test123',
      userAccount: Provider.of<UserProvider>(context, listen: false).user.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            _renderVideo(user),
          ],
        ),
      ),
    );
  }
}

_renderVideo(user) {
  return AspectRatio(
    aspectRatio: 16 / 9,
    child: Text("hello"),
  );
}
