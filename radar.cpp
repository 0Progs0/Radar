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
