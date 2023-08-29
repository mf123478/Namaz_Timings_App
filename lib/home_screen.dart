import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:urraan_task2/consts/colors.dart';

import 'Modals/modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  
  Future<TimingModal> getData()async{
    
    final response = await http.get(Uri.parse("http://api.aladhan.com/v1/calendarByCity/2017/4?city=Abbottabad&country=Pakistan&method=2"));

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      return TimingModal.fromJson(data);
    }else{
      return TimingModal.fromJson(data);
    }
  }


  var currentTime = TimeOfDay.now().period;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: getData(), builder: (context,snapshot){
        if(snapshot.hasData){
          return Column(
            children: [
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.yellow.shade300,
                        Colors.green,
                      ],
                    ),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 70,bottom: 40,left: 10,right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Abbottabad",style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),),
                          Icon(Icons.settings,color: Colors.white,size: 35,)
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text('Next',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                      const SizedBox(height: 10,),
                      const Text("Last Third",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),),
                      const SizedBox(height: 10,),
                      Text(snapshot.data!.data![0].timings!.fajr.toString(),style: const TextStyle(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),)

                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context,index){
                      return SingleChildScrollView(
                        child: Container(
                          width: 410,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  const SizedBox(height: 15,),
                                  Container(
                                    width: 180,
                                    height: 50,
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(snapshot.data!.data![index].date!.hijri!.day.toString(),style:const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                              ),),
                                              const Text(' - ',style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                              ),),
                                              Text(snapshot.data!.data![index].date!.hijri!.month!.en.toString(), style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                              ),),
                                              const Text(' - ',style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                              ),),
                                              Text(snapshot.data!.data![index].date!.hijri!.year.toString(),style:const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black
                                              ),),

                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(snapshot.data!.data![index].date!.gregorian!.weekday!.en.toString()),
                                            const Text(' '),
                                            Text(snapshot.data!.data![index].date!.gregorian!.day.toString()),
                                            const Text(' '),
                                            Text(snapshot.data!.data![index].date!.gregorian!.month!.en.toString()),
                                            const Text(' '),
                                            Text(snapshot.data!.data![index].date!.gregorian!.year.toString()),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 5,),

                                ],
                              ),
                              ReusableCard(title: "Fajr", value: snapshot.data!.data![index].timings!.fajr.toString()),
                              ReusableCard(title: "Sunrise", value: snapshot.data!.data![index].timings!.sunrise.toString()),
                              ReusableCard(title: "Dhuhr", value: snapshot.data!.data![index].timings!.dhuhr.toString()),
                              ReusableCard(title: "Asr", value: snapshot.data!.data![index].timings!.asr.toString()),
                              ReusableCard(title: "Sunset", value: snapshot.data!.data![index].timings!.sunset.toString()),
                              ReusableCard(title: "Maghrib", value: snapshot.data!.data![index].timings!.maghrib.toString()),
                              ReusableCard(title: "Isha", value: snapshot.data!.data![index].timings!.isha.toString()),
                              ReusableCard(title: "Imsak", value: snapshot.data!.data![index].timings!.imsak.toString()),
                              ReusableCard(title: "Midnight", value: snapshot.data!.data![index].timings!.midnight.toString()),
                              ReusableCard(title: "Firstthird", value: snapshot.data!.data![index].timings!.firstthird.toString()),
                              ReusableCard(title: "Lastthird", value: snapshot.data!.data![index].timings!.lastthird.toString()),

                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          );
        }else{
          return const CircularProgressIndicator();
        }
      }),
    );
  }
}



class ReusableCard extends StatelessWidget {

  String title , value;
  ReusableCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold
              ),),
              Text(value.toString(),style: const TextStyle(
                fontWeight: FontWeight.bold
              ),),
              const Icon(Icons.volume_up_outlined,color: Colors.green,)
            ],
          ),
        ),
      ),
    );
  }
}

