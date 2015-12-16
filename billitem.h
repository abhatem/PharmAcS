#ifndef BILLITEM_H
#define BILLITEM_H

#include <QObject>

class BillItem : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString barcode READ barcode WRITE setBarcode)
    Q_PROPERTY(int sellingPrice READ sellingPrice WRITE setSellingPrice)
    Q_PROPERTY(int invoicePrice READ invoicePrice WRITE setInvoicePrice)
    Q_PROPERTY(int amount READ amount WRITE setAmount)
public:
    explicit BillItem(QObject *parent = 0);
    BillItem(const BillItem &item);
    BillItem(QString barcode, int sellingPrice, int invoicePrice, int amount, QObject *parent = 0);
    BillItem& operator=(const BillItem&);


public slots:
    QString barcode() const {return _barcode;}
    int sellingPrice() const {return _sellingPrice;}
    int invoicePrice() const {return _invoicePrice;}
    int amount() const {return _amount;}

    void setBarcode(QString barcode_) { _barcode = barcode_; }
    void setSellingPrice(int sellingPrice_) { _sellingPrice = sellingPrice_; }
    void setInvoicePrice(int invoicePrice_) { _invoicePrice = invoicePrice_; }
    void setAmount(int amount_) { _amount = amount_; }

private:
    QString _barcode;
    int _sellingPrice;
    int _invoicePrice;
    int _amount;

};

#endif // BILLITEM_H
