# import pandas as pd
# import torch
# from transformers import AutoModel, AutoTokenizer, pipeline

# # ✅ 모델 로딩
# print("✅ KoSimCSE 모델 로딩 중...")
# model = AutoModel.from_pretrained('BM-K/KoSimCSE-roberta-multitask')
# tokenizer = AutoTokenizer.from_pretrained('BM-K/KoSimCSE-roberta-multitask')
# summarizer = pipeline("summarization", model="digit82/kobart-summarization")

# # ✅ 데이터 로딩
# df = pd.read_csv("./cached/policy_cached.csv")
# corpus = df['combined'].tolist()

# # ✅ 유틸: 임베딩 + 코사인 유사도 함수
# def get_embedding(text):
#     inputs = tokenizer(text, return_tensors="pt", truncation=True, padding=True)
#     with torch.no_grad():
#         model_output = model(**inputs, return_dict=True)
#     return model_output.pooler_output[0]

# def cal_score(a, b):
#     a_norm = a / a.norm()
#     b_norm = b / b.norm()
#     return torch.dot(a_norm, b_norm) * 100

# # ✅ 사전 임베딩 생성
# corpus_embeddings = [get_embedding(text) for text in corpus]

# # ✅ 검색 함수
# def search_policy_and_generate_reason(query: str):
#     query_embedding = get_embedding(query)
    
#     # 유사도 계산
#     scores = [cal_score(query_embedding, emb).item() for emb in corpus_embeddings]
#     top_indices = sorted(range(len(scores)), key=lambda i: scores[i], reverse=True)[:6]

#     result_list = []

#     for index in top_indices:
#         row = df.iloc[index]
#         title = row['pstTtlNm']
#         content = row['pstCn']
#         similarity = round(scores[index], 2)
#         date_raw = row.get('pstRegYmd', '')
#         proposer = row.get('operInstNm', '')

#         # 날짜 변환
#         if pd.notnull(date_raw):
#             try:
#                 date_str = str(int(date_raw))
#                 date = f"{date_str[:4]}.{date_str[4:6]}.{date_str[6:]}" if len(date_str) == 8 else "날짜 형식 오류"
#             except:
#                 date = "날짜 변환 실패"
#         else:
#             date = "날짜 없음"

#         # 요약
#         if len(content.strip()) < 50:
#             summary = content.strip()
#         else:
#             summary_obj = summarizer(content, max_length=150, min_length=60, do_sample=False)
#             summary = summary_obj[0]['summary_text']

#         # 카테고리 분류
#         if any(word in content for word in ['학교', '수업', '학생']):
#             category = '학교생활'
#         elif any(word in content for word in ['지역', '주민', '마을']):
#             category = '지역사회'
#         elif any(word in content for word in ['문화', '예술', '전시', '공연']):
#             category = '문화생활'
#         elif any(word in content for word in ['문제', '위기', '범죄', '갈등']):
#             category = '사회문제'
#         else:
#             category = '기타'

#         result_list.append({
#             "title": title,
#             "similarity": similarity,
#             "summary": summary,
#             "category": category,
#             "date": date,
#             "proposer": proposer
#         })

#     return {
#         "query": query,
#         "results": result_list
#     }

import pandas as pd
import torch
from transformers import AutoModel, AutoTokenizer, pipeline

# ✅ 모델 로딩
print("✅ KoSimCSE 모델 로딩 중...")
model = AutoModel.from_pretrained('BM-K/KoSimCSE-roberta-multitask')
tokenizer = AutoTokenizer.from_pretrained('BM-K/KoSimCSE-roberta-multitask')
summarizer = pipeline("summarization", model="digit82/kobart-summarization")

# ✅ 데이터 및 임베딩 로딩
df = pd.read_csv("./cached/정책_통합.csv")
corpus_embeddings = torch.load("./cached/embeddings2.pt")  # ← 사전 저장한 임베딩 불러오기

# ✅ 임베딩 + 유사도 함수
def get_embedding(text):
    inputs = tokenizer(text, return_tensors="pt", truncation=True, padding=True)
    with torch.no_grad():
        output = model(**inputs, return_dict=True)
    return output.pooler_output[0]

def cal_score(a, b):
    a_norm = a / a.norm()
    b_norm = b / b.norm()
    return torch.dot(a_norm, b_norm) * 100

# ✅ 검색 함수
def search_policy_and_generate_reason(query: str):

    query_embedding = get_embedding(query)

    # 유사도 계산
    scores = [cal_score(query_embedding, emb).item() for emb in corpus_embeddings]
    MIN_SIMILARITY = 10.0
    top_indices = sorted(range(len(scores)), key=lambda i: scores[i], reverse=True)
    top_indices = [i for i in top_indices if scores[i] >= MIN_SIMILARITY][:6]

    result_list = []

    for index in top_indices:
        row = df.iloc[index]
        title = row['pstTtlNm']
        content = row['pstCn']
        similarity = round(scores[index], 2)
        date_raw = row.get('pstRegYmd', '')
        proposer = row.get('operInstNm', '')

        # ✅ 날짜 형식 변환
        if pd.notnull(date_raw):
            try:
                date_str = str(int(date_raw))
                date = f"{date_str[:4]}.{date_str[4:6]}.{date_str[6:]}" if len(date_str) == 8 else "날짜 형식 오류"
            except:
                date = "날짜 변환 실패"
        else:
            date = "날짜 없음"

        # ✅ 요약
        if len(content.strip()) < 50:
            summary = content.strip()
        else:
            summary_obj = summarizer(content, max_length=150, min_length=60, do_sample=False)
            summary = summary_obj[0]['summary_text']

        # ✅ 카테고리 분류
        if any(word in content for word in ['학교', '수업', '학생']):
            category = '학교생활'
        elif any(word in content for word in ['지역', '주민', '마을']):
            category = '지역사회'
        elif any(word in content for word in ['문화', '예술', '전시', '공연']):
            category = '문화생활'
        elif any(word in content for word in ['문제', '위기', '범죄', '갈등']):
            category = '사회문제'
        else:
            category = '기타'

        result_list.append({
            "title": title,
            "similarity": similarity,
            "summary": summary,
            "category": category,
            "date": date,
            "proposer": proposer
        })

    return {
        "query": query,
        "results": result_list
    }
