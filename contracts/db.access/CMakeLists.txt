add_contract(db.access db.access ${CMAKE_CURRENT_SOURCE_DIR}/src/db.access.cpp)

target_include_directories(db.access
   PUBLIC
   ${CMAKE_CURRENT_SOURCE_DIR}/include)

set_target_properties(db.access
   PROPERTIES
   RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")

configure_file( ${CMAKE_CURRENT_SOURCE_DIR}/ricardian/db.access.contracts.md.in ${CMAKE_CURRENT_BINARY_DIR}/ricardian/db.access.contracts.md @ONLY )

target_compile_options( db.access PUBLIC -R${CMAKE_CURRENT_SOURCE_DIR}/ricardian -R${CMAKE_CURRENT_BINARY_DIR}/ricardian )
