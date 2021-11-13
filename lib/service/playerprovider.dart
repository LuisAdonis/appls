import 'package:appls/models/chapter_model.dart';
import 'package:appls/models/libro_model.dart';
import 'package:appls/models/models/Album.dart';
import 'package:appls/models/models/Track.dart';
import 'package:appls/service/basemixins.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

class PlayerProvider extends ChangeNotifier with BaseMixins {
  final AssetsAudioPlayer player = AssetsAudioPlayer();

  PlayerProvider() {
    player.playlistAudioFinished.listen((Playing playing) {
      next(action: false);
    });

    AssetsAudioPlayer.addNotificationOpenAction((notification) {
      //custom action
      return false; //true : handled, does not notify others listeners
      //false : enable others listeners to handle it
    });
  }

  late Album _currentAlbum;
  Album get currentAlbum => _currentAlbum;

  late LibroModel _capi1;
  LibroModel get capi1 => _capi1;

  late Album _playlist;
  Album get playlist => _playlist;

  Chapter? _currentTrack;
  Chapter? get currentTrack => _currentTrack;

  bool _loopMode = false;
  bool get loopMode => _loopMode;
  bool _loopPlaylist = false;
  bool get loopPlaylist => _loopPlaylist;
  bool _isTrackLoaded = true;
  bool get isTrackLoaded => _isTrackLoaded;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentAlbum(album) {
    _currentAlbum = album;
    notifyListeners();
  }

  currentATrac(track, capi) {
    _currentTrack = track;
    _capi1 = capi;
    notifyListeners();
  }

  late int _sessionId;
  int get sessionId => _sessionId;

  late int tIndex;

  setBuffering(index) {
    tIndex = index;
  }

  playOrPause() async {
    try {
      await player.playOrPause();
    } catch (t) {}
  }

  isFirstTrack() {
    return _currentIndex == 0;
  }

  isLastTrack(next) {
    return next == _currentAlbum.tracks!.length;
  }

  /// Next Track:
  /// Action will be false if used with playlistAudioFinished listener
  /// A track can be next by action or on playlistAudioFinished
  next({action: true}) {
    print("objectsssssssssssssss");
    int next = _currentIndex + 1;
    if (!action && _loopMode && isLastTrack(next) && _loopPlaylist) {
      setPlaying(_currentAlbum, 0);
      play(0);
    } else if (!action && _loopMode && !_loopPlaylist) {
      setPlaying(_currentAlbum, _currentIndex);
      play(_currentIndex);
    } else {
      play(next);
    }
  }

  prev() {
    int pre = _currentIndex - 1;
    if (pre <= _currentAlbum.tracks!.length) {
      play(pre);
    }
  }

  /// Tracks Loop:
  /// Loop a single track or complete playlist
  ///
  int c = 0;
  handleLoop() {
    c++;
    if (c == 1) {
      _loopMode = true;
      _loopPlaylist = true;
    } else if (c == 2) {
      _loopMode = true;
      _loopPlaylist = false;
    } else if (c > 2) {
      _loopMode = _loopPlaylist = false;
      c = 0;
    }
  }

  /// Playlist Shuffing:
  /// Make a copy of original before shuffle
  ///
  late Album _beforeShuffling;
  bool _shuffled = false;
  bool get shuffled => _shuffled;
  handleShuffle() {
    print("111object");

    _shuffled = !_shuffled;
    List? tracks = _currentAlbum.tracks;
    _beforeShuffling = _currentAlbum;
    var shuffledTracks = shuffle(tracks!);
    if (_shuffled) {
      Album album = new Album(
        _currentAlbum.id,
        _currentAlbum.title,
        _currentAlbum.content,
        _currentAlbum.media,
        shuffledTracks,
      );
      _currentAlbum = album;
    } else {
      _currentAlbum = _beforeShuffling;
    }
  }

  /// Play Track
  /// Play track and set current track index
  ///
  play(index) async {
    // player.stop();
    print("111object");
    try {
      _currentTrack = _currentAlbum.tracks![index];
      notifyListeners();
      await _open(_currentAlbum.tracks![index]);
      _currentIndex = index;
    } catch (t) {
      //mp3 unreachable
    }
  }

  isSameAlbum() {
    return _playlist.id == _currentAlbum.id;
  }

  isTrackInProgress(Chapter track) {
    return player.isPlaying.value && player.current.value != null && player.current.value!.audio.assetAudioPath == track.url;
  }

  isLocalTrackInProgress(filePath) {
    return player.isPlaying.value && player.current.value != null && player.current.value!.audio.assetAudioPath == filePath;
  }

  bool isPlaying() {
    return player.isPlaying.value;
  }

  void audioSessionListener() {
    player.audioSessionId.listen((sessionId) {
      _sessionId = sessionId;
    });
  }

  _open(Chapter track) async {
    var metas = Metas(
      title: "Capitulo ${track.cap}",
      artist: "Lector ${track.lector}",
    );

    await player.open(
      Audio.network(track.url, metas: metas),
      showNotification: true,
      notificationSettings: NotificationSettings(
        prevEnabled: isFirstTrack(),
        // nextEnabled: !isLastTrack(_currentIndex + 1),
        customPrevAction: (player) => prev(),
        customNextAction: (player) => next(),
        customPlayPauseAction: (player) => playOrPause(),
        customStopAction: (player) => player.stop(),
      ),
    );
  }

  handlePlayButton({album, required Chapter track, index, LibroModel? capi}) async {
    //Disable shuffling
    _shuffled = false;
    setBuffering(index);
    try {
      if (isTrackInProgress(track)) {
        player.pause();
      } else {
        _isTrackLoaded = false;
        notifyListeners();
        await _open(track);
        _isTrackLoaded = true;
        notifyListeners();
        setPlaying(album, index);
      }
    } catch (t) {
      print(t.toString());
      //mp3 unreachable
    }
  }

  setPlaying(Album album, int index) {
    _currentAlbum = album;
    _currentIndex = index;
    _currentTrack = _currentAlbum.tracks![index];
    notifyListeners();
  }
}
