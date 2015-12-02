#include "final.cu"
#include "gtest/gtest.h" 

TEST(Left_Side, alpha_value_1){
	EXPECT_EQ(0.30075406722029496, hypothesis_test(6.0, 0.05, 1.0));
	}//this should fail to reject

TEST(Left_Side, alpha_value_2){
	EXPECT_EQ(0.30075406722029496, hypothesis_test(6.0, 0.4, 1.0));
	}//this should reject

TEST(Left_Side, hypo_value_1){
	EXPECT_EQ(0.0045117194090401602, hypothesis_test(8.0, 0.05, 1.0));
	}

TEST(Left_Side, hypo_value_2){
	EXPECT_EQ(0.5000, hypothesis_test(5.5, 0.05, 1.0));
	}	

TEST(Left_Side, hypo_value_3){
	EXPECT_EQ(0.94140745640093093, hypothesis_test(4.0, 0.05, 1.0));
	}


TEST(Right_Side, alpha_value_1){
	EXPECT_EQ(0.30075406722029496, hypothesis_test(5.0, 0.05, 2.0));
	}//this shuold fail to reject

TEST(Right_Side, alpha_value_2){
	EXPECT_EQ(0.30075406722029496, hypothesis_test(5.0, 0.4, 2.0));
	}//this should reject

TEST(Right_Side, hypo_value_1){
	EXPECT_EQ(0.99548828059095984, hypothesis_test(8.0, 0.05, 2.0));
	}

TEST(Right_Side, hypo_value_2){
	EXPECT_EQ(0.5000, hypothesis_test(5.5, 0.05, 2.0));
	}

TEST(Right_Side, hypo_value_3){
	EXPECT_EQ(0.058592543599069069, hypothesis_test(4.0, 0.05, 2.0));
	}


TEST(Two_Side, alpha_value_1){
	EXPECT_EQ(0.60150813444058993, hypothesis_test(5.0, 0.05, 3.0));
	}//this shuold fail to reject

TEST(Two_Side, alpha_value_2){
	EXPECT_EQ(0.60150813444058993, hypothesis_test(5.0, 0.7, 3.0));
	}//this should reject

TEST(Two_Side, hypo_value_1){
	EXPECT_EQ(0.0090234388180803204, hypothesis_test(8.0, 0.05, 3.0));
	}

TEST(Two_Side, hypo_value_2){
	EXPECT_EQ(1.0000, hypothesis_test(5.5, 0.05, 3.0));
	}

TEST(Two_Side, hypo_value_3){
	EXPECT_EQ(0.11718508719813814, hypothesis_test(4.0, 0.05, 3.0));
	}


int main(int argc, char**argv){
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();

}


