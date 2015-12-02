#include "final.cu"

int main(){
	float p_value = hypothesis_test(5, 0.05, 3);
	printf("%.4f \n", p_value);
}
