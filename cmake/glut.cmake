# #####################################################################
# INTEL CORPORATION PROPRIETARY INFORMATION                            
# This software is supplied under the terms of a license agreement or  
# nondisclosure agreement with Intel Corporation and may not be copied 
# or disclosed except in accordance with the terms of that agreement.  
# Copyright (C) 2014 Intel Corporation. All Rights Reserved.           
# #####################################################################

IF (APPLE)
	FIND_PACKAGE(GLUT REQUIRED)
	FIND_PACKAGE(OpenGL REQUIRED)
	INCLUDE_DIRECTORIES(${GLUT_INCLUDE_DIR})
ELSE(APPLE)
	SET (OPENGL_LIBRARY GL)
	FIND_PACKAGE(GLUT)
	IF (GLUT_FOUND)
		SET(GLUT_LIBRARY glut GLU m)
	ELSE()
		FIND_PATH(GLUT_INCLUDE_DIR GL/glut.h 
			$ENV{TACC_FREEGLUT_INC}
		)
		FIND_PATH(GLUT_LINK_DIR libglut.so
			$ENV{TACC_FREEGLUT_LIB}
		)
		FIND_LIBRARY(GLUT_LIBRARY NAMES libglut.so PATHS $ENV{TACC_FREEGLUT_LIB})
		IF (${GLUT_LIBRARY} STREQUAL "GLUT_LIBRARY-NOTFOUND")
			MESSAGE("-- Could not find GLUT library, even after trying additional search dirs")	
		ELSE()
			#MESSAGE("-- Extended search *DID* find GLUT library in ${GLUT_LIBRARY}")
			SET(GLUT_FOUND ON)
		ENDIF()
	ENDIF()
ENDIF(APPLE)

INCLUDE_DIRECTORIES(${GLUT_INCLUDE_DIR})
LINK_DIRECTORIES(${GLUT_LINK_DIR})
SET(GLUT_LIBRARIES ${GLUT_LIBRARY} ${OPENGL_LIBRARY})
