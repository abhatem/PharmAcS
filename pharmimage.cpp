#include "pharmimage.h"
#include <QDebug>
#include <QPainter>

PharmImage::PharmImage():
    QQuickImageProvider(QQuickImageProvider::Image)
{
}

QImage PharmImage::requestImage(const QString &id, QSize *size, const QSize &requestedSize)
{
    /*
     * thumbnail/file.png
     */
    qDebug() << "id: " << id << "\n";
    qDebug() << "size: (" <<  size->width() << ", " << size->height() << ")";
    qDebug() << "requestedSize: (" <<  requestedSize.width() << ", " << requestedSize.height() << ")";
    (void) size; // to avoid unused variable warnings
    //bool requestedThumb = false;
    if(id.contains('/')) {
        int indexOfSlash = id.indexOf('/');
        qDebug() << "index of /:" << indexOfSlash;
        QString command = id.left(indexOfSlash);
        QString fileUrlString = id.right(id.length() - command.length() - 1);
        QString filename = QUrl(fileUrlString).path();
        qDebug() << "command: " << command;
        qDebug() << "filename: " << filename;
        if(command=="thumbnail"){
            //requestedThumb = true;
            return loadThumbnail(filename, requestedSize.width(), requestedSize.height());
        } else if (command.startsWith("rec")) {
            QString cod_str = command.remove(QRegExp("[rec)(]"));
            qDebug() << "rectangle center: " << cod_str;
            QStringList cod_str_lst = cod_str.split(",");
            QList<int> cod_int_lst;
            for(int i =0; i < cod_str_lst.length(); i++) cod_int_lst.push_back(cod_str_lst[i].trimmed().toInt()); // push the trimmed elements of
                                                                                                                                                                  // cod_str_lst to cod_int_lst
            qDebug() << "cod_int_lst[0]: " << cod_int_lst[0];
            qDebug() << "cod_int_lst[1]: " << cod_int_lst[1];
            return loadRecImage(filename, cod_int_lst[0], cod_int_lst[1]);

        }

    } else {
        return loadImage(id);
    }
}

QImage PharmImage::loadImage(const QString &filename)
{
    //qDebug() << "filename: " << filename << "\n";
    QImage img(filename);
    return img;

}

QImage PharmImage::loadThumbnail(const QString &filename, int width, int height)
{
    QImage img(filename);
    //qDebug() << "filename: " << filename << "\n";
    qDebug() << "widht: " << width;
    qDebug() << "height: " << height;
    // return a scaled image only if sourceWidth and sourceHeight are defined in the qml image element
    if(width > 0 && height > 0)
        img = img.scaled(width, height);
    return img;
}

QImage PharmImage::loadRecImage(const QString &filename, int cntX, int cntY)
{
    QImage img(filename);
    QPainter p(&img);
    p.setBrush(Qt::NoBrush);
    p.setPen(Qt::cyan);
    p.drawRect(cntX-15, cntY-15, 30, 30);
    p.end();
    return img;
}


