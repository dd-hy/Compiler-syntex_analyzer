/*
 * Copyright 2020-2022. Heekuck Oh, all rights reserved
 * 이 프로그램은 한양대학교 ERICA 소프트웨어학부 재학생을 위한 교육용으로 제작되었다.
 */
#ifndef _NODE_H_
#define _NODE_H_

// 아래 타입과 함수는 극히 일부에 불과하다.
// 학생들은 필요한 타입과 함수 시그니처를 추가한다.


typedef struct _class_list class_list_t;
typedef struct _class class_t;

typedef struct _feature_list feature_list_t;
typedef struct _feature feature_t;
typedef struct _formal_list formal_list_t;
typedef struct _formal formal_t;
typedef struct _expr_list expr_list_t;
typedef struct _expr expr_t;

struct _class_list {
    class_t *class;
    struct _class_list *next;
};


typedef struct _node {
	struct _node *node;
	struct _node
} node_t;




struct _class {
    char *type;
    char *inherited;

    // feature 목록이 들어갈 수 있도록 추가한다
    struct _feature_list *feature_list;
};

struct _feature_list {
	feature_t *feature;
	struct _feature_list *next;
};

struct _feature {
	char *id;
	char *type;

	struct _formal_list *formal_list;
	struct _expr *expr;
};

struct _formal_list {
	formal_t *formal;
	struct _formal_list *next;
};

struct _formal {
	char *id;
	char *type
};

struct _expr_list {
	expr_t *expr;
	struct _expr_list *next;
};

struct _expr {
	char *id;
	char *type;
	expr_list_t expr_list;

void show_class_list(class_list_t *class_list);
void show_class(class_t *class);
void show_feature_list(feature_list_t *feature_list);
void show_feature(feature_t *feature);
void show_formal_list(formal_list_t *formal_list);
void show_formal(formal_t *formal);
void show_expr_list(expr_list_t *expr_list);
void show_expr(expr_t *expr);

#endif
