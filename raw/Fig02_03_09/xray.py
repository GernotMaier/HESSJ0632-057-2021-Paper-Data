#!/usr/bin/python

import csv
import sys

def readXrayRatesFromCSVFile(filecsv ):
    """read X-ray rates from ascii file given by Leicester online analysis
    open file and read Swift data from rate file:
     - ignore all lines with '!'
     - (note that the data files need manual removal of spaces
      before '!')
     - remove '!' before header line
     - note spaces in row titles
     - accept a random number of spaces as delimiter

     note: rates are called fluxes here...
    """
    fp = open(filecsv)
    rdr = csv.DictReader(
        filter(
            lambda row: row[0] != '#',
            fp),
#        delimiter='\t',
        delimiter=" ",
        skipinitialspace=True)
    f = {}
    f['MJD'] = []
    f['MJD_err'] = []
    f['flux'] = []
    f['flux_errp'] = []
    f['flux_errn'] = []
    for row in rdr:
        rowobsid=row["ObsID"]
        if rowobsid.find( "xmm" ) >= 0:
            instrument="xmm"
            obsid="nan"
        elif rowobsid.find( "suz" ) >= 0:
            instrument="suzaku"
            obsid="nan"
        elif rowobsid.find( "N" ) >= 0:
            instrument="nustar"
            obsid="nan"
        elif rowobsid.find( "C" ) >= 0:
            instrument="chandra"
            obsid="nan"
        else:
            instrument="xrt"
            obsid=rowobsid
        print("%s  %s  %f  %.3e  %.3e  %.3e" %
        (instrument,
         obsid,
         float(row["MJD"]),
         pow(10.,float(row["Flux"])),
         pow(10.,float(row["Flux_min"])),
         pow(10.,float(row["Flux_max"])),
         ))


def main(argv):
    """
    rewrite X-ray data in an appropriate way for publication
    """
    readXrayRatesFromCSVFile("xray-20190225.dat")


if __name__ == "__main__":
    main(sys.argv[1:])
