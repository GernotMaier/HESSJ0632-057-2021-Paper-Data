LL=$(find . -name "*XRT*.ecsv")
for L in $LL
do
    D=$(basename $L .ecsv)
    D=${D/HESSJ0632p057./}
    D=${D/XRT./XRT-MJD}
    D=${D/.spectrum/-spectrum.csv}
    echo "$L $D"
    cp $L $D
done

