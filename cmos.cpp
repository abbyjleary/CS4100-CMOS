#include <fstream>
#include <cctype>
#include <vector>
#include <iostream>
#include <string>
#include <algorithm>
#include <sstream>
#include <map>
#include <functional>

using namespace std;

struct match {
    int file1;
    int file2;
    float percentage;
};

long long fingerprint(int start, vector<long long> &hashes, int window);
float calculateMatch(vector<long long> v1, vector<long long>v2);
bool match_greater(match a, match b);

int main()
{
    int k = 15; //size of kgram
    int w = 30; //window size


    // get tokens from file
    ifstream inStr;
    inStr.open("tokens.txt");
    vector<vector<long long> > hashes;
    vector<vector<long long> > fingerprints;
    stringstream ss;
    string line;
    string name;
    string tmp;
    string kgram;
    while (getline(inStr, line)) // one line of tokens per file
    {
        stringstream ss(line);
        getline(ss, line);
        stringstream ss2(line);
        ss2 >> name >> tmp;
        vector<long long> hash;
        //split into k-grams
        for (int i = 0; i <= (tmp.length() - k); i++){
            kgram = tmp.substr(i, k);
            //hash and store
            hash.push_back(stoll(kgram));
        }
        hashes.push_back(hash); // push all of this file's hashes to the masterlist
    }

    //get fingerprints
    for (int i = 0; i < hashes.size(); i++){ //iterate through each file
        vector<long long> fileFingerprints;
        for (int j = 0; j <= (hashes[i].size() - w); j++){
            fileFingerprints.push_back( fingerprint(j, hashes[i], w) );
        }
        fingerprints.push_back(fileFingerprints);
    }
    
    //compare fingerprints
    vector<match> comparisons;
    for (int i = 0; i < (fingerprints.size() - 1); i++){ // avoid repeat comparisons by excluding final file
        for (int j = i+1; j < fingerprints.size(); j++){ // start at i to avoid repeats
            match comp;
            comp.file1 = i;
            comp.file2 = j;
            comp.percentage = calculateMatch(fingerprints[i], fingerprints[j]);
            comparisons.push_back(comp);
        }
    }

    //sort comparisons
    sort(comparisons.begin(), comparisons.end(), match_greater);

    //print out report 
    cout << "File 1  File 2  Percent Similarity" << endl;
    for (int i = 0; i < comparisons.size(); i++){
        cout << comparisons[i].file1 << "\t" << comparisons[i].file2 << "\t" << comparisons[i].percentage << "%" << endl;
    }

    return 0;
}

long long fingerprint(int start, vector<long long> &hashes, int window){
    long long min = hashes[start];

    for (int i = start; i < (start + window); i++){
        if (hashes[i] < min){
            min = hashes[i];
        }
    }

    return min;
}

float calculateMatch(vector<long long> v1, vector<long long>v2){  // sort arrays first?
    int similar = 0;
    sort (v1.begin(), v1.end());
    sort (v2.begin(), v2.end());

    for (int i = 0; i < v1.size(); i++){
        for (int j = i; j < v2.size(); j++){
            if ( v1[i] == v2[j] ){
                similar++;
                break;
            }
        }
    }
    return (similar / static_cast<double>(v1.size()))*100.0;
}

bool match_greater(match a, match b){
    if (a.percentage > b.percentage){
        return true;
    }
    else {
        return false;
    }
}
