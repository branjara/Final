CC=nvcc
DEBUG=-g
LIBS= -lgtest -lpthread -std=c++11
CFLAGS=

install: hypothesis_test.cu
	$(CC) -o hypothesis_test hypothesis_test.cu

run: 
	./hypothesis_test

test: test.cu final.cu
	$(CC) -o test test.cu $(LIBS)


