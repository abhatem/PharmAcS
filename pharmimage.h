#ifndef PHARMIMAGE_H
#define PHARMIMAGE_H

#include <QQuickImageProvider>
#include <QImage>

class PharmImage : public QQuickImageProvider
{
public:
    PharmImage();
    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);

private:
    QImage loadImage(const QString& filename);
    QImage loadThumbnail(const QString &filename, int width, int height);
    QImage loadRecImage(const QString& filename, int cntX, int cntY);
};

#endif // PHARMIMAGE_H
