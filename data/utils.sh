# the following is a library of useful snippets, it is
# meant to be used in a controlled way, line-by-line - not as a wholesale script to just run through
# you need to have the right prereqs, be in the right directory, etc etc

# extract the text from the aws transcript files
extract() {
    for f in *.json; do cat $f | jq '.results.transcripts.[0].transcript' >$f.txt; done
}

# change name of all files from *.json.txt to *.txt
unjson() {
    for f in *.json.txt; do mv $f $(echo $f | cut -d"." -f1,3); done
}

# split the text files into 1k chunks
chunk() {
    cd split
    for f in ../*.txt; do
        mkdir $f.dir
        split -b1k $f
        mv * $f.dir
    done
    cd ..
}

# insert speaker name in the beginning of each file:
# we make the first file (xaa) exempt, since we're sure Lex is the speaker there

insert_speaker() {
    for d in *.dir; do
        spkr=$(echo $d | cut -d"." -f1 | cut -d"_" -f3,4 | tr "_" " ")
        cd $d
        mv xaa ..
        for f in *; do
            echo $spkr: >$f.txt
            echo $spkr
            cat $f >>$f.txt
            rm $f
        done
        mv ../xaa ./xaa.txt
        cd ..
    done
}

# check
check() {
    more *.dir/xa[ab].txt
}
