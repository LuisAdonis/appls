import 'package:appls/models/user_model.dart';
import 'package:appls/service/audio.dart';
import 'package:appls/service/auth_service.dart';
import 'package:appls/shareprefenrences/sharepreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final presf = SPUsuarios();

enum DrawerIndex {
  home,
  login,
  registro,
  audioenable,
  feedBack,
  help,
  share,
  about,
  invite,
  testing,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}

class DrawerUserController extends StatefulWidget {
  const DrawerUserController({
    Key? key,
    this.drawerWidth = 250,
    this.onDrawerCall,
    this.screenView,
    this.animatedIconData = AnimatedIcons.arrow_menu,
    this.menuView,
    this.drawerIsOpen,
    this.screenIndex,
  }) : super(key: key);

  final double drawerWidth;
  final Function(DrawerIndex)? onDrawerCall;
  final Widget? screenView;
  final Function(bool)? drawerIsOpen;
  final AnimatedIconData? animatedIconData;
  final Widget? menuView;
  final DrawerIndex? screenIndex;
  @override
  _DrawerUserControllerState createState() => _DrawerUserControllerState();
}

class _DrawerUserControllerState extends State<DrawerUserController> with TickerProviderStateMixin {
  ScrollController? scrollController;
  AnimationController? iconAnimationController;
  AnimationController? animationController;

  double scrolloffset = 0.0;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    iconAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 0));
    iconAnimationController?.animateTo(1.0, duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
    scrollController = ScrollController(initialScrollOffset: widget.drawerWidth);
    scrollController!.addListener(() {
      if (scrollController!.offset <= 0) {
        if (scrolloffset != 1.0) {
          setState(() {
            scrolloffset = 1.0;
            try {
              widget.drawerIsOpen!(true);
            } catch (_) {}
          });
        }
        iconAnimationController?.animateTo(0.0, duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
      } else if (scrollController!.offset > 0 && scrollController!.offset < widget.drawerWidth.floor()) {
        iconAnimationController?.animateTo((scrollController!.offset * 100 / (widget.drawerWidth)) / 100, duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
      } else {
        if (scrolloffset != 0.0) {
          setState(() {
            scrolloffset = 0.0;
            try {
              widget.drawerIsOpen!(false);
            } catch (_) {}
          });
        }
        iconAnimationController?.animateTo(1.0, duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
      }
    });
    WidgetsBinding.instance?.addPostFrameCallback((_) => getInitState());
    super.initState();
  }

  Future<bool> getInitState() async {
    scrollController?.jumpTo(
      widget.drawerWidth,
    );
    return true;
  }

  void onDrawerClick() {
    //if scrollcontroller.offset != 0.0 then we set to closed the drawer(with animation to offset zero position) if is not 1 then open the drawer
    if (scrollController!.offset != 0.0) {
      scrollController?.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      scrollController?.animateTo(
        widget.drawerWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + widget.drawerWidth,
          child: Row(
            children: [
              SizedBox(
                width: widget.drawerWidth,
                height: MediaQuery.of(context).size.height,
                child: AnimatedBuilder(
                  animation: iconAnimationController!,
                  builder: (BuildContext context, Widget? child) {
                    return Transform(
                      transform: Matrix4.translationValues(scrollController!.offset, 0.0, 0.0),
                      child: HomeDrawer(
                        screenIndex: widget.screenIndex ?? DrawerIndex.home,
                        iconAnimationController: iconAnimationController,
                        callBackIndex: (DrawerIndex indexType) {
                          onDrawerClick();
                          try {
                            widget.onDrawerCall!(indexType);
                          } catch (e) {
                            return e;
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                //full-screen Width with widget.screenView
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.grey.withOpacity(0.6), blurRadius: 24),
                    ],
                  ),
                  child: Stack(
                    children: <Widget>[
                      //this IgnorePointer we use as touch(user Interface) widget.screen View, for example scrolloffset == 1 means drawer is close we just allow touching all widget.screen View
                      IgnorePointer(
                        ignoring: scrolloffset == 1 || false,
                        child: widget.screenView,
                      ),
                      //alternative touch(user Interface) for widget.screen, for example, drawer is close we need to tap on a few home screen area and close the drawer
                      if (scrolloffset == 1.0)
                        InkWell(
                          onTap: () {
                            onDrawerClick();
                          },
                        ),
                      // this just menu and arrow icon animation
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, left: 8),
                            child: SizedBox(
                              width: AppBar().preferredSize.height - 8,
                              height: AppBar().preferredSize.height - 8,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                                  child: Center(
                                    // if you use your own menu view UI you add form initialization
                                    child: widget.menuView ?? AnimatedIcon(icon: widget.animatedIconData ?? AnimatedIcons.arrow_menu, progress: iconAnimationController!),
                                  ),
                                  onTap: () {
                                    if (presf.audio) {
                                      AudioLS().speak("Menu");
                                    }
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    onDrawerClick();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key, this.screenIndex, this.iconAnimationController, this.callBackIndex}) : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;
  final users = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  Future<void> setDrawerListArray() async {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.home,
        labelName: 'Inicio',
        icon: const Icon(Icons.home),
      ),
      DrawerList(
        index: DrawerIndex.login,
        labelName: 'Iniciar sesión',
        icon: const Icon(Icons.login),
        // isAssetsImage: true,
        // imageName: 'assets/images/supportIcon.png',
      ),
      DrawerList(
        index: DrawerIndex.registro,
        labelName: 'Registrarte',
        icon: const Icon(Icons.app_registration),
        // isAssetsImage: true,
        // imageName: 'assets/images/supportIcon.png',
      ),
      DrawerList(
        index: DrawerIndex.share,
        labelName: 'Estadisticas',
        icon: const Icon(Icons.show_chart),
      ),
      // DrawerList(
      //   index: DrawerIndex.Share,
      //   labelName: 'Rate the app',
      //   icon: Icon(Icons.share),
      // ),
      // DrawerList(
      //   index: DrawerIndex.About,
      //   labelName: 'About Us',
      //   icon: Icon(Icons.info),
      // ),
    ];
  }

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEDF0F2).withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(1.0 - (widget.iconAnimationController!.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(
                              Tween<double>(begin: 0.0, end: 24.0).animate(CurvedAnimation(parent: widget.iconAnimationController!, curve: Curves.fastOutSlowIn)).value / 360),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(color: Colors.grey.withOpacity(0.6), offset: const Offset(2.0, 4.0), blurRadius: 8),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                              child: user != null
                                  ? CircleAvatar(
                                      backgroundImage: NetworkImage(user.photoURL != null
                                          ? "${user.photoURL}"
                                          : "https://firebasestorage.googleapis.com/v0/b/app-lsec.appspot.com/o/85622928-icono-de-perfil-de-avatar-predeterminado-marcador-de-posici%C3%B3n-de-foto-gris-vectores-de-ilustraciones.jpg?alt=media&token=ac3bf05d-6b29-4ab8-97d1-b21934ccadf4"),
                                    )
                                  : Image.asset(
                                      'assets/logosenas.png',
                                      color: Colors.deepPurple,
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24, left: 4),
                    child: Text(
                      user != null ? '${user.name}' : "APPLS",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              children: [
                inkwell(drawerList![0]),
                if (user == null) inkwell(drawerList![1]),
                if (user == null) inkwell(drawerList![2]),
                if (user != null) inkwell(drawerList![3]),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: const Text(
                  "Activar Audio",
                  style: TextStyle(
                    fontFamily: 'WorkSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xFF253840),
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Switch(
                    value: presf.audio,
                    onChanged: (a) {
                      setState(() {
                        presf.audio = a;
                      });
                    }),
              ),
              if (user != null)
                ListTile(
                  title: const Text(
                    'Salir ',
                    style: TextStyle(
                      fontFamily: 'WorkSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF253840),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  trailing: const Icon(
                    Icons.power_settings_new,
                    color: Colors.red,
                  ),
                  onTap: () {
                    onTapped();
                  },
                ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> onTapped() async {
    // print('Doing Something...'); // Print to console.
    setState(() {});
    await _authService
        .signout()
        // ignore: avoid_print
        .then((value) => print(value.toString()));
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          if (presf.audio) {
            AudioLS().speak(listData.labelName);
          }
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 6.0,
                    height: 46.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName, color: widget.screenIndex == listData.index ? Colors.blue : const Color(0xFF213333)),
                        )
                      : Icon(listData.icon?.icon, color: widget.screenIndex == listData.index ? Colors.blue : const Color(0xFF213333)),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index ? const Color(0xff6F72CA) : const Color(0xFF213333),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues((MediaQuery.of(context).size.width * 0.75 - 64) * (1.0 - widget.iconAnimationController!.value - 1.0), 0.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: const Color(0xff6F72CA).withOpacity(0.2),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}
