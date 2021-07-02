/*
 * Copyright (C) 2020 Xilinx, Inc.  All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * XILINX BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
 * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * Except as contained in this notice, the name of the Xilinx shall not be used
 * in advertising or otherwise to promote the sale, use or other dealings in
 * this Software without prior written authorization from Xilinx.
 */

#include <QApplication>
#include <iostream>
#include "main.h"
#include "pcie_host.h"
#include <QDebug>
 #include <QtConcurrent> 
#include <getopt.h>
#include <stdint.h>

int main(int argc, char *argv[])
{
    int cmd_opt;
    int cmd_opt1;
    QString frmsize = "1920x1080";
    QString frmres = "30";
    while ((cmd_opt =
        getopt_long(argc, argv, "vhc:i:o:c:w:f:r:g:b:s:q:m:e:p:u:d:F:v:n:t:", NULL,
                NULL)) != -1) {
        switch (cmd_opt) {
        case 'd':
            frmsize = strdup(optarg);
            break;

        case 'F':
            frmres = strdup(optarg);
            break;
        }
    };
    optind = 0;

    QApplication a(argc, argv);
    w = new MainWindow;
    if(frmsize.split('x').count() == 2)
        w->getVidFrame0()->setResolution(frmsize.split('x')[0].toInt(),frmsize.split('x')[1].toInt(),frmres.toInt());
    w->getVidFrame0()->config_frame();
    QtConcurrent::run(cmaincall,argc,argv);
    return a.exec();
}
