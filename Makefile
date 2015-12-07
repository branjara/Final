CC=nvcc
DEBUG=-g
LIBS= -lgtest -lpthread -std=c++11
CFLAGS=

install: hypothesis_test.cu install2 
	$(CC) -o hypothesis_test hypothesis_test.cu
 
install2: Gtest.cu final.cu
	$(CC) -o Gtest Gtest.cu $(LIBS)

run:
	./hypothesis_test 

test: 
	./Gtest

random : random.cu 
	$(CC) -o random random.cu
