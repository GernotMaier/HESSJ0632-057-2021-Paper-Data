#!/bin/sh
#
# copy data files to be published
#
# Extreme care needs to be taken!
set -e

##################################
# data source directory
IDIR="../../VTS-HESSJ0632-057-2020-Paper/"

##################################
# light curve data
echo "****************************"
echo "FIGURE 2"
echo "****************************"
DDIR="Fig02_03_09"
mkdir -p ${DDIR}
rm -rf ${DDIR}/*

# X-ray data
echo "Copying X-ray light curve data"
echo "=============================="
echo "   must be identical to file stated in ${IDIR}/scripts/lightCurveAnalysis/runLightCurveAnalysis.sh"
echo "   assuming here: ${IDIR}/scripts/lightCurveAnalysis/X-ray-datafiles.csv"

cat ${IDIR}/scripts/lightCurveAnalysis/X-ray-datafiles.csv
XrayLC="${IDIR}/data/XRT/xray-20190225.dat"

echo 
echo "   data file for Figure 2 (X-ray data): ${XrayLC} "
cp -v ${XrayLC} ${DDIR}

echo

# Gamma-ray data
echo "Copying G-ray light curve data"
echo "=============================="
echo "   must be identical to file stated in ${IDIR}/scripts/lightCurveAnalysis/runLightCurveAnalysis.sh"
echo "   assuming here: ${IDIR}/scripts/lightCurveAnalysis/Gamma-datafiles_20200629.csv"

cat ${IDIR}/scripts/lightCurveAnalysis/Gamma-datafiles_20200629.csv
HESSLC="${IDIR}/data/HESS/HESS_20201129.dat"
VERITASLC="${IDIR}/data/VTS/VERITAS-LC-20200810.ecsv"
MAGICLC="${IDIR}/data/MAGIC/MAGIC_20daybin_LC_20190429.txt"
echo 

for LC in ${HESSLC} ${VERITASLC} ${MAGICLC}
do
    echo "   data file for Figure 2 (Gamma-ray data): ${LC} "
    cp -v ${LC} ${DDIR}
done

echo

# Optical data
echo "****************************"
echo "FIGURE 4"
echo "****************************"
DDIR="Fig04"
mkdir -p ${DDIR}
rm -fr ${DDIR}/*

echo "Copying Optical light curve data"
echo "=============================="
echo "   must be identical to file stated in ${IDIR}/scripts/lightCurveAnalysis/runOpticalLightCurveAnalysis.sh"
echo "   assuming here: ${IDIR}/scripts/lightCurveAnalysis/Optical-*.csv"

cat ${IDIR}/scripts/lightCurveAnalysis/Optical-*.csv
OLC="${IDIR}/data/Optical/Result_Halpha_20190128.dat"
echo
echo "   data file for Figure 4 (optical data): ${OLC}"
cp -v ${OLC} ${DDIR}

echo
echo "========================================================================================"
echo

# X-ray / gamma-ray correlation
echo "****************************"
echo "FIGURE 5"
echo "****************************"
DDIR="Fig05"
mkdir -p ${DDIR}
rm -fr ${DDIR}/*

# Fig 5 a
echo "Contemporaneous X-ray / gamma-ray data"
echo "Data files prepared by hand"
echo "   run X-ray/G-ray correlation as descriped in"
echo "   generate_all_paper_plots.sh"
echo "    and grep for DG"
echo "    (columns need to be prepared in the file)"

echo "Copying X-ray / gamma-ray correlation data"
echo "=============================="
XGC="${IDIR}/scripts/lightCurveAnalysis/DCF/DCF-cross-Gamma-XRay-HESSJ0632p057.csv"
echo "    assuming here ${XGC}"
echo
echo "   data file for Figure 5 (right; DCF X-ray/G-ray correlation): ${XGC}"
cp -v ${XGC} ${DDIR}
#  cross correlation and confidence levels
for CL in cross CL950 CL990 CL999
do
    CLF="${IDIR}/scripts/lightCurveAnalysis/DCF/DCF-${CL}-Gamma-XRay-HESSJ0632p057.csv"
    echo "    data file for Figure 5 (right; confidence levels): ${CLF}"
    cp -v ${CLF} ${DDIR}
done

##################################
# Optical vs X-ray and G-ray
echo "****************************"
echo "FIGURE 6"
echo "****************************"
echo "Data files prepared by hand"
echo "   run ./runOpticalCorrelationAnalysis.sh"
echo "    and grep for DD"
echo "    (columns need to be prepared in the file)"

##################################
# spectral data
echo "****************************"
echo "FIGURE 7 & 8"
echo "****************************"
DDIR="Fig07_08"
mkdir -p ${DDIR}
rm -fr ${DDIR}/*

# Gamma-ray  / X-ray spectra per phase range (averaged over all orbits)
echo "Copying phase-averaged gamma- and X-ray spectra (Fig 7) and Fig 8"
echo "    must be identical to files stated in ${IDIR}/scripts/spectralAnalysis/runSpectralAnalysis.sh"

for P in PHASERANGE1 PHASERANGE2 PHASERANGE3 PHASERANGE04
do
    echo "  data files for Figure 7, phase range ${P}:"
    for I in MAGIC VTS HESS XRT
    do
        MSED="${IDIR}/data/${I}/HESSJ0632p057.${I}.${P}.spectrum.ecsv"
        if [[ ${P} == "PHASERANGE3" ]] && [[ ${I} == "MAGIC" ]]; then
            continue
        fi
        echo "  ${I}: ${MSED}"
        cp -v ${MSED} ${DDIR}
   done
done

echo "****************************"
echo "FIGURE 10"
echo "****************************"
DDIR="Fig10"
mkdir -p ${DDIR}
rm -fr ${DDIR}/*

# Gamma-ray  / X-ray spectra per phase range (averaged over all orbits)
echo "Copying gamma- and X-ray spectra for orbit 9 and 17 (Fig 10)"
echo "    must be identical to files stated in ${IDIR}/scripts/spectralAnalysis/runSpectralAnalysis_Outburst.sh"

# read csv files to find corresponding data files
for o in 09 17
do
    for s in high low
    do
        F="${IDIR}/data/HESSJ0632p057.SED.Orbit${o}-${s}.dat"
        echo "    reading data files from ${F}"
        while IFS=, read -r col1 col2 col3
        do
            if [[ $col1 == "XRT" ]] || [[ $col1 == "VTS" ]] || [[ $col1 == "MAGIC" ]]; then
                MSED="${IDIR}/data/${col1}/HESSJ0632p057.${col1}.${col2//[[:blank:]]/}.spectrum.ecsv"
                echo ${col1} ${MSED}
                cp -v ${MSED} ${DDIR}
            fi
        done < ${F}
    done
done

echo "****************************"
echo "FIGURE 12"
echo "****************************"
DDIR="Fig12"
mkdir -p ${DDIR}
rm -fr ${DDIR}/*

# Superorbital period (Figure 12d)
echo "Copy super-orbital period data"
cp -v -f ${IDIR}/scripts/lightCurveAnalysis/figures/ToyMC-SuperOrbital-PCC.csv ${DDIR}
cp -v -f ${IDIR}/scripts/lightCurveAnalysis/ToyMC-XRT-nToy1000-beta1.2-superOrbital/ToyMC-PCC-CL.csv ${DDIR}

echo "****************************"
echo "Appendix"
echo "****************************"
DDIR="Auxiliary"
mkdir -p ${DDIR}
rm -fr ${DDIR}/*

# Gamma-ray  / X-ray spectra per MJD range (Appendix)
echo "Copying gamma- and X-ray spectra per MJD range (Appendix)"
echo "    must be identical to files stated in ${IDIR}/scripts/spectralAnalysis/runContemporaneousSED.sh"

MJDDATES="${IDIR}/data/HESSJ0632p057.SED.XRTVTS.dates.dat"
VMJDN=`cat ${MJDDATES} | awk '{print $1'}`
VMJDM=`cat ${MJDDATES} | awk '{print $2'}`
declare -a MJDN=( $VMJDN )
declare -a MJDM=( $VMJDM )
echo "    reading data files from ${MJDDATES}"

#######################
# spectral analysis
# (uncomment if required)

for (( l=0; l < ${#MJDN[@]}; l++ ))
do
    VTSF=HESSJ0632p057.VTS.MJD${MJDN[$l]}-MJD${MJDM[$l]}.spectrum.ecsv
    XRTF=HESSJ0632p057.XRT.${MJDN[$l]}-${MJDM[$l]}.spectrum.ecsv

    echo $VTSF $XRTF $l;
    cp -v ${IDIR}/data/VTS/$VTSF ${DDIR}
    cp -v ${IDIR}/data/XRT/$XRTF ${DDIR}
done
