import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Stream<List<Cricket>> getalldata(
    Duration refreshTime, http.Client client) async* {
  while (true) {
    await Future.delayed(refreshTime);
    yield await fetchcricketnews(client);
  }
}

Future<List<Cricket>> fetchcricketnews(http.Client client) async {
  const _api_key = "a164ce2366msh9b1254f5dba4b42p12da44jsne2d09d2454e1";
  // Base API url
  const String _baseUrl =
      "https://dev132-cricket-live-scores-v1.p.rapidapi.com/matches.php";
  // Base headers for Response url
  const Map<String, String> _headers = {
    "x-rapidapi-host": "dev132-cricket-live-scores-v1.p.rapidapi.com",
    "x-rapidapi-key": "_api_key",
    "content-type": "application/json",
  };
  Uri uri = Uri.parse(_baseUrl);
  final response = await client.get(uri, headers: _headers);
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsenews, response.body);
}

List<Cricket> parsenews(String responseBody) {
  final parsed = jsonDecode(responseBody)['matchList']['matches']
      .cast<Map<String, dynamic>>();

  return parsed.map<Cricket>((json) => Cricket.fromJson(json)).toList();
}

class Cricket {
  final int id;
  final int matchTypeId;
  final int seriesId;
  final String seriesname;
  final String status;
  final String venue;
  final String hometeam;
  final String awayteam;
  final String matchsummary;
  final String homescore;
  final String homeovers;
  final String awayscore;
  final String awayovers;
  Cricket({
    required this.id,
    required this.matchTypeId,
    required this.seriesId,
    required this.seriesname,
    required this.status,
    required this.venue,
    required this.hometeam,
    required this.awayteam,
    required this.matchsummary,
    required this.homescore,
    required this.homeovers,
    required this.awayscore,
    required this.awayovers,
  });

  factory Cricket.fromJson(Map<String, dynamic> json) {
    return Cricket(
      id: json['id'],
      matchTypeId: json['matchTypeId'] ?? ' ',
      seriesId: json['series']['id'],
      seriesname: json['series']['shortName'] ?? ' ',
      status: json['status'] ?? ' ',
      venue: json['venue']['shortName'] ?? ' ',
      hometeam: json['homeTeam']['shortName'] ?? ' ',
      awayteam: json["awayTeam"]['shortName'] ?? ' ',
      matchsummary: json['matchSummaryText'],
      homescore: json['status'] == 'UPCOMING'
          ? json['startDateTime'].split('T')[0]
          : json["scores"]['homeScore'] as String,
      homeovers: json['status'] == 'UPCOMING'
          ? ' '
          : json["scores"]['homeOvers'] as String,
      awayscore: json['status'] == 'UPCOMING'
          ? json['startDateTime'].split('T')[1]
          : json["scores"]['awayScore'] as String,
      awayovers: json['status'] == 'UPCOMING'
          ? ' '
          : json["scores"]['awayOvers'] as String,
    );
  }
}

class CricketNews extends StatefulWidget {
  @override
  _CricketNewsState createState() => _CricketNewsState();
}

class _CricketNewsState extends State<CricketNews> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Cricket>>(
        stream: getalldata(Duration(milliseconds: 10), http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Live Match Detail Box
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data![index].seriesname,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            ),
                                            Text(
                                              snapshot.data![index].status,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                          width: double.infinity,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            //Team 1 Box
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      child: Row(
                                                    children: [
                                                      Text(
                                                        snapshot.data![index]
                                                            .hometeam,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                        width: 30,
                                                      ),
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(snapshot
                                                                  .data![index]
                                                                  .homescore), //score
                                                              //wickets
                                                            ],
                                                          ),
                                                          Text(snapshot
                                                              .data![index]
                                                              .homeovers), //overs
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            ),
                                            //Team 2 Box
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(snapshot
                                                                  .data![index]
                                                                  .awayscore), //score
                                                              //wickets
                                                            ],
                                                          ),
                                                          Text(snapshot
                                                              .data![index]
                                                              .awayovers), //overs
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        snapshot.data![index]
                                                            .awayteam,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                40,
                                            child: Text(
                                              snapshot
                                                  .data![index].matchsummary,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Tap to view full match Details',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget NewsTile(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.width * 0.25,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.width * 0.25,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'This is the sample description of the image given adjacent to this text',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
