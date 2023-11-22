import QtQuick 2.6
import QtQuick.Controls 1.5
import QtLocation 5.6
import QtQml 2.12

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ListModel {
        id: polygonModel


    }


    Map {
        id:map
        anchors.fill: parent
        plugin: Plugin { name: "osm" }

        center {
            latitude: 59.95
            longitude: 30.33
        }


        zoomLevel: 6


        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: {
                if (mouse.button == Qt.LeftButton) {

                    var coordinate = map.toCoordinate(Qt.point(mouse.x,mouse.y))
                    var secondCoord = radar.findFirstVertex(coordinate)
                    var thirdCoord = radar.findSecondVertex(coordinate)
                    var list = [
                                {latitude:coordinate.latitude, longitude:coordinate.longitude},
                                {latitude:secondCoord.latitude, longitude:secondCoord.longitude},
                                {latitude:thirdCoord.latitude, longitude:thirdCoord.longitude}
                              ]
                    polygonModel.append({coordsArray : list})
                }
                else if (mouse.button == Qt.RightButton) {

                    var coordinate = map.toCoordinate(Qt.point(mouse.x,mouse.y))
                    polyline.addCoordinate(coordinate)
            }
        }
    }

        MapPolyline {
                    id: polyline
                    line.width: 4
                    line.color: "red"

                    function getDistanceCount(){
                                var distance_count=0;
                                if (polyline.pathLength() < 2) {
                                    console.log(polyline.pathLength())
                                    console.log("too quickly")
                                    return 0;
                                }
                                else {
                                for(var i=1;i<polyline.pathLength();i++){
                                    distance_count+=polyline.coordinateAt(i).distanceTo(polyline.coordinateAt(i-1));
                                    console.log(distance_count)
                                }
                                return Math.round(distance_count);
                                }
                            }
                    onPathChanged: getDistanceCount()
                    }





        MapItemView {
                model: polygonModel

                delegate:MapPolygon {
                    id: polygon
                    color: "red"
                    path: [
                           polygonModel.get(index).coordsArray.get(0),
                           polygonModel.get(index).coordsArray.get(1),
                           polygonModel.get(index).coordsArray.get(2)
                    ]

                transformOrigin: MapPolygon.BottomLeft
                NumberAnimation on rotation { from: 0; to: 360; duration: 20000; loops: Animation.Infinite; }

                onRotationChanged: {
                    if ((polygon.TopLeft < radarModel.children[0].radius)&&(polygon.BottomRight > radarModel.children[0].radius))
                    {
                        console.log("!!!")
                    }
                    else console.log(polygon.width)
                }


                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.RightButton
                    onClicked: {
                        if (mouse.button == Qt.RightButton) {
                        polygonModel.remove(index)


                        }
                    }
                }
            }


            }

        MapItemView {
                id: radarModel
                model: radar

                delegate:MapCircle {
                    id: circle
                    color: "red"
                    radius: 100
                    center: position

                }
            }

        Button {
            text: "Connect";
            onClicked: radar.connectToServer();
        }
    }
}
