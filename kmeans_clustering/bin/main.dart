import 'dart:io';
import 'dart:convert';
import 'dart:math';

var jsonString = '''
  [
    {"object": "medicineA" , "x": 1, "y":1},
    {"object": "medicineB" , "x": 2, "y":1},
    {"object": "medicineC" , "x": 4, "y":3},
    {"object": "medicineD" , "x": 5, "y":4}
  ]
''';

void main() {
  //determine number of clusters K
  print(
      'hello there! K-Means-clustering here(no validation) using two clusters');
  // print("Enter number of clusters,\n it should be >0 and an integer");
  // var K = stdin.readLineSync();
  // print("there will be " + K.toString() + " clusters");
  //for now let me use the json above
  //TODO create a json on entry tuwache kutumia hii json tukonayo
  //list down the meds
  List medicines = jsonDecode(jsonString);
  for (var i = 0; i < medicines.length; i++) {
    print("Object " + medicines[i]["object"] + "\n");
    print("Attribute 1 :" + medicines[i]["x"].toString() + "\n");
    print("Attribute 2 :" + medicines[i]["y"].toString() + "\n");
    print("x" * 40);
  }
  //pick centroids randomly
  int chosen1 = (Random().nextInt(medicines.length));
  int chosen2 = (Random().nextInt(medicines.length));
  List<num> c1 = [medicines[chosen1]["x"], medicines[chosen1]["y"]];
  List<num> c2 = [medicines[chosen2]["x"], medicines[chosen2]["y"]];
  print("The first centroid is : " + c1.toString());
  print("The second random centroid is " + c2.toString());
  //distance of each object from the centroid
  List distance = [];
  for (var i = 0; i < medicines.length; i++) {
    List<num> meh = [
      //from first centroid
      euclideanDistance(
          x: medicines[i]["x"], cx: c1[0], y: medicines[i]["y"], cy: c1[1]),
      //from second centroid
      euclideanDistance(
          x: medicines[i]["x"], cx: c2[0], y: medicines[i]["y"], cy: c2[1]),
    ];
    // print(meh);

    distance.add(meh);
  }
  print(distance.toString());
  //group the objects based on the minimum distance
  List<int> groupMap = [];
  num newC1x = 0;
  num newC2x = 0; 
  num newC1y = 0;
  num newC2y = 0;
  for (var i = 0; i < distance.length; i++) {
    if (distance[i][0] < distance[i][1]) {
      //the object belongs to the first cluster
      groupMap.add(1);
      //let me try calculating the sum here

      newC1x = newC1x + medicines[i]["x"];
      newC1y = newC1y + medicines[i]["y"];
    } else {
      //the object belongs to the second cluster

      groupMap.add(0);

      newC2x = newC2x + medicines[i]["x"];
      newC2y = newC2y + medicines[i]["y"];
    }
  }
  print(newC1x);
  print(newC1y);
  print((groupMap.where((groupMap) => groupMap < 1)).length);

  List<num> newC1 = [
    (newC1x / (groupMap.where((groupMap) => groupMap < 1)).length),
    (newC1y / (groupMap.where((groupMap) => groupMap < 1)).length)
  ];
  print("First new Centroid");
  print(newC1);
  List<num> newC2 = [
    (newC2x / (groupMap.where((groupMap) => groupMap < 1)).length),
    (newC2y / (groupMap.where((groupMap) => groupMap < 1)).length)
  ];
  print("Second new Centroid");
  print(newC2);
  // print("The distance matrix is : " + groupMap.toString());
  print(
      "Where 0 means it belongs to the first cluster and 1 means it belongs to the second cluster");
}

euclideanDistance({num x, num cx, num y, num cy}) {
  return sqrt(pow((x - cx), 2) + pow((y - cy), 2));
}
