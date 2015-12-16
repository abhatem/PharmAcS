#ifndef PHARMITEM_H
#define PHARMITEM_H

#include <QObject>
#include <QStringList>
#include <QList>
#include <QDate>
#include <QUrl>

class PharmItem : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString barcode READ barcode WRITE setBarcode NOTIFY barcodeChanged)
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString scientificName READ scientificName WRITE setScientificName NOTIFY scientificNameChanged)
    Q_PROPERTY(QString discription READ discription WRITE setDiscription NOTIFY discriptionChanged)
    Q_PROPERTY(QUrl imagePath READ imagePath WRITE setImagePath NOTIFY imagePathChanged)
    // ??? make image path QUrl
    Q_PROPERTY(int sellingPrice READ sellingPrice WRITE setSellingPrice NOTIFY sellingPriceChanged)
    Q_PROPERTY(int invoicePrice READ invoicePrice WRITE setInvoicePrice NOTIFY invoicePriceChanged)
    Q_PROPERTY(int profit READ profit NOTIFY profitChanged)
    Q_PROPERTY(int amount READ amount WRITE setAmount NOTIFY amountChanged)
    Q_PROPERTY(int bonus READ bonus WRITE setBonus NOTIFY bonusChanged)
    Q_PROPERTY(QDate expiryDate READ expiryDate WRITE setExpiryDate NOTIFY expiryDateChanged)
    Q_PROPERTY(QStringList tags READ tags WRITE setTags NOTIFY tagsChanged)
    //Q_PROPERTY(QList<int> pos READ pos WRITE setPos NOTIFY posChanged)
    //Q_PROPERTY(QList<int> pos READ pos WRITE setPos)
    Q_PROPERTY(int posX READ posX WRITE setPosX NOTIFY posXChanged)
    Q_PROPERTY(int posY READ posY WRITE setPosY NOTIFY posYChanged)
    Q_PROPERTY(QUrl placePath READ placePath WRITE setPlacePath NOTIFY placePathChanged)

public:
    explicit PharmItem(QObject *parent = 0);

    PharmItem(QString &barcode, QString &name, QString &scientificName, QString &discription,
              QUrl &imagePath, int sellingPrice, int invoicePrice, int amount, int bonus,
              QDate &expiryDate, QStringList &tags, int posX, int posY, QUrl placePath, QObject *parent = 0);

    PharmItem(const PharmItem &pi);
    PharmItem& operator=(const PharmItem& pi);
    bool operator<(const PharmItem &other);
    bool operator>(const PharmItem &other) {return !operator<(other);}
signals:

    void barcodeChanged(const QString &barcode);
    void nameChanged(const QString &name);
    void scientificNameChanged(const QString &scientificName);
    void discriptionChanged(const QString &discriptionChanged);
    void imagePathChanged(const QUrl &imagePath);
    void sellingPriceChanged(int sellingPrice);
    void invoicePriceChanged(int invoicePrice);
    void profitChanged();
    void amountChanged(int amount);
    void bonusChanged(int bonus);
    void expiryDateChanged(const QDate &expiryDate);
    void tagsChanged(const QStringList &tags);
    //void posChanged(const QList<int> &pos);
    //void posChanged(const QList<int> &pos);
    void posXChanged(const int posX);
    void posYChanged(const int posY);
    void placePathChanged(const QUrl placePath);

public slots:
    // getters
    QString barcode() const {return _barcode;}
    QString name() const {return _name;}
    QString scientificName() const {return _scientificName;}
    QString discription() const {return _discription;}
    QUrl imagePath() const {return _imagePath;}
    int sellingPrice() const {return _sellingPrice;}
    int invoicePrice() const {return _invoicePrice;}
    int profit() const {return _sellingPrice - _invoicePrice;}
    int amount() const {return _amount;}
    int bonus() const {return _bonus;}
    QDate expiryDate() const {return _expiryDate;}
    QStringList tags() const {return _tags;}
    //QString tag(int i) {return _tags[i];}
    //QList<int> pos() {return _pos;}
    //int pos(int i) {if(i < 3) return _pos[i]; else return 4;}
    //QList<int> pos();
    int posX() const { return _posX; }
    int posY() const { return _posY; }
    QUrl placePath() const { return _placePath; }

    // setters
    void setBarcode(const QString &barcode);
    void setName(const QString &name);
    void setScientificName(const QString &scientificName);
    void setDiscription(const QString &discription);
    void setImagePath(const QUrl &imagePath);
    void setSellingPrice(const int sellingPrice);
    void setInvoicePrice(const int invoicePrice);
    void setAmount(const int amount);
    void setBonus(const int bonus);
    void setExpiryDate(const QDate &expiryDate);
    void setTags(const QStringList &tags);
    void setTag(const int i, const QString &tag);
    //void setPos(const QList<int> &pos);
    //void setPos(const QList<int> &pos);
    void setPosX(const int posX);
    void setPosY(const int posY);
    void setPlacePath(const QUrl placePath);
    //void setPos(const int place_id, const int x, const int y);
    //void write();

private:
    QString _barcode;
    QString _name;
    QString _scientificName;
    QString _discription;
    QUrl _imagePath;
    int _sellingPrice;
    int _invoicePrice;
    int _amount;
    int _bonus;
    QDate _expiryDate;
    QStringList _tags;
    int _posX;
    int _posY;
    QUrl _placePath;
};

#endif // PHARMITEM_H
