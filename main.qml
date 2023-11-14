import QtQuick 2.13
import QtQuick.Window 2.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Styles 1.4
import QtLocation 5.12
import QtQuick.Shapes 1.12
import Radar 1.0

Window {
    id: mainWindow
    visible: true
    width: 640
    height: 480


//    property var points: [
//           {
//                path: [
//                   {latitude:59.91288302222718, longitude:30.728799819940349},
//                   {latitude:59.91821810440818, longitude:30.737211227411649},
//                   {latitude:59.912323649434825, longitude:30.754119873037723}
//               ]
//           }
//       ]
//    Component.onCompleted: {
//        var coord = {path:[{latitude:59.71288302222718, longitude:30.728799819940349},
//                {latitude:59.71821810440818, longitude:30.737211227411649},
//                {latitude:59.712323649434825, longitude:30.754119873037723}]}
//        points.push(coord)
//        console.log(points[0].path[0].latitude)
//        console.log(points[1].path[0].latitude)
//    }


    Map {
        id: map
        anchors.fill: parent     
        plugin: Plugin {
            name: "osm"
        }

        center {
            latitude: 59.95
            longitude: 30.33
        }

        zoomLevel: 13
//        Repeater {
//                    model: points
//                    MapPolygon {
//                        color: "red"
//                        border{ width: 1; color: "grey" }
//                        path: points[index].path
//                    }
//        }

        MapPolygon{
                    id: polygon
                    color: "green"
                    path: [{latitude:59.91288302222718, longitude:30.728799819940349},
                           {latitude:59.91821810440818, longitude:30.737211227411649},
                           {latitude:59.912323649434825, longitude:30.754119873037723}
                          ]
                }




//        MapItemView {
////                    model: radar
//                      delegate: mapcomponent
//                      model: mainWindow.points
//                }

//        Component {
//            id: mapcomponent
//           MapPolygon {
//               border.color: "green"
//               border.width: 6
//               path: points[index].path;
//            }
//        }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                if (mouse.button == Qt.LeftButton)
                {
                    var coordinate = map.toCoordinate(Qt.point(mouse.x,mouse.y))
                    polygon.removeCoordinate(polygon.path[0])
                    polygon.removeCoordinate(polygon.path[0])
                    polygon.removeCoordinate(polygon.path[0])
                    polygon.addCoordinate(coordinate)
                    polygon.addCoordinate(radar.findFirstVertex(coordinate))
                    polygon.addCoordinate(radar.findSecondVertex(coordinate))
//                    var firstLat = coordinate.latitude
//                    var firstLon = coordinate.longitude
//                    var secondLat = radar.findFirstVertex(coordinate).latitude
//                    var secondLon = radar.findFirstVertex(coordinate).longitude
//                    var thirdLat = radar.findSecondVertex(coordinate).latitude
//                      var thirdLon = radar.findSecondVertex(coordinate).longitude
//                        var coord = {path:[{firstLat, firstLon},
//                            {secondLat, secondLon},
//                            {thirdLat, thirdLon}]}
//                    console.log(coord[0].path[0].latitude)
//                    points.push(coord)
//                    console.log(coordinate)
//                    radar.addMarker(coordinate)
//                    console.log(points[0].path[0].latitude)
//                    console.log(points[1].path[0].longitude)


                }
                else  if (mouse.button == Qt.RightButton)
                {
                    var coordinate = map.toCoordinate(Qt.point(mouse.x,mouse.y))
                    console.log(radar.removeMarker(coordinate))
                    radar.removeMarker(coordinate)
                }

            }
        }
        function addMarker(coordinate) {
    //        var firstLat = coordinate.latitude
    //        var firstLon = coordinate.longitude
    //        var secondLat = radar.findFirstVertex(coordinate).latitude
    //        var secondLon = radar.findFirstVertex(coordinate).longitude
    //        var thirdLat = radar.findSecondVertex(coordinate).latitude
    //        var thirdLon = radar.findSecondVertex(coordinate).longitude
    //            var coord = {path:[{latitude:firstLat, firstLon},
    //                {latitude:secondLat, secondLon},
    //                {latitude:thirdLat, thirdLon}]}
    //        console.log(coord[0].path[0])
    //        points.push(coord)
    //        points[1].path[0].latitude = firstLat
    //        points[1].path[0].longitude = firstLon
    //        points[1].path[1].latitude = secondLat
    //        points[1].path[1].longitude = secondLon
    //        points[1].path[2].latitude = thirdLat
    //        points[1].path[2].longitude = thirdLon
    //            points.push([])
//            console.log(points[1].path[0])
//            console.log(points[1].path[0])
            polygon.addCoordinate(coordinate)
            polygon.addCoordinate(radar.findFirstVertex(coordinate))
            polygon.addCoordinate(radar.findSecondVertex(coordinate))
            }
    }
}

