function updateListModel() {
    lm.clear();

    PharmData.loadPharmItems();
    for(var i = 0; i < PharmData.pharmItems.length; i++) {
        lm.append({"barcode": PharmData.pharmItems[i].barcode, "name": PharmData.pharmItems[i].name, "sellingPrice": PharmData.pharmItems[i].sellingPrice + " IQD", "invoicePrice": PharmData.pharmItems[i].invoicePrice + " IQD", "placePath": PharmData.pharmItems[i].placePath, "imagePath": PharmData.pharmItems[i].imagePath});
    }
}
