import difflib

import spacy

nlp = spacy.load('ja_ginza')

# 送り主として採用しない住所
ignore_from_address = []


def extract(text, members):
    doc = nlp(text)

    # 人名タグと住所タグを抽出
    persons = [ent.text for ent in doc.ents if ent.label_ == "Person"]
    froms = [ent.text for ent in doc.ents if ent.label_ == "Postal_Address"]
    # 対象外住所を除く(類似度が高いものがあれば除外)
    froms = [f for f in froms if len(list(filter(lambda x: x < 0.75, calc_similarity(f)))) == 0]

    print(f'persons: {persons}')
    print(f'froms: {froms}')

    # 従業員名簿と一致するものを宛先として扱う
    dst = None
    for person in set(persons):
        if person in members:
            dst = person
            break

    print(f"宛先: {dst}")
    print(f"送り主: {set(froms)}")
    return dst, froms


def calc_similarity(str):
    # 対象外住所との類似度を計算
    return [difflib.SequenceMatcher(None, a, str).ratio() for a in ignore_from_address]
