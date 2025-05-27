from fastapi import FastAPI, Path
from fastapi.middleware.cors import CORSMiddleware
import openai
import cx_Oracle
import sys

# 한글 터미널 출력
sys.stdout.reconfigure(encoding='utf-8')

# OpenAI 키
client = openai.OpenAI(api_key="api_key")

app = FastAPI()

# CORS 설정
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# 요약 생성 함수
def generate_summary(tagged_comments, model="gpt-3.5-turbo"):
    prompt = (
        "아래는 한 토론글에 달린 [찬성], [반대] 댓글 목록입니다.\n"
        "의견 흐름을 바탕으로 찬성과 반대 양쪽 입장을 중립적으로 500자 이내로 요약해 주세요.\n"
        "댓글 내용:\n\n"
        + "\n".join(tagged_comments)
    )

    print("📄 사용된 프롬프트:\n", prompt)

    try:
        response = client.chat.completions.create(
            model=model,
            messages=[{"role": "user", "content": prompt}],
            max_tokens=500
        )

        result = response.choices[0].message.content.strip()

        if not result:
            result = "요약 생성 실패: GPT 응답이 비어 있습니다."

        return result

    except Exception as e:
        print(f"❌ GPT 호출 오류: {e}")
        return "요약 생성 실패: GPT 오류 발생"

@app.get("/summary/update/{discussion_id}")
def update_summary(discussion_id: int):
    print(f"📥 요약 요청 수신: DISCUSSION_ID = {discussion_id}")

    try:
        dsn = cx_Oracle.makedsn("project-db-campus.smhrd.com", 1523, service_name="xe")
        conn = cx_Oracle.connect(user="hapjeong_24SW_DS_p2_2", password="smhrd2", dsn=dsn)
        cur = conn.cursor()

        # 1️⃣ 댓글 가져오기
        cur.execute("""
            SELECT OPINION_TYPE, CONTENT
            FROM DISCUSSION_COMMENT
            WHERE DISCUSSION_ID = :id
        """, {"id": discussion_id})

        rows = cur.fetchall()
        print(f"✅ 댓글 수: {len(rows)}")

        tagged_comments = [
            f"[{'찬성' if r[0] == 'T' else '반대'}] {r[1].read().strip()}"
            for r in rows if r[1] is not None
        ]

        # ✅ 댓글이 하나도 없을 경우: 요약 삭제
        if not tagged_comments:
            print("🗑️ 댓글 없음 → 요약 삭제")
            cur.execute("DELETE FROM DISCUSSION_SUMMARY WHERE DISCUSSION_ID = :id", {"id": discussion_id})
            conn.commit()
            conn.close()
            return {"message": "댓글 없음 → 요약 삭제 완료"}

        # 2️⃣ GPT 요약 생성
        try:
            summary = generate_summary(tagged_comments)
            print(f"🧠 GPT 요약 결과:\n{summary}")
        except Exception as gpt_err:
            print(f"❌ GPT 호출 실패: {gpt_err}")
            conn.close()
            return {"message": "GPT 요약 실패"}

        # 3️⃣ DB MERGE
        try:
            cur.setinputsizes(summary=cx_Oracle.CLOB)
            cur.execute("""
                MERGE INTO DISCUSSION_SUMMARY ds
                USING (SELECT :id AS DISCUSSION_ID FROM dual) d
                ON (ds.DISCUSSION_ID = d.DISCUSSION_ID)
                WHEN MATCHED THEN
                    UPDATE SET ds.SUMMARY = :summary, ds.LAST_UPDATED = SYSTIMESTAMP
                WHEN NOT MATCHED THEN
                    INSERT (DISCUSSION_ID, SUMMARY, LAST_UPDATED)
                    VALUES (:id, :summary, SYSTIMESTAMP)
            """, {"id": discussion_id, "summary": summary})
            conn.commit()
            print("✅ DB 저장 성공")
        except Exception as db_err:
            print(f"❌ DB 저장 실패: {db_err}")
            return {"message": "DB 저장 실패"}

        conn.close()
        return {"message": "요약이 성공적으로 저장되었습니다.", "summary": summary}

    except Exception as e:
        print(f"❌ 전체 처리 실패: {e}")
        return {"message": "요약 처리 중 오류 발생"}

