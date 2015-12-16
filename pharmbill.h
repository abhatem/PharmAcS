#ifndef PHARMBILL_H
#define PHARMBILL_H

#include <QObject>
#include "billitem.h"
//#include "pharmdata.h"
#include <QDate>

class PharmBill : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QList<BillItem> billItems READ billItems WRITE setBillItems NOTIFY billItemsChanged)
    Q_PROPERTY(int totalSellingPrice READ totalSellingPrice WRITE setTotalSellingPrice NOTIFY totalSellingPriceChanged)
    Q_PROPERTY(int totalInvoicePrice READ totalInvoicePrice WRITE setTotalInvoicePrice NOTIFY totalInvoicePriceChanged)
    Q_PROPERTY(QString discription READ discription WRITE setDiscription NOTIFY discriptionChanged)
    Q_PROPERTY(QDate billDate READ billDate WRITE setBillDate)
    Q_PROPERTY(bool returned READ returned WRITE setReturned NOTIFY returnedChanged)

public:
    explicit PharmBill(QObject *parent = 0);

signals:
    void billItemsChanged();
    void totalSellingPriceChanged();
    void totalInvoicePriceChanged();
    void discriptionChanged();
    void returnedChanged();
public slots:
    QList<BillItem> billItems() const { return _billItems; }
    int totalSellingPrice() const { return _totalSellingPrice; }
    int totalInvoicePrice() const { return _totalInvoicePrice; }
    QString discription() const { return _discription; }
    QDate billDate() const { return _billDate; }
    bool returned() const { return _returned; }


    void setBillItems(QList<BillItem> billItems_) { _billItems = billItems_; }
    void setTotalSellingPrice(int totalSellingPrice_) { _totalSellingPrice = totalSellingPrice_; }
    void setTotalInvoicePrice(int totalInvoicePrice_) { _totalInvoicePrice = totalInvoicePrice_; }
    void setDiscription(QString discription_) { _discription = discription_; }
    void setBillDate(QDate billDate_) { _billDate = billDate_; }
    void setReturned(bool returned_) { _returned = returned_; }

    void addItem(QString barcode, int sellingPrice, int invoicePrice, int amount);
    void addItem(BillItem &i);
    void saveBill();

private:
    QList<BillItem> _billItems;
    int _totalSellingPrice;
    int _totalInvoicePrice;
    QString _discription;
    QDate _billDate;
    bool _returned;

};

#endif // PHARMBILL_H
