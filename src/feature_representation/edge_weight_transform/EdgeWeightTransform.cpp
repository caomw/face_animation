// This one scales the edge weights of the graph exponentially based on average minimum weights across tracks/shots



//============================================================================
// Name        : EdgeWeightTransform.cpp
// Author      : 
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <iostream>
#include <fstream>
#include <vector>
#include <boost/algorithm/string.hpp>
#include <boost/lexical_cast.hpp>
#include <limits.h>
#include <map>

#include "graph_statistics.hpp"

using namespace std;
using namespace boost;

int main(int argc, char *argv[]) {

	if(argc != 2) {
		cout << "Number of arguments isn't correct \n";
		return -1;
	}
	else {
		cout << "EdgeWeightTransform start!" << endl;
	}

	const string outputLocation       = argv[1];

	string EDGE_WEIGHTS_NAME = outputLocation + "/edgeWeights.txt";
	string PRE_TRANSFORM_EDGE_WEIGHTS_NAME = outputLocation + "/preTransformEdgeWeights.txt";
	string TRANSFORMED_EDGE_WEIGHTS_NAME = outputLocation + "/edgeWeights.txt";

    float across_track_min_weight_avg = get_across_track_min_weight_avg(outputLocation);
	cout << "across_track_min_weight_avg = " << across_track_min_weight_avg << endl;

	int result = rename(EDGE_WEIGHTS_NAME.c_str(), PRE_TRANSFORM_EDGE_WEIGHTS_NAME.c_str());

	if(result != 0) {
		perror("Couldn't move the file");
	}

	ifstream edgeWeightsPtr(PRE_TRANSFORM_EDGE_WEIGHTS_NAME.c_str());
	ofstream transformedEdgeWeightsPtr(TRANSFORMED_EDGE_WEIGHTS_NAME.c_str());

	string line;
	vector<string> lineSplit;

	cout << "Debug 1" << endl;
	if(!edgeWeightsPtr.is_open()){
		cout << "edgeWeights.txt problem" << endl;
		return -1;
	}

	// Number of vertices
	getline(edgeWeightsPtr, line);
	transformedEdgeWeightsPtr << line << endl;


	while(getline(edgeWeightsPtr, line)) {
		split(lineSplit, line, is_any_of("="));
		long double transformedEdgeWeight = lexical_cast<float>(lineSplit[1]);
		//transformedEdgeWeight = 1000 * (1 / (1+exp(-(transformedEdgeWeight-26)/2)) );
		//transformedEdgeWeight = exp(transformedEdgeWeight - 5);
		//transformedEdgeWeight = exp((4*transformedEdgeWeight) - across_track_min_weight_avg);
		transformedEdgeWeight = exp(4*(transformedEdgeWeight- across_track_min_weight_avg));
		transformedEdgeWeightsPtr << lineSplit[0].c_str() << "=" << transformedEdgeWeight << endl;
	}
	transformedEdgeWeightsPtr.close();

	return 0;
}
