#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage:    $0 version"
    echo "Example:  $0 v1.01"
    exit 1
fi

BASE="tiny_temp_sensor"
VER=$1
THEPATH="submission/$VER"
GERBERPATH="$BASE-$VER-gerbers"
KICADPATH="$BASE-$VER-kicad"
DATECODE=`date +%F`
PROJECTWEBSITE="https://github.com/matthewbeckler/TinyTempSensor"

if [ -d $THEPATH ]; then
    echo "Destination directory already exists!"
    echo "You have 5 seconds to control-C me or I'll overwrite whatever's in \"$THEPATH\"!"
    echo -n "5..."
    sleep 1
    echo -n "4..."
    sleep 1
    echo -n "3..."
    sleep 1
    echo -n "2..."
    sleep 1
    echo -n "1..."
    sleep 1
    echo "Deleting everything in $THEPATH"
    rm -rf $THEPATH/*
else
    echo "Creating directory '$THEPATH'..."
    mkdir $THEPATH
fi

# archive the gerber files - once for submission, once for archival purposes
echo "Archiving gerber files for submission..."
mkdir $THEPATH/$GERBERPATH
mv $BASE-Front.gtl $THEPATH/$GERBERPATH/
mv $BASE-Back.gbl $THEPATH/$GERBERPATH/
mv $BASE.drl $THEPATH/$GERBERPATH/
mv $BASE-Mask_Back.gbs $THEPATH/$GERBERPATH/
mv $BASE-Mask_Front.gts $THEPATH/$GERBERPATH/
mv $BASE-PCB_Edges.gbr $THEPATH/$GERBERPATH/$BASE-PCB_Edges.outline
mv $BASE-SilkS_Front.gto $THEPATH/$GERBERPATH/

cd $THEPATH/$GERBERPATH
gerbv * &
sleep 1
zip -r $BASE-$VER.zip *
mv $BASE-$VER.zip ../
cd ../
echo "Archiving gerber files..."
zip -r $BASE-gerbers-$VER.zip $GERBERPATH/
rm -rf $GERBERPATH/
cd ../../

# now to do the kicad files
echo "Archiving kicad files..."
mkdir $THEPATH/$KICADPATH
cp $BASE.{brd,cmp,net,sch} $THEPATH/$KICADPATH/
echo -e "This kicad file archive was generated on $DATECODE.\nFor more details, please visit $PROJECTWEBSITE" > $THEPATH/$KICADPATH/README.txt
cd $THEPATH
zip -r $BASE-kicad-$VER.zip $KICADPATH/
rm -rf $BASE-$VER-kicad/

