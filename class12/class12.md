Class 12
================
Amy Prichard
February 20, 2019

``` r
library(bio3d)
pdb.code <- "1hsg"
file.name <- get.pdb(pdb.code)
```

    ## Warning in get.pdb(pdb.code): ./1hsg.pdb exists. Skipping download

``` r
hiv <- read.pdb(file.name)

hiv
```

    ## 
    ##  Call:  read.pdb(file = file.name)
    ## 
    ##    Total Models#: 1
    ##      Total Atoms#: 1686,  XYZs#: 5058  Chains#: 2  (values: A B)
    ## 
    ##      Protein Atoms#: 1514  (residues/Calpha atoms#: 198)
    ##      Nucleic acid Atoms#: 0  (residues/phosphate atoms#: 0)
    ## 
    ##      Non-protein/nucleic Atoms#: 172  (residues: 128)
    ##      Non-protein/nucleic resid values: [ HOH (127), MK1 (1) ]
    ## 
    ##    Protein sequence:
    ##       PQITLWQRPLVTIKIGGQLKEALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYD
    ##       QILIEICGHKAIGTVLVGPTPVNIIGRNLLTQIGCTLNFPQITLWQRPLVTIKIGGQLKE
    ##       ALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYDQILIEICGHKAIGTVLVGPTP
    ##       VNIIGRNLLTQIGCTLNF
    ## 
    ## + attr: atom, xyz, seqres, helix, sheet,
    ##         calpha, remark, call

protein extraction

``` r
prot <- trim.pdb(hiv, "protein")
prot
```

    ## 
    ##  Call:  trim.pdb(pdb = hiv, "protein")
    ## 
    ##    Total Models#: 1
    ##      Total Atoms#: 1514,  XYZs#: 4542  Chains#: 2  (values: A B)
    ## 
    ##      Protein Atoms#: 1514  (residues/Calpha atoms#: 198)
    ##      Nucleic acid Atoms#: 0  (residues/phosphate atoms#: 0)
    ## 
    ##      Non-protein/nucleic Atoms#: 0  (residues: 0)
    ##      Non-protein/nucleic resid values: [ none ]
    ## 
    ##    Protein sequence:
    ##       PQITLWQRPLVTIKIGGQLKEALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYD
    ##       QILIEICGHKAIGTVLVGPTPVNIIGRNLLTQIGCTLNFPQITLWQRPLVTIKIGGQLKE
    ##       ALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYDQILIEICGHKAIGTVLVGPTP
    ##       VNIIGRNLLTQIGCTLNF
    ## 
    ## + attr: atom, helix, sheet, seqres, xyz,
    ##         calpha, call

``` r
prot.filename <- paste0(pdb.code, "_protein.pdb") #paste0() is paste() w/o spaces
write.pdb(prot, file=prot.filename)
```

now the ligand...

``` r
ligand <- trim.pdb(hiv, "ligand")
lig.filename <- paste0(pdb.code, "_ligand.pdb")
write.pdb(ligand, file=lig.filename)
```

Process the output from autodock vina so it can be read by VMD

``` r
# Docking results

res <- read.pdb("all.pdbqt", multi=TRUE)
res
```

    ## 
    ##  Call:  read.pdb(file = "all.pdbqt", multi = TRUE)
    ## 
    ##    Total Models#: 18
    ##      Total Atoms#: 50,  XYZs#: 2700  Chains#: 1  (values: B)
    ## 
    ##      Protein Atoms#: 0  (residues/Calpha atoms#: 0)
    ##      Nucleic acid Atoms#: 0  (residues/phosphate atoms#: 0)
    ## 
    ##      Non-protein/nucleic Atoms#: 50  (residues: 1)
    ##      Non-protein/nucleic resid values: [ MK1 (1) ]
    ## 
    ## + attr: atom, xyz, calpha, call

``` r
write.pdb(res, file="results.pdb")
```

What is the RMSD to the MK1 compound from the crystal structure?

``` r
# Compare docking results
ori <-read.pdb("1hsg_ligand.pdbqt")
rmsd(ori, res)
```

    ##  [1]  0.649  4.206 11.110 10.529  4.840 10.932 10.993  3.655 10.996 11.222
    ## [11] 10.567 10.372 11.019 11.338  8.390  9.063  8.254  8.978

``` r
rmsd(res)
```

    ## Warning in rmsd(res): No indices provided, using the 50 non NA positions

    ##         [,1]   [,2]   [,3]   [,4]   [,5]   [,6]   [,7]   [,8]   [,9]
    ##  [1,]  0.000  4.192 11.044 10.465  4.855 10.855 10.928  3.559 10.925
    ##  [2,]  4.192  0.000 10.399 11.126  5.603 10.166 11.215  5.264 10.243
    ##  [3,] 11.044 10.399  0.000  4.114 10.709  2.956  4.528 10.827  2.694
    ##  [4,] 10.465 11.126  4.114  0.000 10.451  4.848  3.459 10.324  4.915
    ##  [5,]  4.855  5.603 10.709 10.451  0.000 10.312 10.364  5.824 10.331
    ##  [6,] 10.855 10.166  2.956  4.848 10.312  0.000  4.154 10.557  2.483
    ##  [7,] 10.928 11.215  4.528  3.459 10.364  4.154  0.000 10.637  4.507
    ##  [8,]  3.559  5.264 10.827 10.324  5.824 10.557 10.637  0.000 10.714
    ##  [9,] 10.925 10.243  2.694  4.915 10.331  2.483  4.507 10.714  0.000
    ## [10,] 11.118 11.706  4.686  2.560 11.532  5.522  4.853 10.923  5.631
    ## [11,] 10.451 10.943  4.201  2.892 10.613  4.947  4.829 10.274  5.193
    ## [12,] 10.285 10.895  4.591  2.967 10.580  5.646  5.236 10.127  5.875
    ## [13,] 11.046 11.399  8.059  7.417 12.468  9.172  9.375 11.496  9.324
    ## [14,] 11.399 10.863  9.853 10.036 12.697 10.417 11.560 12.017 10.546
    ## [15,]  8.332  9.220 13.010 12.551 11.523 13.075 14.111  9.388 13.155
    ## [16,]  9.090  9.381 12.099 11.856  6.236 11.794 10.842  9.062 11.705
    ## [17,]  8.229  8.558 12.121 11.460 10.968 12.150 12.748  8.145 12.394
    ## [18,]  9.053  9.409 12.616 12.353  6.611 12.187 11.249  9.069 12.022
    ##        [,10]  [,11]  [,12]  [,13]  [,14]  [,15]  [,16]  [,17]  [,18]
    ##  [1,] 11.118 10.451 10.285 11.046 11.399  8.332  9.090  8.229  9.053
    ##  [2,] 11.706 10.943 10.895 11.399 10.863  9.220  9.381  8.558  9.409
    ##  [3,]  4.686  4.201  4.591  8.059  9.853 13.010 12.099 12.121 12.616
    ##  [4,]  2.560  2.892  2.967  7.417 10.036 12.551 11.856 11.460 12.353
    ##  [5,] 11.532 10.613 10.580 12.468 12.697 11.523  6.236 10.968  6.611
    ##  [6,]  5.522  4.947  5.646  9.172 10.417 13.075 11.794 12.150 12.187
    ##  [7,]  4.853  4.829  5.236  9.375 11.560 14.111 10.842 12.748 11.249
    ##  [8,] 10.923 10.274 10.127 11.496 12.017  9.388  9.062  8.145  9.069
    ##  [9,]  5.631  5.193  5.875  9.324 10.546 13.155 11.705 12.394 12.022
    ## [10,]  0.000  2.562  2.373  6.790  9.389 11.938 13.419 11.098 13.886
    ## [11,]  2.562  0.000  2.314  6.932  9.210 11.897 12.536 10.978 13.114
    ## [12,]  2.373  2.314  0.000  6.611  9.120 11.557 12.716 10.658 13.306
    ## [13,]  6.790  6.932  6.611  0.000  5.970  9.604 15.303  9.157 15.716
    ## [14,]  9.389  9.210  9.120  5.970  0.000  8.680 16.356  7.723 16.661
    ## [15,] 11.938 11.897 11.557  9.604  8.680  0.000 16.491  5.612 16.470
    ## [16,] 13.419 12.536 12.716 15.303 16.356 16.491  0.000 15.096  2.121
    ## [17,] 11.098 10.978 10.658  9.157  7.723  5.612 15.096  0.000 15.178
    ## [18,] 13.886 13.114 13.306 15.716 16.661 16.470  2.121 15.178  0.000
