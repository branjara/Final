#include <stdio.h>
#include <math.h>
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/iterator/constant_iterator.h>
#include <thrust/transform.h>
#include <thrust/reduce.h>
#include <thrust/functional.h>
#define DATA_SIZE 10


template <class R, class S, class T>	
T hypothesis_test(R hypothesis_value, T alpha, S test_type){

	thrust::host_vector<T> data(DATA_SIZE); 
	for (int i=0; i < data.size(); i++){
		data[i] = i + 1;
	}	


	thrust::device_vector<T> D1 = data;
	thrust::device_vector<T> D2(data.size());

	
	T mean = thrust::reduce(	D1.begin(), 
					D1.end(), 
					(T)0, 
					thrust::plus<T>())/data.size();


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

	T variance = thrust::reduce(	D2.begin(), 
					D2.end(),
					(T)0, 
					thrust::plus<T>())/(data.size()-1);

	
	T standard_deviation = sqrt(variance);
	T Z = (mean - hypothesis_value)/(standard_deviation/sqrt(data.size()));
		

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

	





