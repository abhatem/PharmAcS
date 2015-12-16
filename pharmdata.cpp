#include "pharmdata.h"
#include "pharmitem.h"
#include <iostream>
#include <QStringList>

//#include <sqlcipher/sqlite3ext.h>
#include <QFile>

PharmData::PharmData(QObject *parent) :
    QObject(parent)
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("data.db3");
    db.open();
    //db.exec("DROP TABLE items");
    std::cout << "openning database" << std::endl;

    // 1
    std::cout << "creating bills table . . ." << std::endl;
    db.exec("CREATE TABLE IF NOT EXISTS \"bills\" ( \"billId\" INTEGER PRIMARY KEY AUTOINCREMENT, \"discription\" TEXT, \"returned\" INT DEFAULT 0)");
    std::cout << "bills table created" << std::endl;
    // 2
    std::cout << "creating billitems table . . ." << std::endl;
    db.exec("CREATE TABLE IF NOT EXISTS \"billitems\"(\"itemId\" INTEGER PRIMARY KEY AUTOINCREMENT, \"barcode\" TEXT NOT NULL, \"amount\" INTEGER NOT NULL,\"sellingPrice\" INTEGER NOT NULL, \"invoicePrice\" INTEGER)");
    std::cout << "billitems table created" << std::endl;
    //3
    std::cout << "creating billsbilllitems table . . ." << std::endl;
    QSqlQuery q = db.exec("CREATE TABLE IF NOT EXISTS \"billsbillitems\"(\"id\" INTEGER PRIMARY KEY AUTOINCREMENT, \"billId\" INTEGER NOT NULL, \"itemId\" INTEGER NOT NULL)");
//    qDebug() << q.lastError();
    std::cout << "billsbillitems table created" << std::endl;
    //4
    std::cout << "creating billsdate table . . ." << std::endl;
    q = db.exec("CREATE TABLE IF NOT EXISTS \"billsdate\"(\"id\" INTEGER PRIMARY KEY AUTOINCREMENT, \"billDate\" TEXT NOT NULL ,\"billId\" INTEGER NOT NULL)");
//    qDebug() << q.lastError();
    std::cout << "billsdate table created" << std::endl;
    //5
    std::cout << "creating invoices table" << std::endl;
    db.exec("CREATE TABLE IF NOT EXISTS \"invoices\" (\"invoiceId\" INTEGER PRIMARY KEY AUTOINCREMENT, \"date\" TEXT NOT NULL, \"dueDate\" TEXT NOT NULL, \"discription\" TEXT)");
    std::cout << "invoices table created" << std::endl;
    //6
    std::cout << "creating invoicesitems table . . ." << std::endl;
    db.exec("CREATE TABLE IF NOT EXISTS \"invoicesitems\"  (\"id\" INTEGER PRIMARY KEY AUTOINCREMENT, \"invoiceId\" INTEGER NOT NULL, \"barcode\" TEXT NOT NULL)");
    std::cout << "invoicesitems table created" << std::endl;
    //7
    std::cout << "creating items table . . ." << std::endl;
    db.exec("CREATE TABLE IF NOT EXISTS \"items\"  (\"barcode\" TEXT PRIMARY KEY, \"name\" TEXT, \"scientificName\" TEXT, \"discription\"  TEXT, \"imagePath\" TEXT, \"sellingPrice\" INTEGER, \"invoicePrice\"  INTEGER, \"amount\" INTEGER, \"bonus\" INTEGER, \"expiryDate\" INTEGER, \"posX\" INTEGER, \"posY\" INTEGER)");
    std::cout << "items table created" << std::endl;
    //8
    std::cout << "creating notifications table . . ." << std::endl;
    db.exec("CREATE TABLE IF NOT EXISTS \"notifications\"  (\"notificationId\" INTEGER PRIMARY KEY AUTOINCREMENT, \"summary\" TEXT NOT NULL, \"text\" TEXT, \"datetime\" TEXT NOT NULL)");
    std::cout << "notifications table created" << std::endl;
    //9
    std::cout << "creating tags table . . ." << std::endl;
    db.exec("CREATE TABLE IF NOT EXISTS \"tags\"  (\"tagId\" INTEGER PRIMARY KEY AUTOINCREMENT, \"tag\" TEXT NOT NULL )");
    std::cout << "tags table created" << std::endl;
    //10
    std::cout << "creating tagsitems table . . ." << std::endl;
    db.exec("CREATE TABLE IF NOT EXISTS \"tagsitems\"  (\"id\" INTEGER PRIMARY KEY AUTOINCREMENT, \"tagId\" INTEGER NOT NULL, \"barcode\" TEXT NOT NULL)");
    std::cout << "tagsitems table created" << std::endl;
    //11
    std::cout << "creating places table . . ." << std::endl;
    //db.exec("CREATE TABLE IF NOT EXISTS \"places\" (\"id\" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, \"placePath\" TEXT NOT NULL, \"barcode\" TEXT NOT NULL)");
    db.exec("CREATE TABLE IF NOT EXISTS \"places\" (\"placeId\" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, \"placePath\" TEXT NOT NULL)");
    std::cout << "places table created" << std::endl;
    //12
    std::cout << "creating placesitems table . . ." << std::endl;
    db.exec("CREATE TABLE IF NOT EXISTS \"placesitems\" (\"id\" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, \"placeId\" INTEGER NOT NULL, \"barcode\" TEXT NOT NULL)");
    std::cout << std::endl << "data object initialized" << std::endl;

    loadPharmItems();
    loadPlacesPaths();
}

PharmData::~PharmData()
{
    db.close();
}
void PharmData::loadPharmItems() {
    _pharmItems.clear();
    QSqlQuery q = db.exec("SELECT * FROM items");
    QSqlRecord itemRec = q.record();
    int barcodeCol = itemRec.indexOf("barcode");
    int nameCol = itemRec.indexOf("name");
    int scientificNameCol = itemRec.indexOf("scientificName");
    int discriptionCol = itemRec.indexOf("discription");
    int imagePahtCol = itemRec.indexOf("imagePath");
    int sellingPriceCol = itemRec.indexOf("sellingPrice");
    int invoicePriceCol = itemRec.indexOf("invoicePrice");
    int amountCol = itemRec.indexOf("amount");
    int bonusCol = itemRec.indexOf("bonus");
    int expiryDateCol = itemRec.indexOf("expiryDate");
    int posXCol = itemRec.indexOf("posX");
    int posYCol = itemRec.indexOf("posY");
    //int placePathCol = itemRec.indexOf("placePath");
    while (q.next()) {
        QString barcode = q.value(barcodeCol).toString();
        QString name = q.value(nameCol).toString();
        QString scientificName = q.value(scientificNameCol).toString();
        QString discription = q.value(discriptionCol).toString();
        QUrl imagePath = q.value(imagePahtCol).toUrl();
        int sellingPrice = q.value(sellingPriceCol).toInt();
        int invoicePrice = q.value(invoicePriceCol).toInt();
        int amount = q.value(amountCol).toInt();
        int bonus = q.value(bonusCol).toInt();
        int expiryDate_julian = q.value(expiryDateCol).toInt();
        QDate expiryDate = QDate::fromJulianDay(expiryDate_julian);
        int posX = q.value(posXCol).toInt();
        int posY = q.value(posYCol).toInt();

        QUrl placePath;
        QStringList tags;

        QSqlQuery placePathQuery = db.exec("SELECT placePath, barcode FROM places NATURAL JOIN placesitems NATURAL JOIN items WHERE barcode = \"" + barcode + "\";");
        QSqlRecord placePathRec = placePathQuery.record();
        int placePathCol = placePathRec.indexOf("placePath");
        while (placePathQuery.next()) placePath = placePathQuery.value(placePathCol).toUrl();
//        std::cout << placePath.path().toStdString() << std::endl;

        QSqlQuery tagsQuery = db.exec("SELECT tag, barcode FROM tags NATURAL JOIN tagsitems NATURAL JOIN items WHERE barcode = \"" + barcode + "\";");
        QSqlRecord tagsRec = tagsQuery.record();

        int tagCol = tagsRec.indexOf("tag");
        while (tagsQuery.next()) {
            tags << tagsQuery.value(tagCol).toString();
        }

//        qDebug() << q.lastError();
        _pharmItems.append(new PharmItem(barcode,
                                         name,
                                         scientificName,
                                         discription,
                                         imagePath,
                                         sellingPrice,
                                         invoicePrice,
                                         amount,
                                         bonus,
                                         expiryDate,
                                         tags,
                                         posX,
                                         posY,
                                         placePath
                                         ));
    }
    //qSort(_pharmItems);
}

void PharmData::loadPlacesPaths()
{
    _placesPaths.clear();
    QSqlQuery q = db.exec("SELECT * FROM places");
    QSqlRecord placesRec = q.record();
    int placePathCol = placesRec.indexOf("placePath");
    while(q.next()) {
        _placesPaths.append(q.value(placePathCol).toUrl());
    }
//    _placesPaths.append(new QStringList(pathsList));
    qSort(_placesPaths);
}

bool PharmData::fileExists(QUrl filename)
{
    if(!filename.isLocalFile()) return false;
    if(!filename.isValid()) return false;
    QFile *file = new QFile(filename.path());
    return file->exists();
}

void PharmData::addPlacePath(QUrl url)
{
    QSqlQuery q = db.exec("INSERT INTO places(placePath) VALUES(\"" + url.toString() + "\")");
//    qDebug() << q.lastError();
}

void PharmData::deletePlacePath(QUrl url)
{
    QSqlQuery q = db.exec("DELETE FROM places WHERE placePath=\"" + url.toString() + "\"");
    db.exec("DELETE FROM placesitems WHERE placePath = \"" + url.toString() + "\"");
//    qDebug() << q.lastError();
    qDebug() << "statement: " << "DELETE FROM places WHERE placePath=" << url.path();
}

void PharmData::insertItem(QString barcode, QString name, QString scientificName, QString discription, QUrl imagePath, int sellingPrice, int invoicePrice, int amount, int bonus, QDate expiryDate, QUrl placePath,  int posX, int posY, QStringList tags)
{

    QSqlQuery q_items = db.exec("INSERT OR REPLACE INTO items(barcode, name, scientificName, discription, imagePath, sellingPrice, invoicePrice, amount, bonus, expiryDate, posX, posY) VALUES(\"" + barcode + "\", \"" + name + "\", \"" + scientificName + "\", \"" + discription + "\", \""  + imagePath.toString() + "\", " + QString::number(sellingPrice) + ", " + QString::number(invoicePrice) + ", " + QString::number(amount) + ", " + QString::number(bonus) + ", \"" + QString::number(expiryDate.toJulianDay()) + "\", " + QString::number(posX )+ ", " + QString::number(posY) + ")");
    QSqlQuery q_places = db.exec("SELECT * FROM places WHERE placePath =\"" + placePath.toString() + "\"");
    QSqlRecord r_places = q_places.record();

    int placeId = 0;
    bool gotPlaces = false;
    int idCol = r_places.indexOf("placeId");
    while(q_places.next()) {
        gotPlaces = true;
        placeId = q_places.value(idCol).toInt();
    }
//    q_places = db.exec("INSERT OR REPLACE INTO placesitems(placeId, barcode) VALUES (""" + QString::number(placeId) + " \",  \"" + barcode + "\")");
    if(gotPlaces ) {
        QSqlQuery q_plc = db.exec("INSERT OR REPLACE INTO placesitems(placeId, barcode) VALUES(" + QString::number(placeId) + ", \"" + barcode + "\")");
        qDebug() << "placesitems statement: " << "INSERT INTO placesitems(placeId, barcode) VALUES (" + QString::number(placeId) + ", \"" + barcode + "\")";
//        qDebug() << q_places.lastError();
    } else {
        qDebug() << "PharmData: No place has been found holding this Id.";
    }
    for(int i = 0; i < tags.length(); i++) {
        QSqlQuery q_tags = db.exec("INSERT INTO tags(tag) VALUES(\"" + tags[i] + "\")");

    }
    int tagId;
    for(int i = 0; i < tags.length(); i++) {
        QSqlQuery q_tags = db.exec("SELECT * FROM tags WHERE tag=\"" + tags.at(i) + "\"");
        QSqlRecord r_tags = q_tags.record();
        unsigned int idCol = r_tags.indexOf("tagId");
        while (q_tags.next()) tagId = q_tags.value(idCol).toInt();
        q_tags = db.exec("INSERT INTO tagsitems(tagId, barcode) VALUES(" + QString::number(tagId) + ", \"" + barcode + "\")");
    }
}

void PharmData::saveBill(QObject* bill_obj)
{
    PharmBill *bill = (PharmBill*) bill_obj;
//    PharmBill bill = *bill_ptr;
    QSqlQuery q_bills = db.exec("INSERT INTO bills(discription) VALUES(\"" + bill->discription() + "\")");
//    qDebug() << q_bills.lastError();
    int billId;
    QSqlQuery q_getLastbill = db.exec("SELECT billId FROM bills order by billId DESC limit 1");
    QSqlRecord r_lastBill = q_getLastbill.record();
    unsigned int idCol = r_lastBill.indexOf("billId");
    while(q_getLastbill.next()) billId = q_getLastbill.value(idCol).toInt();
//    qDebug() << "billId: " << billId;
    QSqlQuery q_billItems;
    for(int i=0; i < bill->billItems().length(); i++) {
        q_billItems = db.exec("INSERT INTO billitems(barcode, amount, sellingPrice, invoicePrice) VALUES(\""+ bill->billItems()[i].barcode() + "\", " + QString::number(bill->billItems()[i].amount()) + ", " + QString::number(bill->billItems()[i].sellingPrice()) + ", " + QString::number(bill->billItems()[i].invoicePrice()) + ")" );
        qDebug() << q_billItems.lastError();
    }
    //int itemIds[bill->billItems().length()];
    int *itemIds = (int*)malloc(bill->billItems().length() * sizeof(int));
    QSqlQuery q_lastItems = db.exec("SELECT itemId FROM billitems order by itemId DESC limit " + QString::number(bill->billItems().length()));
    QSqlRecord r_lastItems = q_lastItems.record();
    unsigned int itemIdCol = r_lastBill.indexOf("itemId");
    int j = 0;
    while(q_lastItems.next()) {
        itemIds[j] = q_lastItems.value(itemIdCol).toInt();
        j++;
    }
    for(int i=0; i < bill->billItems().length(); i++) {
        QSqlQuery q_billsbillitems = db.exec("INSERT INTO billsbillitems(billId, itemId) VALUES(" + QString::number(billId) + ", " + QString::number(itemIds[i]) + ")");
    }
    QSqlQuery q_billsdate = db.exec("INSERT INTO billsdate(billDate, billId) VALUES(\"" + QString::number(QDate::currentDate().toJulianDay()) + "\", " + QString::number(billId) + ")");
}

bool PharmData::deleteItem(QString barcode)
{
    //??? not tested
    db.exec("DELETE FROM items WHERE barcode = \"" + barcode + "\"");
    db.exec("DELETE FROM placesitems WHERE barcode = \"" + barcode + "\"");
    db.exec("DELETE FROM tagsitems WHERE barcode = \"" + barcode + "\"");
    return true;
}

void PharmData::updateItem(QString barcode, QString name, QString scientificName, QString discription, QUrl imagePath, int sellingPrice, int invoicePrice, int amount, int bonus, QDate expiryDate, QUrl placePath, int posX, int posY, QStringList tags)
{
    QString items_string = "UPDATE items SET ";
}

void PharmData::updateItem(PharmItem item)
{

}

