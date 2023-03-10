# Set the location to the folder containig index file, data folder and output folder.
Set-Location "Y:\DATA\"

# Get paths of each sample.
$locNamesData = Get-ChildItem -Path data\ -Name
$locNamesOutput = Get-ChildItem -Path data\ -Name

# Get full path of each file of all samples and loop kallisto through samples.
for ($i=0; $i -lt $locNamesData.Length; $i++) {
   
   
    # Define data and output folders
    $locNamesData[$i] = Join-Path -Path "data\" -ChildPath $locNamesData[$i]
    $locNamesOutput[$i] = Join-Path -Path "output\" -ChildPath $locNamesOutput[$i]
    
    # Get names of files of each sample
    $sampleNames = Get-ChildItem $locNamesData[$i] | ForEach-Object { $_.FullName }

    "Analysing the following samples:"
    $sampleNames
    "Output:"
    $locNamesOutput[$i]

    # Run kallisto on all files of one sample using the human cDNA index file obtained from http://www.ensembl.org/info/data/ftp/index.html.
    kallisto quant -i hsGRCh38_kallisto -t 8 -b 100 -o $locNamesOutput[$i] $sampleNames

} 

"Done with analaysis! Exiting script."

