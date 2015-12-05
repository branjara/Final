#include <stdio.h>
#include <math.h>
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/iterator/constant_iterator.h>
#include <thrust/transform.h>
#include <thrust/reduce.h>
#include <thrust/functional.h>
#include <thrust/random/linear_congruential_engine.h>
#include <thrust/random/uniform_real_distribution.h> 
#include <thrust/random.h>
#include <iostream>
#define DATA_SIZE 100000000


struct psrngen
{
	__host__ __device__ psrngen(float _a, float _b) : a(_a), b(_b) {;}
	__host__ __device__ float operator()(const unsigned int n) const
	{
		thrust::default_random_engine rng;
		thrust::uniform_real_distribution<float> dist(a, b);
		rng.discard(n);
		return dist(rng);
	}
	float a, b;

};


template <class R, class S, class T>	
T hypothesis_test(R hypothesis_value, T alpha, S test_type){
	
	srand(time(NULL));
	int _seed = rand();
	thrust::device_vector<float> D1(DATA_SIZE);
	thrust::counting_iterator<unsigned int> index_sequence_begin(_seed);
	thrust::transform(	index_sequence_begin, 
				index_sequence_begin + (DATA_SIZE), 
				D1.begin(), 
				psrngen(0.0, 1.0f));
	thrust::device_vector<T> D2(D1.size());


//	for(int j=0; j <D1.size();j++){
//		std::cout <<"D1["<< j <<"] = " << D1[j] << std::endl;
//	}


	T mean = thrust::reduce(	D1.begin(), 
					D1.end(), 
					(T)0, 
					thrust::plus<T>())/D1.size();


	thrust::transform(		D1.begin(), 
					D1.end(), 
					thrust::make_constant_iterator(mean), 
					D1.begin(), 
					thrust::minus<T>());

	thrust::transform(		D1.begin(), 
					D1.end(), 
					D1.begin(), 
					D2.begin(), 
					thrust::multiplies<T>());

	T variance = thrust::reduce(D2.begin(), D2.end(),(T)0, thrust::plus<T>())/(D1.size()-1);
	

	T standard_deviation = sqrt(variance);
	T Z = (mean - hypothesis_value)/(standard_deviation/sqrt(D1.size()));

		
	T left = (0.5)*(1.0 + erf(Z/sqrt(2.0)));
	T right = 1.0 - (0.5)*(1.0 + erf(Z/sqrt(2.0)));
	T two_sided = 2.0*(1.0 - (0.5)*(1.0 + erf(abs(Z)/sqrt(2.0))));
	

	if (test_type == 1){
		if(left < alpha){
			printf("We reject the null hypothesis\n");
				return left; 	 
		}
		else{	
			printf("We fail to reject the null hypothesis\n");
				return left;
		}
	}

	else if(test_type == 2){
		if(right < alpha){
			printf("We reject the null hypothesis \n");
				return right;
		}
		else{
			printf("We fail to reject the null hypothesis \n");
				return right;
		}
	}

	else if(test_type == 3){
		if(two_sided < alpha){
			printf("We reject the null hypothesis \n");
				return two_sided;
		}
		else{
			printf("we fail to reject the null hypothesis \n");
				return two_sided;
		}
	}

	else return 0;
	

}	
	
int main(){

	float value = hypothesis_test(0.5,0.05, 3);
	printf("%.4f \n", value);
 
		
}
	





