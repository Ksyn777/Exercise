cmake_minimum_required(VERSION 3.14)
project(WZORCE_PROJEKTOWE)

SET(CMAKE_CXX_STANDARD 17)
SET(CMAKE_CXX_STANDARD_REQUIRED ON)

include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/03597a01ee50ed33e9dfd640b249b4be3799d395.zip
  DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

add_executable(run_tests 
          testyWzorce.cpp 
          Strategia.cpp) 

target_link_libraries(run_tests gtest_main)

include(GoogleTest)