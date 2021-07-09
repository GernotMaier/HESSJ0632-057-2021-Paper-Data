LL=$(find . -name "*VTS*.ecsv")
for L in $LL
do
    D=$(basename $L .ecsv)
    D=${D/HESSJ0632p057./}
    D=${D/MJD/}
    D=${D/MJD/}
    D=${D/VTS./VERITAS-MJD}
    D=${D/.spectrum/-spectrum.ecsv}
    echo "$L $D"
    cp $L $D.temp
    cat $D.temp  | grep -v "UL" | grep -v "meta" > $D
done

