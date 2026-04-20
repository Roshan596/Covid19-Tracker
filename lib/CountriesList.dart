import 'package:app/DetailScreen.dart';
import 'package:app/Servicrs/states_services.dart';
import 'package:flutter/material.dart';

class Countrieslist extends StatefulWidget {
  const Countrieslist({super.key});

  @override
  State<Countrieslist> createState() => _CountrieslistState();
}

class _CountrieslistState extends State<Countrieslist> {
  TextEditingController searchcontroller = TextEditingController();
  StatesServices statesServices = StatesServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  
                });
              },
              controller: searchcontroller,
              decoration: InputDecoration(
                hint: const Text("Search With Countries Name"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: statesServices.countriesListApi(),
              builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name=snapshot.data![index]['country'];

                      if(searchcontroller.text.isEmpty

                      ){
                         return GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => Detailscreen(
                           name: snapshot.data![index]['country'],
          image: snapshot.data![index]['countryInfo']['flag'],
            test: snapshot.data![index]['tests'],
           totalcase: snapshot.data![index]['cases'],
             totaldeath: snapshot.data![index]['deaths'],
             totalrecovered: snapshot.data![index]['recovered'],
             active: snapshot.data![index]['active'],
             critical: snapshot.data![index]['critical'],
                        ),)),
                           child: Column(
                                                   children: [
                            ListTile(
                              leading: Image(
                                image: NetworkImage(
                                  snapshot.data![index]['countryInfo']['flag'],
                                ),
                                height: 50,
                                width: 50,
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                "Cases: ${snapshot.data![index]['cases']}",
                              ),
                            )
                                                   ],
                                                 ),
                         );

                      }
                      else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase())

                      ){
                         return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder:(context) => Detailscreen(
                           name: snapshot.data![index]['country'],
          image: snapshot.data![index]['countryInfo']['flag'],
            test: snapshot.data![index]['tests'],
           totalcase: snapshot.data![index]['cases'],
             totaldeath: snapshot.data![index]['deaths'],
             totalrecovered: snapshot.data![index]['recovered'],
             active: snapshot.data![index]['active'],
             critical: snapshot.data![index]['critical'],
                        ),));
                            },
                            child: ListTile(
                              leading: Image(
                                image: NetworkImage(
                                  snapshot.data![index]['countryInfo']['flag'],
                                ),
                                height: 50,
                                width: 50,
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                "Cases: ${snapshot.data![index]['cases']}",
                              ),
                            ),
                          )
                        ],
                      );

                      }
                      else{
                        return Container();

                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}


