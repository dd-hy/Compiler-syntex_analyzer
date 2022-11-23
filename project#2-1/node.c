/*
 * Copyright 2020-2022. Heekuck Oh, all rights reserved
 * 이 프로그램은 한양대학교 ERICA 소프트웨어학부 재학생을 위한 교육용으로 제작되었다.
 */
#include <stdio.h>
#include <stdlib.h>
#include "node.h"

// 아래 함수는 필요한 전체 함수 중 극히 일부에 불과하다.
// 학생들은 필요한 함수를 추가한다.

void show_class_list(class_list_t *class_list)
{
	while (class_list != NULL) {
		show_class(class_list->class);
		class_list = class_list->next;
	}
}

void show_class(class_t *class) {
	printf("[%s]",class->type);
	if (class->inherited != NULL)
		printf("[%s]",class->inherited);
	printf("{");
	while (class->feature_list != NULL) {
		show_feature(class->feature_list->feature);
		class->feature_list = class->feature_list->next;
	}
	printf("}\n");
}

void show_feature(feature_t *feature) {
	printf("%s",featre->id);
	if () {
		printf("(");
		while (feature->formal_list != NULL) {
			;
			feature->formal_list = feature->formal_list->next;
		}
		printf(")");
	}
	printf(":[%s]",feature->type);
}
