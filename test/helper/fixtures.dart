final todoRequestData = {
  "structuredQuery": {
    "from": [
      {"collectionId": "tasks"}
    ],
    "where": {
      "fieldFilter": {
        "field": {"fieldPath": "date"},
        "op": "GREATER_THAN_OR_EQUAL",
        "value": {"stringValue": '1675535400'}
      }
    },
    "select": {
      "fields": [
        {"fieldPath": "categoryId"},
        {"fieldPath": "id"},
        {"fieldPath": "name"},
        {"fieldPath": "date"},
        {"fieldPath": "isCompleted"}
      ]
    }
  }
};

const String getTodoRawResponse = '''
[
    {
        "document": {
            "name": "projects/applaudo-todo-app/databases/(default)/documents/tasks/RuqGXHWwEiRR8wjk1fAU",
            "fields": {
                "isCompleted": {
                    "booleanValue": true
                },
                "categoryId": {
                    "stringValue": "New Item"
                },
                "date": {
                    "stringValue": "1675535400"
                },
                "name": {
                    "stringValue": "Newly added item"
                }
            },
            "createTime": "2023-02-05T13:23:08.890356Z",
            "updateTime": "2023-02-05T13:23:27.749124Z"
        },
        "readTime": "2023-02-05T17:31:25.266387Z"
    },
    {
        "document": {
            "name": "projects/applaudo-todo-app/databases/(default)/documents/tasks/Tvwirlt59zP7s0uC38Fm",
            "fields": {
                "name": {
                    "stringValue": "Bak click testing"
                },
                "isCompleted": {
                    "booleanValue": true
                },
                "date": {
                    "stringValue": "1675535400"
                },
                "categoryId": {
                    "stringValue": "IOS"
                }
            },
            "createTime": "2023-02-05T13:13:30.437092Z",
            "updateTime": "2023-02-05T13:13:55.983168Z"
        },
        "readTime": "2023-02-05T17:31:25.266387Z"
    },
    {
        "document": {
            "name": "projects/applaudo-todo-app/databases/(default)/documents/tasks/hm947hp0x3tJV66hf5Lh",
            "fields": {
                "isCompleted": {
                    "booleanValue": true
                },
                "date": {
                    "stringValue": "1675535400"
                },
                "name": {
                    "stringValue": ""
                },
                "categoryId": {
                    "stringValue": ""
                }
            },
            "createTime": "2023-02-05T12:00:08.746627Z",
            "updateTime": "2023-02-05T13:19:21.144958Z"
        },
        "readTime": "2023-02-05T17:31:25.266387Z"
    },
    {
        "document": {
            "name": "projects/applaudo-todo-app/databases/(default)/documents/tasks/juHmjjbJkb1CJjVk26R2",
            "fields": {
                "categoryId": {
                    "stringValue": "Testing"
                },
                "date": {
                    "stringValue": "1675535400"
                },
                "name": {
                    "stringValue": "Todo testing"
                },
                "isCompleted": {
                    "booleanValue": false
                }
            },
            "createTime": "2023-02-05T12:06:50.995064Z",
            "updateTime": "2023-02-05T12:06:50.995064Z"
        },
        "readTime": "2023-02-05T17:31:25.266387Z"
    },
    {
        "document": {
            "name": "projects/applaudo-todo-app/databases/(default)/documents/tasks/lQR0fNI5MMlvZ5nasZ7u",
            "fields": {
                "date": {
                    "stringValue": "1675535400"
                },
                "isCompleted": {
                    "booleanValue": true
                },
                "name": {
                    "stringValue": "Adding todo test 2"
                },
                "categoryId": {
                    "stringValue": "Smoke Testing"
                }
            },
            "createTime": "2023-02-05T12:04:19.166241Z",
            "updateTime": "2023-02-05T13:19:22.694211Z"
        },
        "readTime": "2023-02-05T17:31:25.266387Z"
    },
    {
        "document": {
            "name": "projects/applaudo-todo-app/databases/(default)/documents/tasks/39NEyaUKRm3WhpAqAiRI",
            "fields": {
                "isCompleted": {
                    "booleanValue": true
                },
                "categoryId": {
                    "stringValue": "5CrugqSUMdGsjT6k3q8Q"
                },
                "date": {
                    "stringValue": "1675814400000"
                },
                "id": {
                    "stringValue": "2xslBaG4NMyc2X68Hndo"
                },
                "name": {
                    "stringValue": "Title updated 22"
                }
            },
            "createTime": "2023-02-01T17:19:49.632434Z",
            "updateTime": "2023-02-05T13:13:57.714435Z"
        },
        "readTime": "2023-02-05T17:31:25.266387Z"
    },
    {
        "document": {
            "name": "projects/applaudo-todo-app/databases/(default)/documents/tasks/null",
            "fields": {
                "isCompleted": {
                    "booleanValue": false
                },
                "categoryId": {
                    "stringValue": "Mt3c3RwwW6IwnRfziHhw"
                },
                "name": {
                    "stringValue": "Tes1 a"
                },
                "date": {
                    "stringValue": "1675814400000"
                }
            },
            "createTime": "2023-02-03T21:22:10.415735Z",
            "updateTime": "2023-02-05T11:24:34.636173Z"
        },
        "readTime": "2023-02-05T17:31:25.266387Z"
    },
    {
        "document": {
            "name": "projects/applaudo-todo-app/databases/(default)/documents/tasks/7LVLeY2Lbs8ELm7Tnysh",
            "fields": {
                "isCompleted": {
                    "booleanValue": true
                },
                "categoryId": {
                    "stringValue": "sample"
                },
                "id": {
                    "stringValue": "7LVLeY2Lbs8ELm7Tnysh"
                },
                "date": {
                    "stringValue": "1675893600000"
                },
                "name": {
                    "stringValue": "New task 9"
                }
            },
            "createTime": "2023-02-01T17:33:28.521008Z",
            "updateTime": "2023-02-05T11:58:53.676760Z"
        },
        "readTime": "2023-02-05T17:31:25.266387Z"
    },
    {
        "document": {
            "name": "projects/applaudo-todo-app/databases/(default)/documents/tasks/5whgFYbthKOvotsqgCtN",
            "fields": {
                "categoryId": {
                    "stringValue": "5CrugqSUMdGsjT6k3q8Q"
                },
                "isCompleted": {
                    "booleanValue": false
                },
                "name": {
                    "stringValue": "Taskk "
                },
                "date": {
                    "stringValue": "1675900800000"
                },
                "id": {
                    "stringValue": "5whgFYbthKOvotsqgCtN"
                }
            },
            "createTime": "2023-02-03T11:41:52.087024Z",
            "updateTime": "2023-02-05T11:24:32.840777Z"
        },
        "readTime": "2023-02-05T17:31:25.266387Z"
    },
    {
        "document": {
            "name": "projects/applaudo-todo-app/databases/(default)/documents/tasks/Al6T8c5P08nlnKb3uxMU",
            "fields": {
                "isCompleted": {
                    "booleanValue": false
                },
                "name": {
                    "stringValue": "asd"
                },
                "categoryId": {
                    "stringValue": "6Mbslg2QrqNpKZHPanwn"
                },
                "id": {
                    "stringValue": "Al6T8c5P08nlnKb3uxMU"
                },
                "date": {
                    "stringValue": "1675900800000"
                }
            },
            "createTime": "2023-02-03T08:09:00.865380Z",
            "updateTime": "2023-02-05T11:24:31.500726Z"
        },
        "readTime": "2023-02-05T17:31:25.266387Z"
    }
] 
''';

/// Add todo data

const addTodoRawResponse = '''
{
    "name": "projects/applaudo-todo-app/databases/(default)/documents/tasks/DAIFmugUSWj3xCxjL7DG",
    "fields": {
        "categoryId": {
            "stringValue": "DDQeCPpZATcLfV9U3I0v"
        },
        "date": {
            "stringValue": "1675535400"
        },
        "isCompleted": {
            "booleanValue": false
        },
        "name": {
            "stringValue": "Todo Tetsing 7"
        }
    },
    "createTime": "2023-02-05T18:32:15.491158Z",
    "updateTime": "2023-02-05T18:32:15.491158Z"
}''';

const addTodoRequest = '''{
    "fields": {
                "name": {
                    "stringValue": "Todo Tetsing 7"
                },
                "isCompleted": {
                    "booleanValue": false
                },
                "date": {
                    "stringValue": "1675535400"
                },
               
                "categoryId": {
                    "stringValue": "DDQeCPpZATcLfV9U3I0v"
                }
            }
}''';

const authRawResponse = '''
{
    "kind": "identitytoolkit#VerifyPasswordResponse",
    "localId": "YV3PdE4ezvdqIwvU9DeEtXWd3xC3",
    "email": "test@test.com",
    "displayName": "",
    "idToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjVhNTA5ZjAxOWY3MGQ3NzlkODBmMTUyZDFhNWQzMzgxMWFiN2NlZjciLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vYXBwbGF1ZG8tdG9kby1hcHAiLCJhdWQiOiJhcHBsYXVkby10b2RvLWFwcCIsImF1dGhfdGltZSI6MTY3NTYyNDM2NywidXNlcl9pZCI6IllWM1BkRTRlenZkcUl3dlU5RGVFdFhXZDN4QzMiLCJzdWIiOiJZVjNQZEU0ZXp2ZHFJd3ZVOURlRXRYV2QzeEMzIiwiaWF0IjoxNjc1NjI0MzY3LCJleHAiOjE2NzU2Mjc5NjcsImVtYWlsIjoidGVzdEB0ZXN0LmNvbSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0ZXN0QHRlc3QuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.fJtI-nOELdf2tHo-imKYGF8G21EG_39oJP30ooDjdd9BjJZGuzc6SR_HwwJj-iwTd-3sc5csVYtnQ3VBUpWU7_zfnUisAlurN3ilDYiSGRWBnNi1-D2Lq1evEln4zjONjGnm3RIU6jU7em1dO8Fqcvi7zwKIDE2thmQ9wyoOGc_S8LiS4JEJ0bbXeYdwQevyEsb25r6p63jz0r0kYT_jDFzOAWsDqWcNg_kQo03ePCVtv6FVd5I4xlqTyFvf9WhvsrZPJf-naNufoRE1fVSOg3Q8gRzb6-bAJGhGnOLN8QprwnxkxUkJTdYamX2uJynw0NsxXAddYwbkS5uhi8-akQ",
    "registered": true,
    "refreshToken": "APJWN8cKtvrM-eQbDhc3C-gcuiUkI8fMisphYRRkLVtjxDiHGRjIaMqwjCiz2SGgYwU8K5-OPQkNFgln-ZEC1hFE72oy0jGUYk8sp-ZxNFoOaaAKo_ku7taABnOizKPq8-0O_jKE9u1oeS_pjVsC94u4Vws2TtkfDheD0M_cvw9CERkBfnynzWswGCngUcslitoXvmxrSfzKAjwxx-Qc1449BJA4cUjvYg",
    "expiresIn": "3600"
}
''';

const authRequest = '''
{
    "email": "test@test.com",
    "password": "password",
    "returnSecureToken": true
}
''';

const updateTodoRawResponse = '''
{
    "name": "projects/applaudo-todo-app/databases/(default)/documents/tasks/1axaYZPZUml3pZl5vOkW",
    "fields": {
        "date": {
            "stringValue": "1675449000000"
        },
        "isCompleted": {
            "booleanValue": true
        },
        "categoryId": {
            "stringValue": "DDQeCPpZATcLfV9U3I0v"
        },
        "name": {
            "stringValue": "Update checking2"
        }
    },
    "createTime": "2023-02-04T16:49:48.810250Z",
    "updateTime": "2023-02-05T06:26:04.826981Z"
}
''';

const updateTodoRequest = '''
{
    "fields": {
        "isCompleted": {
                    "booleanValue": true
                },
                "name": {
                    "stringValue": "Update checking2"
                },
                "categoryId": {
                    "stringValue": "DDQeCPpZATcLfV9U3I0v"
                },
                "date": {
                    "stringValue": "1675449000000"
                }
    }
}
''';
