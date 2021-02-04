# MK pipeline for comparative population genomics collaboration 

Pipeline to filter VCFs, annotate variants with snpEff, and produce MK tables for downstream analyses. Currently refactoring into Snakemake pipeline. 

Authors: 


Sara Wuitchik (Postdoctoal associate, Boston University & Harvard University; sjswuit@g.harvard.edu)  

Allison Shultz (Assistant Curator of Ornithology, LA Natural History Museum; ashultz@nhm.org)

Tim Sackton (Director of Bioinformatics, Informatics Group, Harvard University; tsackton@g.harvard.edu)

## Configuration and set up

First, set up a conda environment that will allow access to python and R packages:

```conda create -n mk -c bioconda snakemake cyvcf2 tqdm bcftools vcftools htslib java-jdk bedtools r-base r-tidyverse r-rjags r-r2jags r-lme4 r-arm```

```conda activate mk```

### SnpEff

We use SnpEff (http://snpeff.sourceforge.net/download.html) to build databases and annotate the variants in the VCFs. It should be downloaded in your project directory and set up prior to running the pipeline.

```wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip```

```unzip snpEff_latest_core.zip```

```rm snpEff_latest_core.zip``` 

```cd snpEff/```

```mkdir -p data/ingroup_species_name/```

Ensure reference sequence (FASTA) and genome annotation (GFF3) are in the appropriate data directory, rename files to sequences.fa and genes.gff, then gzip.

#### Add genome information to config file

Add the following to the snpEff.config file, under the Databases & Genomes - Non-standard Genomes section:

\# Common name genome, Source and Version

ingroup_species_name.genome : genome_name

For example: 

\# Black-headed duck genome, NCBI version 1

hetAtr.genome : Heteronetta_atricapilla


#### Build a snpEff database

From the snpEff directory, run: 

```java -jar snpEff.jar build -gff3 -v ingroup_species_name```  

For example:  

```java -jar snpEff.jar build -gff3 hetAtr```

### In your working directory, you'll need: 

- single VCF for each of the ingroup and outgroup species  

- Missingness data for both ingroup and outgroup

- Coverage site data for both ingroup and outgroup

- genes.gff (same file that's in the snpEff data directory, uncompressed)

- genenames.py

- gff2bed.awk

- annot_parser.py

- my.jags2.R 

- SnIPRE_source.R

- missingness.R

- prep_snipre.R  

- run_snipre.R
