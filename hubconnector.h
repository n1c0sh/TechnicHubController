#ifndef HUBCONNECTOR_H
#define HUBCONNECTOR_H

#include <QObject>
#include <QDebug>
#include <QList>
#include <QBluetoothDeviceInfo>

#include "hubfinder.h"
#include "technichub.h"

class Hubconnector : public QObject
{
    Q_OBJECT
public:
    explicit Hubconnector(HubFinder *f);
    ~Hubconnector();

private:

    bool debugOut;
    QList<QBluetoothDeviceInfo> devicesList;
    HubFinder *finder;
    TechnicHub *hub;

signals:

    void deviceConnectedQML();

    void deviceDisconnected();

    void deviceNameNotify(QString name);

    void hubLinkUpdate(TechnicHub *link);


public slots:

    void setDebugOut(bool value);

    void setDeviceList(const QList<QBluetoothDeviceInfo> &dl);

    void connectTo(int index);

    void disconnectFromDevice();
};

#endif // HUBCONNECTOR_H