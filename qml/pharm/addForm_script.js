function reset() {

    // clear the input fields
    barcode_txt.text = ""
    name_txt.text = ""
    scientificName_txt.text = ""
    tags_txt.text = ""
    discription_area.text = ""
    sellingPrice_spin.value = 0
    invoicePrice_spin.value = 0
    amount_spin.value = 0
    bonus_spin.value = 0
    year_combo.currentIndex = 0
    month_combo.currentIndex = 0
    imagePath_btn.text = "Image Path ..."
    place_btn.text = "Place..."

    // clear saved properties
    barcode = ""
    name = ""
    scientificName = ""
    tags_txt = ""
    discription = ""
    imageUrl = ""
    sellingPrice = 0
    invoicePrice = 0
    amount = 0
    bonus = 0
    year_index = 0
    month_index  = 0
    placeUrl = ""
    posX = 0
    posY = 0
}
