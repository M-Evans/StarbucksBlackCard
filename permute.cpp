#include <algorithm>
#include <iostream>
#include <iomanip>
#include <vector>
#include <string>

#include <cstdio>
#include <cstdlib>

using namespace std;

int main(int argc, char** argv) {
    if (argc != 3) {
        cerr << "ERROR: incorrect number of arguments" << endl;
        return 1;
    }

    // cmdline args
    string s = argv[1];
    int count = atoi(argv[2]);

    string username, host;
    string permPart, unused;
    unsigned atLoc = s.find('@');
    if (atLoc != string::npos) {
        host = s.substr(atLoc);
    } else {
        cerr << "ERROR: argument is not in email format" << endl;
        return 2;
    }

    username = s.substr(0, atLoc);

    if (username.size() < 10) {
        cerr << "ERROR: email not long enough" << endl;
        return 3;
    }

    unused   = username.substr(0, username.size()-10);
    permPart = username.substr(username.size()-10);

    for (unsigned i = 0; i < count; i++) {
        string perm = permPart;
        vector<bool> v(10);
        unsigned k = i;
        for (unsigned j = 0; k != 0; k /= 2, ++j) {
            if (k % 2 == 1) v.at(j) = true;
        }
        for (unsigned j = 0, k = 0; j < v.size(); j++) {
            if (v.at(j)) {
                perm.insert(perm.size()-1-k, ".");
                k++;
            }
            k++;
        }
        cout << unused + perm + host << endl;
    }

    return 0;
}
