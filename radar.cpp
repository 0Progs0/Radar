#include "radar.h"
#include <QtMath>
#include <iostream>

int Radar::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent)
    return m_coordinates.count();
}

QVariant Radar::data(const QModelIndex &index, int role) const {
    if (index.row() < 0 || index.row() >= m_coordinates.count())
        return QVariant();
    if(role == Radar::positionRole)
        return QVariant::fromValue(m_coordinates[index.row()]);
    return QVariant();
}

QHash<int, QByteArray> Radar::roleNames() const {
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();;
    roles[positionRole] = "position";
    return roles;
}

void Radar::addMarker(const QGeoCoordinate &coordinate) {

    QGeoCoordinate fVertex = findFirstVertex(coordinate);
    QGeoCoordinate sVertex = findSecondVertex(coordinate);
    std::cout << fVertex.latitude() << std::endl;
    std::cout << fVertex.longitude() << std::endl;
    std::cout << sVertex.latitude() << std::endl;
    std::cout << sVertex.longitude() << std::endl;
    beginInsertRows(QModelIndex(), 0, rowCount());
    m_coordinates.append(coordinate);
    m_coordinates.append(fVertex);
    m_coordinates.append(sVertex);
    endInsertRows();

    }


void Radar::removeMarker(const QGeoCoordinate &coordinate) {
    if (rowCount() != 0) {
        for (int i = 0; i < rowCount(); i++) {
            if ((coordinate.latitude() == m_coordinates.at(i).latitude())&&(coordinate.longitude() == m_coordinates.at(i).longitude()))
            {
                 beginRemoveRows(QModelIndex(),  0,  rowCount()-1);

                 m_coordinates.removeAt(i);

                 endRemoveRows();
           }
       }

    }
}

QGeoCoordinate Radar::findFirstVertex(const QGeoCoordinate &coordinate)
{
    QGeoCoordinate vertex = coordinate;
    vertex.setLatitude(vertex.latitude()+2.5*cos(120)/111.111);
    vertex.setLongitude(vertex.longitude()+(2.5*sin(120)/111.111));
    return vertex;

}

QGeoCoordinate Radar::findSecondVertex(const QGeoCoordinate &coordinate)
{
    QGeoCoordinate vertex = findFirstVertex(coordinate);
    vertex.setLongitude(vertex.longitude()-(2.5*sin(120)/111.111));
    return vertex;

}
