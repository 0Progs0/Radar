#include "radar.h"
#include <QtMath>
#include <iostream>
#include <QDataStream>

Radar::Radar(QObject *parent) : QAbstractListModel(parent)
{
    socket = new QTcpSocket;
    connect(socket, &QTcpSocket::readyRead, this, &Radar::slotReadyRead);
    connect(socket, &QTcpSocket::disconnected, socket, &QTcpSocket::deleteLater);
}

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

void Radar::connectToServer()
{
    socket->connectToHost("127.0.0.1", 8080);
}

void Radar::slotReadyRead()
{
    QDataStream input (socket);
    input.setVersion(QDataStream::Qt_5_13);
    if (input.status() == QDataStream::Ok)
    {
//        qDebug() << "Reading...";
//        QGeoCoordinate str;
//        input >> str;
//        qDebug() << str;
        qDebug() << "Reading...";
        for (;;) {
            if (nextBlockSize ==0)
            {
                if (socket->bytesAvailable() < 2)
                {
                    break;
                }
                input >> nextBlockSize;
            }
            if (socket->bytesAvailable() < nextBlockSize)
            {
                break;
            }
            QGeoCoordinate str;
            input >> str;
            qDebug() << str;
            nextBlockSize = 0;
            addCoord(str);
            qDebug() << m_coordinates;
        }
    }
    else
    {
        qDebug() << "DataStream error";
    }
}

void Radar::sendToServer(QGeoCoordinate str)
{
    d_array.clear();
    QDataStream output (&d_array, QIODevice::WriteOnly);
    output.setVersion(QDataStream::Qt_5_13);
    output << quint16(0) << str;
    output.device()->seek(0);
    output << quint16(d_array.size() - sizeof (quint16));
    socket->write(d_array);
}

void Radar::addCoord(const QGeoCoordinate &coordinate)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
           m_coordinates.append(coordinate);
           endInsertRows();
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
