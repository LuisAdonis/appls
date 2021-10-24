import 'package:appls/models/data_arguments_model.dart';
import 'package:appls/models/result_arguments_model.dart';
import 'package:appls/ui/acerca.dart';
import 'package:appls/ui/diccionarrio/diccionario_page.dart';
import 'package:appls/ui/diccionarrio/resultado_page.dart';
import 'package:appls/ui/estudiar/estudiar_screen.dart';
import 'package:appls/ui/evaluacion/evaluacion_screen.dart';
import 'package:appls/ui/evaluacion/generandonr.dart';
import 'package:appls/ui/evaluacion/generarpreguntas.dart';
import 'package:appls/ui/evaluacion/quiz_screen.dart';
import 'package:appls/ui/evaluacion/result.dart';
import 'package:appls/ui/home_page.dart';
import 'package:appls/ui/institucion.dart';
import 'package:appls/ui/lmkit/lenguajelm_screen.dart';
import 'package:appls/ui/logins.dart';
import 'package:appls/ui/register_page.dart';
import 'package:appls/ui/splash_screen.dart';
import 'package:appls/ui/utils/dadata_ctg.dart';
import 'package:appls/ui/utils/dbdata.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'SplashScreen':
        return _pageTranst(settings: settings, child: const SplashScreen(), type: PageTransitionType.rightToLeft);
      case 'LoginScreen':
        return _pageTranst(settings: settings, child: const LoginPage(), type: PageTransitionType.rightToLeft);
      case 'Registro':
        return _pageTranst(settings: settings, child: const RegisterPage(), type: PageTransitionType.rightToLeft);
      case 'HomePage':
        return _pageTranst(settings: settings, child: const HomePage(), type: PageTransitionType.rightToLeft);
      case 'Estudiar':
        return _pageTranst(settings: settings, child: const EstudiarScreen(), type: PageTransitionType.rightToLeft);
      case 'Diccionario':
        return _pageTranst(settings: settings, child: const DiccionarioPage(), type: PageTransitionType.rightToLeft);
      case 'DBData':
        final a = settings.arguments as DataArguments;
        return _pageTranst(settings: settings, child: DBData(arguments: a), type: PageTransitionType.rightToLeft);
      case 'DBDatac':
        final a = settings.arguments as DataArguments;
        return _pageTranst(settings: settings, child: DBDataCategoria(arguments: a), type: PageTransitionType.rightToLeft);
      case 'Resultados':
        final a = settings.arguments as DataArguments;
        return _pageTranst(settings: settings, child: ResultadosPage(arguments: a), type: PageTransitionType.rightToLeft);
      case 'Acerca De':
        return _pageTranst(settings: settings, child: const AcercaScreen(), type: PageTransitionType.rightToLeft);
      case 'Institución':
        return _pageTranst(settings: settings, child: const InstitucionScreen(), type: PageTransitionType.rightToLeft);
      case 'Lenguaje ML':
        return _pageTranst(settings: settings, child: const LenguahelmScreen(), type: PageTransitionType.rightToLeft);
      case 'Evaluación':
        return _pageTranst(settings: settings, child: const EvaluacionScreen(), type: PageTransitionType.rightToLeft);
      case 'QuizScreen':
        final a = settings.arguments as DataArguments;
        return _pageTranst(settings: settings, child: QuizScreen(arguments: a), type: PageTransitionType.rightToLeft);
      case 'GenerarEvaluacion':
        return _pageTranst(settings: settings, child: const GenerarPregunta(), type: PageTransitionType.rightToLeft);
      case 'GenerarEvaluacionr':
        final a = settings.arguments as DataArguments;
        return _pageTranst(settings: settings, child: GenerarPreguntar(arguments: a), type: PageTransitionType.rightToLeft);
      case 'Resultado':
        final a = settings.arguments as ResultArguments;
        return _pageTranst(settings: settings, child: ResultScreen(questions: a.questions, totalTime: a.totalTime, score: a.score), type: PageTransitionType.rightToLeft);

      default:
        return _pageTranst(
          settings: settings,
          child: Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          type: PageTransitionType.leftToRight,
        );
    }
  }

  static PageTransition<dynamic> _pageTranst({required Widget child, required RouteSettings settings, required PageTransitionType type}) {
    return PageTransition(
      child: child,
      type: type,
      settings: settings,
    );
  }
}
