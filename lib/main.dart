import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:invite/services/attend_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Imbitasyon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade200),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Handaan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ConfettiController confettiController = ConfettiController(
    duration: const Duration(seconds: 5),
  );

  TextEditingController pangalan = TextEditingController();
  TextEditingController pagkain = TextEditingController();
  TextEditingController mensahe = TextEditingController();

  bool successState = false;
  bool loadingState = false;

  @override
  void initState() {
    super.initState();
    confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('home_background.jpg'),
                fit: BoxFit.fitHeight),
          ),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
            width: MediaQuery.of(context).size.height * 0.8,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.35,
                left: 20,
                right: 20),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 50, right: 50, top: 50),
                  child: Text(
                    'Kapag natanggap mo ang imbitasyon na ito, ikaw ay inaanyayahan sa aking handaan. Pakiusap, ilagay '
                    'ang iyong pangalan sa ibaba, isulat kung anong pagkain ang nais mong kainin, at kung may regalo ka '
                    'para sa akin, isama ito sa iyong mensahe. Pindutin ang "Ako Ay Makakapunta" pagkatapos.',
                    textAlign: TextAlign.justify,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                  child: Text('Saan : Sico 2.0\nKailan : Oct 22'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: TextField(
                    onChanged: (value) => setState(() {}),
                    controller: pangalan,
                    decoration: const InputDecoration(hintText: 'Pangalan'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: TextField(
                    onChanged: (value) => setState(() {}),
                    controller: pagkain,
                    decoration:
                        const InputDecoration(hintText: 'Gustong Kainin'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: TextField(
                    onChanged: (value) => setState(() {}),
                    controller: mensahe,
                    decoration: const InputDecoration(hintText: 'Mensahe'),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                    child: ElevatedButton(
                        onPressed: pangalan.text == '' ||
                                pagkain.text == '' ||
                                mensahe.text == '' ||
                                loadingState
                            ? null
                            : () async {
                                setState(() {
                                  loadingState = true;
                                });
                                var success = await BunbuyVoucherService()
                                    .addAttendFirebase(pangalan.text,
                                        pagkain.text, mensahe.text, true);

                                if (success) {
                                  setState(() {
                                    pangalan.text = '';
                                    pagkain.text = '';
                                    mensahe.text = '';
                                    loadingState = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Success"),
                                  ));
                                } else {
                                  setState(() {
                                    loadingState = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Something Went Wrong"),
                                  ));
                                }
                              },
                        child: const Text(
                          'Ako Ay Makakapunta',
                          textAlign: TextAlign.center,
                        ))),
                Padding(
                    padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                    child: ElevatedButton(
                        onPressed: pangalan.text == '' ||
                                pagkain.text == '' ||
                                mensahe.text == '' ||
                                loadingState
                            ? null
                            : () async {
                                setState(() {
                                  loadingState = true;
                                });
                                var success = await BunbuyVoucherService()
                                    .addAttendFirebase(pangalan.text,
                                        pagkain.text, mensahe.text, false);

                                if (success) {
                                  setState(() {
                                    pangalan.text = '';
                                    pagkain.text = '';
                                    mensahe.text = '';
                                    loadingState = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Success"),
                                  ));
                                } else {
                                  setState(() {
                                    loadingState = false;
                                  });
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text("Something Went Wrong"),
                                  ));
                                }
                              },
                        child: const Text(
                          'Pasensya, Ako Ay Hindi Makakadalo',
                          textAlign: TextAlign.center,
                        ))),
              ],
            )),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: ConfettiWidget(
            gravity: 0.01,
            emissionFrequency: 0.04,
            blastDirectionality: BlastDirectionality.directional,
            blastDirection: 0,
            minimumSize: const Size(1, 1),
            maximumSize: const Size(5, 30),
            shouldLoop: true,
            numberOfParticles: 5,
            confettiController: confettiController,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: ConfettiWidget(
            gravity: 0.01,
            emissionFrequency: 0.04,
            blastDirectionality: BlastDirectionality.directional,
            blastDirection: 3.1415,
            minimumSize: const Size(1, 1),
            maximumSize: const Size(5, 30),
            shouldLoop: true,
            numberOfParticles: 5,
            confettiController: confettiController,
          ),
        ),
      ],
    ));
  }
}
