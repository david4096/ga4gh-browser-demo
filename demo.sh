# GA4GH Browser Demo 8-2-2016 5:32pm

# I'm running on a mac with homebrew, python, and virtual environment installed.
echo "-. .-.   .-. .-.   .-. .-.   .
||\|||\ /|||\|||\ /|||\|||\ /|
|/ \|||\|||/ \|||\|||/ \|||\||
~   \`-~ \`-\`   \`-~ \`-\`   \`-~ \`-"
rm -rf ga4gh-browser-demo

# First thing would be to clone this repository.
git clone https://github.com/david4096/ga4gh-browser-demo.git
cd ga4gh-browser-demo
virtualenv env
source env/bin/activate
pip install ga4gh
ga4gh_server # is now installed and will tell us it's useless without data

# We need to initialize the registry for this server instance.
mkdir ga4gh-example-data
ga4gh_repo init ga4gh-example-data/registry.db
# And add a dataset
ga4gh_repo add-dataset ga4gh-example-data/registry.db browser-demo

# This demo is going to be mostly of variant data, but I have a reference
# on my machine I'd like to use. I haven't inspected what references the other
# data are mapped to, so hopefully we get lucky with NCBI37.
echo "Adding a reference set..."
ga4gh_repo add-referenceset ga4gh-example-data/registry.db /Users/david/data/1000genomes/hs37d5.fa.gz --name NCBI37

# Now we can start looking for variant sets and trying to usefully name them!
# Since I don't have hive I'll build out what I can figure out from the paths and
# see if it works tomorrow.

# I'm pretty confident I can use the 1kgenomes VCF, at least phase-3, without issue.
echo "Adding 1kgenomes phase3 variant set..."
ga4gh_repo add-variantset ga4gh-example-data/registry.db brca1 /hg19/1000Genomes/phase3 --referenceSetName NCBI37

# The nested folders might gunk things up, but let's try the outer directory too.
echo "Adding 1kgenomes phase1 variant set..." 
ga4gh_repo add-variantset ga4gh-example-data/registry.db brca1 /hg19/1000Genomes --referenceSetName NCBI37

# This directory, which if I don't look up will make me look incredibly stupid,
# looks interesting.

ga4gh_repo add-variantset ga4gh-example-data/registry.db brca1 /hg19/evs --referenceSetName NCBI37
